import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final Map rates;

  const DetailsPage({Key? key, required this.rates}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List currencies = rates.keys.toList();
    List exchangeRates = rates.values.toList();

    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: currencies.length,
          itemBuilder: (c, i) {
            String currency = currencies[i].toString().toUpperCase();
            String exchangeRate = exchangeRates[i].toString();
            return ListTile(
              title: Text(
                "$currency: $exchangeRate",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
