import 'package:flutter/src/widgets/framework.dart';
import 'package:module_product/src/application/scopes/bloc_scope.dart';
import 'package:module_product/src/data/repositories/product_repository.dart';
import 'package:module_product/src/domain/blocs/product_bloc/product_bloc.dart';
import 'package:module_product/src/domain/controllers/product_controller.dart';
import 'package:provider/provider.dart';

class ProductScope extends BlocScope<ProductBloc, ProductControllerInterface> {
  ProductScope({super.child});

  static ProductControllerInterface of(BuildContext context,
          {bool listen = false}) =>
      Provider.of<ProductControllerInterface>(context, listen: listen);

  @override
  createBloc(BuildContext context) {
    return ProductBloc(
      productRepository: ProductRepository(),
    );
  }

  @override
  createController(bloc) {
    return ProductController(bloc: bloc);
  }
}
