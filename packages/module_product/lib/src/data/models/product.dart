import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required final String id,
    required final String title,
    required final bool isBought,
  }) = _Product;

  factory Product.fromJson(Map<String, Object?> json) =>
      _$ProductFromJson(json);

  factory Product.fromFirebaseDoc(
      DocumentSnapshot<Map<String, dynamic>> queryDocumentSnapshot) {
    return Product.fromJson(queryDocumentSnapshot.dataWithId());
  }
}

extension DocumentSnapshotEx on DocumentSnapshot<Map<String, dynamic>> {
  Map<String, dynamic> dataWithId() {
    final data = this.data();
    data!['id'] = this.id;
    return data;
  }
}
