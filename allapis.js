import http from 'k6/http';
import { check, sleep } from 'k6';
import { Trend, Rate } from 'k6/metrics';

const listErrorRate = new Rate('List Catalog errors');
const createErrorRate = new Rate('Create Organization errors');
const CatalogTrend = new Trend('Catalog Trend');
const WebCatalogTrend = new Trend('Web Catalog Trend');
const WeatherTrend = new Trend('Weather Trend');

export default function () {
  const requests = {
    'Catalog': {
      method: 'GET',
      url: 'https://apimscusshad1.azure-api.net/cat/Catalog'
    },
    'WebCatalog': {
      method: 'GET',
      url: 'https://apimscusshad1.azure-api.net/webcatalog/product'
    },
    'Weather': {
      method: 'GET',
      url: 'https://apimscusshad1.azure-api.net/api/weatherforecast'
    }
  };

  const responses = http.batch(requests);
  const catalogResp = responses['Catalog'];
  const wcatalogResp = responses['WebCatalog'];
  //const weatherResp = responses['Weather'];

  check(catalogResp, {
    'status is 200' : (r) => r.status == 200,
  }) || listErrorRate.add(1);

  CatalogTrend.add(catalogResp.timings.duration);

  check(wcatalogResp, {
    'status is 200' : (r) => r.status == 200,
  }) || listErrorRate.add(1);

  WebCatalogTrend.add(wcatalogResp.timings.duration);

  sleep(1);

}
