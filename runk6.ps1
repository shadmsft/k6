docker pull loadimpact/k6

k6 run -vus 100 --duration 240m .\test.js

$ docker pull loadimpact/k6

Using default tag: latest
latest: Pulling from loadimpact/k6
<<omitted>>
docker.io/loadimpact/k6:lates

rgName=k6; aciName=loadtest
$ az group create -n $rgName -l southcentralus
$ az container create -g $rgName -n $aciName --image loadimpact/k6 --command-line "k6 run github.com/loadimpact/k6/samples/http_get.js" --restart-policy Never
$ az container logs -g $rgName -n $aciName --follow