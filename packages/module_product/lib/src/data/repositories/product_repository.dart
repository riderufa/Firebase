import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:module_product/src/data/models/product.dart';

abstract class ProductRepositoryInterface {
  Future<List<Product>> getProducts();
  Future<Product?> addProduct({required String title});
  Future<void> updateProduct(
      {required String id, String? title, bool? isBought});
}

class ProductRepository implements ProductRepositoryInterface {
  final _fireCloud = FirebaseFirestore.instance.collection('products');

  @override
  Future<List<Product>> getProducts() async {
    List<Product> _products = [];
    try {
      final QuerySnapshot<Map<String, dynamic>> _response =
          await _fireCloud.get();
      for (final doc in _response.docs) {
        _products.add(Product.fromFirebaseDoc(doc));
      }
      await Future.delayed(Duration(seconds: 1));
      return _products;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return _products;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Product?> addProduct({required String title}) async {
    try {
      final p = await _fireCloud.add({'title': title, 'isBought': false});
      final product = await _fireCloud.doc(p.id).get();
      await Future.delayed(Duration(seconds: 1));
      return Product.fromFirebaseDoc(product);
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  @override
  Future<Product> updateProduct(
      {required String id, String? title, bool? isBought}) async {
    try {
      Map<String, dynamic> productMap = {
        if (title != null) 'title': title,
        if (isBought != null) 'isBought': isBought,
      };
      await _fireCloud.doc(id).update(productMap);
      final product = await _fireCloud.doc(id).get();
      return Product.fromFirebaseDoc(product);
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
}
