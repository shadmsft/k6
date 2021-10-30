docker pull loadimpact/k6

k6 run -vus 100 --duration 240m .\test.js

$ docker pull loadimpact/k6

Using default tag: latest
latest: Pulling from loadimpact/k6
<<omitted>>
docker.io/loadimpact/k6:lates

az group create -n k6 -l southcentralus
az container create -g k6 -n loadtest --image loadimpact/k6 --command-line "k6 run --vus 200 --duration 240m raw.githubusercontent.com/shadmsft/k6/main/test.js" --restart-policy Never
az container logs -g k6 -n loadtest --follow