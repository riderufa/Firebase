// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Catalog _$$_CatalogFromJson(Map<String, dynamic> json) => _$_Catalog(
      products: (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_CatalogToJson(_$_Catalog instance) =>
    <String, dynamic>{
      'products': instance.products,
    };
