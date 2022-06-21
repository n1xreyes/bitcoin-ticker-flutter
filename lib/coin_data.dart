import 'dart:convert';
import 'package:flutter/material.dart';
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

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'A0D8876F-3A1C-4A12-8728-570D873082A6';

class CoinData {
  List<Map<String, dynamic>> _coinData = [];

  Future<List> getCoinData(String selectedCurrency) async {
    for (String crypto in cryptoList) {
      //TODO 5: Return a Map of the results instead of a single value.
      String requestURL = '$coinAPIURL/$crypto/$selectedCurrency';
      Map<String, String> headers = {'X-CoinAPI-Key': apiKey};
      http.Response response = await http.get(requestURL, headers: headers);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];
        var mappedData = {
          'crypto': crypto,
          'rate': lastPrice.toStringAsFixed(0)
        };
        _coinData.add(mappedData);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }

    return _coinData;
  }
}
