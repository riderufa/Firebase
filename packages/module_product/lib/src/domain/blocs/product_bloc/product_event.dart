part of 'product_bloc.dart';

abstract class ProductEvent {
  const ProductEvent();
}

class GetProducts extends ProductEvent {}

class AddProduct extends ProductEvent {
  final String title;

  AddProduct({required this.title});
}

class UpdateProduct extends ProductEvent {
  final String id;
  final String? title;
  final bool? isBought;

  UpdateProduct({
    required this.id,
    this.title,
    this.isBought,
  });
}
