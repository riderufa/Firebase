import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

abstract class BlocScope<B extends Bloc, C> extends SingleChildStatelessWidget {
  const BlocScope({
    super.key,
    this.closeBlocOnDispose = true,
    super.child,
  });

  @protected
  @visibleForOverriding
  C createController(B bloc);

  @protected
  @visibleForOverriding
  B createBloc(BuildContext context);

  final bool closeBlocOnDispose;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Provider<B>(
      create: createBloc,
      dispose: (context, bloc) => closeBlocOnDispose ? bloc.close() : null,
      child: Builder(builder: (context) {
        return InheritedProvider<C>(
          create: (context) => createController(context.read()),
          startListening: (e, c) => _startListening(e, context.read()),
          child: child,
        );
      }),
    );
  }

  VoidCallback _startListening(InheritedContext e, B bloc) {
    final subscription = bloc.stream.listen(
      (dynamic _) => e.markNeedsNotifyDependents(),
    );
    return subscription.cancel;
  }
}
