import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_product/src/data/models/catalog.dart';
import 'package:module_product/src/data/models/product.dart';
import 'package:module_product/src/data/repositories/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required this.productRepository})
      : super(ProductsLoading(null)) {
    on<ProductEvent>((event, emit) async {
      switch (event.runtimeType) {
        case GetProducts:
          await _onGetProducts(event, emit);
          break;
        case UpdateProduct:
          await _onUpdateProduct(event as UpdateProduct, emit);
          break;
        case AddProduct:
          await _onAddProduct(event as AddProduct, emit);
          break;
      }
    });
  }

  final ProductRepository productRepository;

  Future<void> _onGetProducts(event, emit) async {
    emit(ProductsLoading(state.catalog));
    try {
      final products = await productRepository.getProducts();
      emit(ProductsLoaded(Catalog(products: products)));
    } catch (_) {
      emit(ProductError(state.catalog));
    }
  }

  Future<void> _onUpdateProduct(UpdateProduct event, emit) async {
    emit(ProductsLoading(state.catalog));
    try {
      final updatedProduct = await productRepository.updateProduct(
          id: event.id, title: event.title, isBought: event.isBought);
      final products = <Product>[];
      for (final product in state.catalog!.products) {
        if (product.id == updatedProduct.id) {
          products.add(updatedProduct);
        } else {
          products.add(product);
        }
      }
      emit(ProductsLoaded(state.catalog!.copyWith(products: products)));
    } catch (_) {
      emit(ProductError(state.catalog));
    }
  }

  Future<void> _onAddProduct(AddProduct event, emit) async {
    emit(ProductsLoading(state.catalog));
    try {
      final newProduct = await productRepository.addProduct(title: event.title);
      final products = new List<Product>.from(state.catalog!.products);
      if (newProduct != null) products.add(newProduct);
      emit(ProductsLoaded(state.catalog!.copyWith(products: products)));
    } catch (_) {
      emit(ProductError(state.catalog));
    }
  }
}
