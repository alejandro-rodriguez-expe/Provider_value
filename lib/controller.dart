import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:provider_value/api.dart';
import 'package:provider_value/product.dart';

part 'controller.freezed.dart';

@freezed
abstract class State with _$State {
  const factory State.loading() = _Loading;

  const factory State.failed() = _Failed;

  const factory State.loaded({required List<Product> products}) = Loaded;
}

class Controller extends ValueNotifier<State> {
  Controller(this.api) : super(State.loading());
  final Api api;

  Future<void> loadProducts() async {
    try {
      final products = await api.getProducts();
      value = State.loaded(products: products);
    } catch (e) {
      value = const State.failed();
    }
  }
}
