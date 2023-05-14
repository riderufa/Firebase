part of 'product_bloc.dart';

abstract class ProductState {
  const ProductState(this.catalog);

  final Catalog? catalog;
}

class ProductsLoading extends ProductState {
  const ProductsLoading(super.catalog);
}

class ProductsLoaded extends ProductState {
  const ProductsLoaded(this.catalog) : super(catalog);

  final Catalog catalog;
}

class ProductError extends ProductState {
  const ProductError(super.catalog);
}
