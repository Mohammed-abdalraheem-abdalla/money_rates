import 'package:http/http.dart' as http;
import '../models/rates_model.dart';
import 'constants.dart';

Future<RatesModel> getRates() async{
  var url = "https://openexchangerates.org/api/latest.json?"
      "app_id=$appKey"
      "&base=USD&prettyprint=false&show_alternative=false";
  var response = await http.get(Uri.parse(url));
  final result = ratesModelFromJson(response.body);
  return result;
}