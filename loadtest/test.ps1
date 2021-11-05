$currentTime = Get-Date -Format "yyyymmddHHmmss"
$logFile = "./lr-$currentTime.log"

Log-Message "Test Starting"
function Log-Message
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$LogMessage
    )

    $stamp = Get-Date -Format yyyy-mm-dd-HH:mm:ss
    $message = "$stamp $LogMessage"
    Write-Output ("{0} - {1}" -f (Get-Date), $LogMessage)
    Add-Content $logFile -Value $message
}


for($l = 0;$l -lt 12; $l++)
{
    Log-Message "Outer Loop $l"
    $aciCount = 40

    for($i = 0;$i -lt $aciCount;$i++)
    {
        Log-Message "Createing ACI $i"
        az container create -g k6 -n k6load$i --image loadimpact/k6 --command-line "k6 run --vus 400 --duration 120m raw.githubusercontent.com/shadmsft/k6/main/loadtest/test.js" --restart-policy Never
    }
    Log-Message "Sleeping for an hour after generating traffic."
    Start-Sleep -Seconds 3600

    for($i = 0; $i -lt $aciCount;$i++)
    {
        Log-Message "Deleting ACI $i"
        az container delete --resource-group k6 --name k6load$i -y
    }
    Log-Message "Sleeping for an hour after stopping traffic."
    Start-Sleep -Seconds 3600
}

Log-Message "Test Ended"


