import 'package:http/http.dart' as http;
import 'dart:convert';

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


const List<String> cryptoList = ['bitcoin', 'ethereum', 'litecoin'];


class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<dynamic, dynamic> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestURL =
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=$selectedCurrency&ids=$crypto';
      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var price = decodedData[0]['current_price'];
        cryptoPrices[crypto] = price;
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}