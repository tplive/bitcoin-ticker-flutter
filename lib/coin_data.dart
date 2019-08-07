import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const url = 'https://apiv2.bitcoinaverage.com/indices/global/ticker';

class CoinData {

  Future getData(String currency) async {

    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      print(crypto);

      http.Response res = await http.get('$url/$crypto$currency');

      if (res.statusCode == 200) {
        var decodedData = jsonDecode(res.body);
        double lastPrice = decodedData['last'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(2);
      } else {
        throw 'Problem with the get request, status: ${res.statusCode.toString()}';
      }
    }

    return cryptoPrices;
  }
}
