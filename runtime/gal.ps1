param(
 [Parameter(Position=0)]
 [ValidateSet("init","status","sync","recalc-readiness","validate-state","help")]
 [string]$Command="help"
)
$ErrorActionPreference="Stop"
$Version="0.5.1"
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

 $blockingByStage=@{}
 foreach($stage in @("discovery","stakeholder_review","development","qa_test_design")){
   $blockingByStage[$stage]=@($x.decision_debt | Where-Object {
     $_.priority -eq "BLOCKING" -and @($_.blocks) -contains $stage
   }).Count
 }
 $a=$x.artifacts.requirements
 $ok=$a.exists -and $a.gal_scrubbed -and $a.reconciled -and $a.provenance_validated -and $a.state_validated -and $x.last_validation.executed -and $x.last_validation.passed

 if($x.project_name -eq "Uninitialized Project"){
   $x.readiness.discovery.status="NOT_READY"
   $x.readiness.discovery.reason="No project context yet"
 } elseif($blockingByStage["discovery"]){
   $x.readiness.discovery.status="NOT_READY"
   $x.readiness.discovery.reason="$($blockingByStage["discovery"]) decision-debt item(s) block discovery"
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
 } elseif($blockingByStage["stakeholder_review"]){
   $x.readiness.stakeholder_review.status="NOT_READY"
   $x.readiness.stakeholder_review.reason="$($blockingByStage["stakeholder_review"]) decision-debt item(s) block stakeholder review"
 } elseif($active){
   $x.readiness.stakeholder_review.status="READY_WITH_GAPS"
   $x.readiness.stakeholder_review.reason="$active active important clarification question(s)"
 } else {
   $x.readiness.stakeholder_review.status="READY"
   $x.readiness.stakeholder_review.reason="Requirements artifact passed review gates with no active important clarifications or blocking decision debt"
 }

 if(!$ok){
   $x.readiness.development.status="NOT_READY"
   $x.readiness.development.reason="Requirements artifact has not passed all review gates"
 } elseif($blockingByStage["development"]){
   $x.readiness.development.status="NOT_READY"
   $x.readiness.development.reason="$($blockingByStage["development"]) decision-debt item(s) block development"
 } else {
   $x.readiness.development.status="READY_WITH_GAPS"
   $x.readiness.development.reason=if($active){"Requirements artifact passed review gates; $active active important clarification question(s) remain"}else{"Requirements artifact passed review gates; development readiness remains conservative until phase-specific READY criteria are defined"}
 }

 if(!$ok){
   $x.readiness.qa_test_design.status="NOT_READY"
   $x.readiness.qa_test_design.reason="Requirements artifact has not passed all review gates"
 } else {
   $x.readiness.qa_test_design.status="READY_WITH_GAPS"
   $x.readiness.qa_test_design.reason=if($blockingByStage["qa_test_design"]){"Requirements artifact passed review gates; $($blockingByStage["qa_test_design"]) decision-debt item(s) block complete QA test design"}elseif($active){"Requirements artifact passed review gates; $active active important clarification question(s) remain"}else{"Requirements artifact passed review gates; QA readiness remains conservative until phase-specific READY criteria are defined"}
 }

 SaveState $x
 Write-Host "GAL readiness recalculated." -ForegroundColor Green
}

function ValidateState {
 $x=LoadState
 $e=@()

 $configFile=Join-Path $Gal "state\config.json"
 $config=$null
 if(!(Test-Path $configFile)){
   $e+="GAL config is missing: .gal/state/config.json"
 } else {
   try {
     $config=Get-Content $configFile -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
   } catch {
     $e+="GAL config could not be read or parsed: $($_.Exception.Message)"
   }
 }

 if($null -ne $config){
   if($config.gal_version -ne $Version){
     $e+="Config GAL version '$($config.gal_version)' does not match runtime GAL version '$Version'"
   }
   if($config.gal_version -ne $x.gal_version){
     $e+="Config GAL version '$($config.gal_version)' does not match project state GAL version '$($x.gal_version)'"
   }
 }
 if($x.gal_version -ne $Version){
   $e+="Project state GAL version '$($x.gal_version)' does not match runtime GAL version '$Version'"
 }

 # Structural validation is owned by the canonical JSON Schema.
 $schemaFile=Join-Path $Pkg "schemas\project-state.schema.json"
 try {
   $schemaOk=Test-Json -Path $SF -SchemaFile $schemaFile -ErrorAction Stop
   if(!$schemaOk){$e+="Project state does not conform to project-state.schema.json"}
 } catch {
   $e+="Project state schema validation failed: $($_.Exception.Message)"
 }

 # GAL semantic/cross-field invariants belong here when they cannot be
 # expressed cleanly by JSON Schema alone.
 $questionIds=@($x.open_questions | ForEach-Object {$_.id})
 foreach($d in @($x.decision_debt)){
   if($null -ne $d.source_question_id -and $d.source_question_id -notin $questionIds){
     $e+="Decision debt '$($d.id)' references source question '$($d.source_question_id)' that is not present in open_questions"
   }
 }

 $x.last_validation.executed=$true
 $x.last_validation.timestamp=(Get-Date).ToString("o")
 $x.last_validation.errors=@($e)
 $x.last_validation.passed=($e.Count -eq 0)
 $x.artifacts.requirements.state_validated=($e.Count -eq 0)

 if($e.Count){
   SaveState $x
   Write-Host "GAL state validation FAILED" -ForegroundColor Red
   return $false
 }

 SaveState $x
 Write-Host "GAL state validation passed." -ForegroundColor Green
 return $true
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
 "validate-state"{
   $validationPassed=ValidateState
   if($validationPassed){exit 0}else{exit 1}
 }
 default{Write-Host ".\gal.ps1 init | status | sync | recalc-readiness | validate-state"}
}
