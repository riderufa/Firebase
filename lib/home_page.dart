import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:module_product/module_product.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controller;
  final storage = FirebaseStorage.instance;

  @override
  void initState() {
    _controller = TextEditingController();
    ProductScope.of(context).getProducts();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 25,
          width: 50,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: FutureBuilder<String>(
              future: storage.ref('it.png').getDownloadURL(),
              builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.done
                      ? Image.network(
                          snapshot.data!,
                          fit: BoxFit.scaleDown,
                        )
                      : const SizedBox(),
            ),
          ),
        ),
      ),
      body: Builder(builder: (context) {
        final state = ProductScope.of(context, listen: true).state;
        if (state.catalog == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: state.catalog!.products.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = state.catalog!.products[index];
                  return Card(
                    child: ListTile(
                      title: Text(product.title),
                      trailing: Checkbox(
                        value: product.isBought,
                        onChanged: (value) =>
                            ProductScope.of(context).updateProduct(
                          id: product.id,
                          isBought: value!,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  controller: _controller,
                  onSubmitted: (value) {
                    ProductScope.of(context).addProduct(title: value);
                    _controller.clear();
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter new product',
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
