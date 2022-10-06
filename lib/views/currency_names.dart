import 'package:flutter/material.dart';

import '../core/utils/currencies_service.dart';

class CurrencyReference extends StatefulWidget {
  const CurrencyReference({Key? key,}) : super(key: key);

  @override
  State<CurrencyReference> createState() => _CurrencyReferenceState();
}

class _CurrencyReferenceState extends State<CurrencyReference> {
  late Future<Map> allCurrencies;

  @override
  void initState() {
    allCurrencies = getCurrencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       body: FutureBuilder<Map>(
    future: allCurrencies,
    builder: (context,currenciesSnapshot) {
      if (currenciesSnapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      return ListView.builder(
        itemBuilder: (context, index) {
          return  Text('${currenciesSnapshot.data?.keys}');
        },
      );
    }
    ),
    ),
    );
  }
}
