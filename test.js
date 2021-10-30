import http from 'k6/http';
import { sleep } from 'k6';

export default function () {
  http.get('https://apimscusshad1.azure-api.net/cat/Catalog');
  http.get('https://apimscusshad1.azure-api.net/api/weatherforecast');
  http.get('https://apimscusshad1.azure-api.net/webcatalog/product');
  sleep(1);
}

//https://azureserverless.com/post/load-testing-with-k6-on-aci
