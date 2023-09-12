import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ulesson_http/models/currency_model.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const String _apiKey = "42db92acba22072dbc39cb83";
  bool _isLoading = false;
  List<Currency> _currencies = [];
  Currency targetCurrency = Currency(name: 'USD', exchangeValue: 1);

  _loadData() async {
    setState(() => _isLoading = true);
    Uri url = Uri.parse('https://v6.exchangerate-api.com/v6/$_apiKey/latest/${targetCurrency.name}');
    final result = await http.get(url);
    final json = jsonDecode(result.body);
    if (json['conversion_rates'] != null) {
      (json['conversion_rates'] as Map).forEach((key, value) {
        _currencies.add(
          Currency(
            name: key,
            exchangeValue: value,
          ),
        );
      });
    }
    setState(() => _isLoading = false);
  }

  _clear() async {
    setState(() => _isLoading = true);
    _currencies = [];
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(targetCurrency.name),
        actions: [
          IconButton(
            onPressed: () async => _clear(),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : _currencies.isEmpty
              ? const Center(child: Text('No Data'))
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => _loadData(),
        child: const Icon(Icons.api),
      ),
    );
  }
}
