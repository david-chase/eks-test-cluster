Write-Host ""
Write-Host ::: Build EKS Cluster v1 ::: -ForegroundColor Cyan
Write-Host ""

# Read in the config file
$oConfig = Get-Content -Path 'config.ini' | ConvertFrom-StringData

$sTags = '"Owner=' + $oConfig.owner + ",Purpose=" + $oConfig.purpose + ",CreateDate=" + ( Get-Date -format "yyyy.MM.dd" ) + '"'

$sParams = "create cluster --name=" + $oConfig.clustername + `
    " --region=" + $oConfig.region + `
    " --zones=" + $oConfig.region + "a," + $oConfig.region + "b"  + `
    " --tags " + $sTags + `
    " --version " + $oConfig.version + `
    " --write-kubeconfig --set-kubeconfig-context --without-nodegroup --with-oidc --asg-access"

# Show the user the command we're about to execute and let them choose to proceed
Write-Host "eksctl" $sParams`n -ForegroundColor Green
$sResponse = Read-Host -Prompt "Proceed? [Y/n]"
if( $sResponse.ToLower() -eq "n" ) { exit }

# Start a timer
$oStopWatch = New-Object -TypeName System.Diagnostics.Stopwatch
$oStopWatch.Start()

Start-Process "eksctl" -ArgumentList $sParams -Wait -NoNewWindow

# Enable VPC Prefix to significantly increase MaxPodsPerNode 
kubectl set env daemonset aws-node -n kube-system ENABLE_PREFIX_DELEGATION=true

Write-Host

# Stop the timer
$oStopWatch.Stop()
Write-Host `nMinutes elapsed: $oStopWatch.Elapsed.Minutes -ForegroundColor Cyan

# This can take a long time, so make a sound so the user know it's complete
[console]::beep(500,300)