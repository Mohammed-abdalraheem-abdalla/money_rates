import 'package:currencies/core/utils/currencies_service.dart';
import 'package:currencies/core/utils/rates-service.dart';
import 'package:flutter/material.dart';
import '../core/models/rates_model.dart';
import 'currency_names.dart';
import 'from_any_to_any.dart';
import 'from_usd_to_any.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<RatesModel> rates;
  late Future<Map> allCurrencies;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    setState(() {
      rates = getRates();
      allCurrencies = getCurrencies();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 2,
          //backgroundColor: Colors.white,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              FutureBuilder<Map>(
                  future: allCurrencies,
                  builder: (context, currenciesSnapshot) {
                    if (currenciesSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Card(
                        elevation: 4,
                        child: ListTile(
                            leading: const Icon(Icons.add_chart_outlined),
                            title: const Text('Currency Reference'),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const CurrencyReference()));
                            }),
                      ),
                    );
                  }),
            ],
          ),
        ),
        
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder<RatesModel>(
            future: rates,
            builder: (context, ratesSnapshot) {
              if (ratesSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return Center(
                child: FutureBuilder<Map>(
                  future: allCurrencies,
                  builder: (context, currenciesSnapshot) {
                    if (currenciesSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            UsdToAny(
                                rates: ratesSnapshot.data!.rates,
                                currencies: currenciesSnapshot.data!),
                            const SizedBox(
                              height: 20,
                            ),
                            AnyToAny(
                              rates: ratesSnapshot.data!.rates,
                              currencies: currenciesSnapshot.data!,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
