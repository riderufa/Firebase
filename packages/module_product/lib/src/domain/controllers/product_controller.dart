import 'package:module_product/module_product.dart';

abstract class ProductControllerInterface {
  void getProducts();
  void updateProduct({required String id, String? title, bool? isBought});
  void addProduct({required String title});
  ProductState get state;
}

class ProductController implements ProductControllerInterface {
  final ProductBloc _bloc;

  const ProductController({required ProductBloc bloc}) : _bloc = bloc;

  @override
  void getProducts() => _bloc.add(GetProducts());

  @override
  ProductState get state => _bloc.state;

  @override
  void updateProduct({required String id, String? title, bool? isBought}) =>
      _bloc.add(UpdateProduct(id: id, title: title, isBought: isBought));

  @override
  void addProduct({required String title}) =>
      _bloc.add(AddProduct(title: title));
}
