import 'package:currencies/core/models/all_currencies_model.dart';

import '../models/all_currencies_model.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

  Future<Map> getCurrencies() async{
  var url = "https://openexchangerates.org/api/currencies.json?"
      "prettyprint=false&show_alternative=false&show_inactive=false"
      "&app_id=$appKey";
  var response = await http.get(Uri.parse(url));
  final allCurrencies = allCurrenciesFromJson(response.body);
  return allCurrencies;
}