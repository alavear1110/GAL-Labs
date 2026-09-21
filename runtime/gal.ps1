param(
 [Parameter(Position=0)]
 [ValidateSet("init","status","sync","recalc-readiness","validate-state","help")]
 [string]$Command="help"
)
$ErrorActionPreference="Stop"
$Version="0.5.0"
$Root=(Get-Location).Path
$Gal=Join-Path $Root ".gal"
$Pkg=Split-Path -Parent $MyInvocation.MyCommand.Path
$SF=Join-Path $Gal "state\project-state.json"

function LoadState {
 if(!(Test-Path $SF)){throw "GAL not initialized"}
 Get-Content $SF -Raw | ConvertFrom-Json
}

function SaveState($x){
 $x | ConvertTo-Json -Depth 25 | Set-Content -Encoding UTF8 $SF
}

function Header {
 @(
   "> GENERATED FILE — DO NOT EDIT DIRECTLY",
   "> Source: .gal/state/project-state.json",
   ""
 )
}

function Init {
 New-Item -ItemType Directory -Force (Join-Path $Gal "state") | Out-Null
 New-Item -ItemType Directory -Force (Join-Path $Gal "context") | Out-Null
 Copy-Item (Join-Path $Pkg "templates\project-state.json") $SF -Force
 Copy-Item (Join-Path $Pkg "templates\config.json") (Join-Path $Gal "state\config.json") -Force
 Sync
 Write-Host "GAL v$Version initialized." -ForegroundColor Green
}

function Sync {
 $x=LoadState
 $c=Join-Path $Gal "context"
 New-Item -ItemType Directory -Force $c | Out-Null

 $l=Header
 $l+=@("# GAL Project Context","","## Confirmed")
 foreach($v in $x.context.confirmed_business_rules){$l+="- $v"}
 Set-Content -Encoding UTF8 (Join-Path $c "context.md") $l

 $l=Header
 $l+=@("# GAL Open Questions","", "| ID | Type | Priority | Disposition | Question |","|---|---|---|---|---|")
 foreach($q in $x.open_questions){
   $l+="| $($q.id) | $($q.question_type) | $($q.priority) | $($q.disposition) | $($q.question) |"
 }
 Set-Content -Encoding UTF8 (Join-Path $c "open-questions.md") $l

 $l=Header
 $l+=@("# GAL Readiness","", "| Stage | Status | Reason |","|---|---|---|")
 foreach($n in @("discovery","stakeholder_review","development","qa_test_design")){
   $r=$x.readiness.$n
   $l+="| $n | $($r.status) | $($r.reason) |"
 }
 Set-Content -Encoding UTF8 (Join-Path $c "readiness.md") $l

 Write-Host "GAL generated views synchronized." -ForegroundColor Green
}

function RecalcReadiness {
 $x=LoadState
 $active=@($x.open_questions | Where-Object {
   $_.question_type -eq "REQUIRED_CLARIFICATION" -and
   $_.priority -eq "IMPORTANT" -and
   $_.status -eq "OPEN" -and
   $_.disposition -eq "ACTIVE"
 }).Count

 $blocking=@($x.decision_debt | Where-Object {$_.priority -eq "BLOCKING"}).Count
 $a=$x.artifacts.requirements
 $ok=$a.exists -and $a.gal_scrubbed -and $a.reconciled -and $a.provenance_validated -and $a.state_validated -and $x.last_validation.executed -and $x.last_validation.passed

 if($x.project_name -eq "Uninitialized Project"){
   $x.readiness.discovery.status="NOT_READY"
   $x.readiness.discovery.reason="No project context yet"
 } elseif($active){
   $x.readiness.discovery.status="READY_WITH_GAPS"
   $x.readiness.discovery.reason="$active active important clarification question(s)"
 } else {
   $x.readiness.discovery.status="READY"
   $x.readiness.discovery.reason="Project context established with no active important clarification questions"
 }

 if(!$ok){
   $x.readiness.stakeholder_review.status="NOT_READY"
   $x.readiness.stakeholder_review.reason="Requirements artifact has not passed all review gates"
 } elseif($active -or $blocking){
   $x.readiness.stakeholder_review.status="READY_WITH_GAPS"
   $x.readiness.stakeholder_review.reason="$active active important clarification question(s); $blocking blocking decision-debt item(s)"
 } else {
   $x.readiness.stakeholder_review.status="READY"
   $x.readiness.stakeholder_review.reason="Requirements artifact passed review gates with no active important clarifications or blocking decision debt"
 }

 if(!$ok){
   $x.readiness.development.status="NOT_READY"
   $x.readiness.development.reason="Requirements artifact has not passed all review gates"
 } elseif($blocking){
   $x.readiness.development.status="NOT_READY"
   $x.readiness.development.reason="$blocking blocking decision-debt item(s)"
 } else {
   $x.readiness.development.status="READY_WITH_GAPS"
   $x.readiness.development.reason=if($active){"Requirements artifact passed review gates; $active active important clarification question(s) remain"}else{"Requirements artifact passed review gates; development readiness remains conservative until phase-specific READY criteria are defined"}
 }

 if(!$ok){
   $x.readiness.qa_test_design.status="NOT_READY"
   $x.readiness.qa_test_design.reason="Requirements artifact has not passed all review gates"
 } else {
   $x.readiness.qa_test_design.status="READY_WITH_GAPS"
   $x.readiness.qa_test_design.reason=if($active -or $blocking){"Requirements artifact passed review gates; $active active important clarification question(s) and $blocking blocking decision-debt item(s) remain"}else{"Requirements artifact passed review gates; QA readiness remains conservative until phase-specific READY criteria are defined"}
 }

 SaveState $x
 Write-Host "GAL readiness recalculated." -ForegroundColor Green
}

function ValidateState {
 $x=LoadState
 $e=@()

 if($x.gal_version -ne "0.5.0"){$e+="Invalid gal_version"}
 if(@("UNSET","QUICK","STANDARD","DEEP") -notcontains $x.gal_mode){$e+="Invalid gal_mode"}
 if(@("EXPLORE","DRAFT","REVIEW") -notcontains $x.task_mode){$e+="Invalid task_mode"}
 if(@("NOT_STARTED","IN_PROGRESS","SUFFICIENT","SUFFICIENT_WITH_GAPS") -notcontains $x.intake_status){$e+="Invalid intake_status"}
 if(@("GUIDE","ALIGN","LEAD") -notcontains $x.current_phase){$e+="Invalid current_phase"}

 foreach($q in $x.open_questions){
   if(@("REQUIRED_CLARIFICATION","OPTIONAL_DISCOVERY") -notcontains $q.question_type){$e+="Invalid question type"}
   if(@("IMPORTANT","LATER") -notcontains $q.priority){$e+="Invalid question priority"}
   if($q.status -ne "OPEN"){$e+="Invalid question status"}
   if(@("ACTIVE","DEFERRED") -notcontains $q.disposition){$e+="Invalid question disposition"}
 }

 foreach($d in $x.decision_debt){
   if([string]::IsNullOrWhiteSpace([string]$d.id)){$e+="Invalid decision debt id"}
   if([string]::IsNullOrWhiteSpace([string]$d.decision)){$e+="Invalid decision debt decision"}
   if(@("BLOCKING","NON_BLOCKING") -notcontains $d.priority){$e+="Invalid decision debt priority"}
 }

 $x.last_validation.executed=$true
 $x.last_validation.timestamp=(Get-Date).ToString("o")
 $x.last_validation.errors=@($e)
 $x.last_validation.passed=($e.Count -eq 0)
 $x.artifacts.requirements.state_validated=($e.Count -eq 0)

 if($e.Count){
   $x.artifacts.requirements.reviewable=$false
   SaveState $x
   Write-Host "GAL state validation FAILED" -ForegroundColor Red
   exit 1
 }

 SaveState $x
 Write-Host "GAL state validation passed." -ForegroundColor Green
}

function Status {
 $x=LoadState
 Write-Host "Project=$($x.project_name) Mode=$($x.gal_mode) Intake=$($x.intake_status) Phase=$($x.current_phase)"
}

switch($Command){
 "init"{Init}
 "status"{Status}
 "sync"{Sync}
 "recalc-readiness"{RecalcReadiness}
 "validate-state"{ValidateState}
 default{Write-Host ".\gal.ps1 init | status | sync | recalc-readiness | validate-state"}
}
