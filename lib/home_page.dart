import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ulesson_http/models/currency_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const String apiKey = '42db92acba22072dbc39cb83';
  Currency _targetCurrency = Currency(name: 'USD', exchangeValue: 1);
  List<Currency> _currencies = [];
  bool _isLoading = false;

  _loadData() async {
    setState(() => _isLoading = true);



    Uri url = Uri.parse('https://v6.exchangerate-api.com/v6/$apiKey/latest/${_targetCurrency.name}');


    final response = await http.get(url);
    Map<String, dynamic> map = jsonDecode(response.body);
    CurrencyResponse currencyResponse = CurrencyResponse.fromJson(map);
    _currencies = currencyResponse.conversionRates ?? [];



    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_targetCurrency.name),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : _currencies.isEmpty
              ? const Center(child: Text('No Data!'))
              : SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      _currencies.length,
                      (index) {
                        Currency currency = _currencies[index];
                        return Card(
                          elevation: 1,
                          child: ListTile(
                            title: Text(currency.name),
                            trailing: Text(
                              currency.exchangeValue.toStringAsFixed(2),
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _loadData(),
        child: const Icon(Icons.api),
      ),
    );
  }
}
