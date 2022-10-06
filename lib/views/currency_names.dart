import 'package:flutter/material.dart';

import '../core/utils/currencies_service.dart';

class CurrencyReference extends StatefulWidget {
  const CurrencyReference({
    Key? key,
  }) : super(key: key);

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
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<Map>(
              future: allCurrencies,
              builder: (context, currenciesSnapshot) {
                if (currenciesSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: currenciesSnapshot.data?.length,
                  itemBuilder: (context, index) {
                    final currencyShort =
                        currenciesSnapshot.data?.keys.toList()[index];
                    final currencyName =
                        currenciesSnapshot.data?.values.toList()[index];

                    return Card(
                      elevation: 5,
                      child: ListTile(
                        leading: Text(
                          '$currencyShort:',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        title: Text('$currencyName',
                            style: const TextStyle(fontSize: 20)),
                      ),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
