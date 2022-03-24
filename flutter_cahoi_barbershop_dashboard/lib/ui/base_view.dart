import 'package:admin/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Function(T model)? onModelReady;
  final Function(T model)? onModelDisposed;

  const BaseView(
      {Key? key,
        required this.builder,
        this.onModelReady,
        this.onModelDisposed})
      : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends ChangeNotifier> extends State<BaseView<T>> {
  T model = locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(builder: widget.builder),
    );
  }

  @override
  void dispose() {
    if (widget.onModelDisposed != null) {
      widget.onModelDisposed!(model);
    }
    super.dispose();
  }
}