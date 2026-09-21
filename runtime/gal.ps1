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
   $_.disposition -eq "ACTIVE"
 }).Count

 $blocking=@($x.decision_debt | Where-Object {$_.priority -eq "BLOCKING"}).Count
 $a=$x.artifacts.requirements
 $ok=$a.exists -and $a.gal_scrubbed -and $a.reconciled -and $a.provenance_validated -and $a.state_validated -and $x.last_validation.executed -and $x.last_validation.passed

 $x.readiness.discovery.status=if($x.project_name -ne "Uninitialized Project"){if($active){"READY_WITH_GAPS"}else{"READY"}}else{"NOT_READY"}
 $x.readiness.stakeholder_review.status=if($ok){if($active -or $blocking){"READY_WITH_GAPS"}else{"READY"}}else{"NOT_READY"}
 $x.readiness.development.status=if($ok -and !$blocking){"READY_WITH_GAPS"}else{"NOT_READY"}
 $x.readiness.qa_test_design.status=if($ok){"READY_WITH_GAPS"}else{"NOT_READY"}

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
   if($q.status -ne "OPEN"){$e+="Invalid question status"}
   if(@("ACTIVE","DEFERRED") -notcontains $q.disposition){$e+="Invalid question disposition"}
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
