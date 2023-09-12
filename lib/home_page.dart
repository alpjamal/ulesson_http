import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            1,
            (index) {
              return const Card(
                elevation: 1,
                child: ListTile(
                  title: Text('Usd'),
                  trailing: Text(
                    '0',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.api),
      ),
    );
  }
}
