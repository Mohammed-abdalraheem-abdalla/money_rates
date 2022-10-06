
// to convert from dollar to any currency
String usdEq(Map rates, String dollars, String currencies){
  String result = ((rates[currencies] * double.parse(dollars)).toStringAsFixed(2)).toString();
  return result;
}
// to convert from an currency to another
String anyToAnyEq(Map rates, String amount, String base, String toThisCurrency){
String result = (double.parse(amount) /
                 rates[base] *
                  rates[toThisCurrency])
    .toStringAsFixed(2)
    .toString();
    return result;
}