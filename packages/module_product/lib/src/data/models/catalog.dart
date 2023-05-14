import 'package:freezed_annotation/freezed_annotation.dart';

import 'product.dart';

part 'catalog.freezed.dart';
part 'catalog.g.dart';

@freezed
class Catalog with _$Catalog {
  const factory Catalog({
    required final List<Product> products,
  }) = _Catalog;

  factory Catalog.fromJson(Map<String, Object?> json) =>
      _$CatalogFromJson(json);
}
