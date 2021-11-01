#az group create -n k6 -l southcentralus

for($l = 0;$l -lt 2; $l++)
{
    $aciCount = 30

    for($i = 0;$i -lt $aciCount;$i++)
    {
        az container create -g k6 -n k6load$i --image loadimpact/k6 --command-line "k6 run --vus 300 --duration 120m raw.githubusercontent.com/shadmsft/k6/main/test.js" --restart-policy Never
    }

    Start-Sleep -Seconds 3600

    for($i = 0; $i -lt $aciCount;$i++)
    {
        az container delete --resource-group k6 --name k6load$i -y
    }

    Start-Sleep -Seconds 3600
}