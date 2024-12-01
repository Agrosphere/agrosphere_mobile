// cubits/product_cubit.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/config/config.dart';
import 'package:late_blight/model/tarkari_model.dart';
import 'package:late_blight/services/isar_service/kalamati_isar_service.dart';
import 'package:late_blight/utils/enums.dart';

class ProductState {
  final List<VegAndFruit> vegAndFruits;
  final RequestState state;
  final String error;

  ProductState({
    this.vegAndFruits = const [],
    this.state = RequestState.idel,
    this.error = '',
  });

  ProductState copyWith({
    List<VegAndFruit>? vegAndFruits,
    RequestState? state,
    String? error,
  }) {
    return ProductState(
      vegAndFruits: vegAndFruits ?? this.vegAndFruits,
      state: state ?? this.state,
      error: error ?? this.error,
    );
  }
}

class KalimatiTarkariBloc extends Cubit<ProductState> {
  KalimatiTarkariBloc() : super(ProductState());
  KalamatiIsarService kalamatiIsarService = KalamatiIsarService();
  String selectedDate = DateTime.now().toIso8601String().split('T').first;
  void setProducts(List<VegAndFruit> products) {
    emit(state.copyWith(vegAndFruits: products, state: RequestState.success));
  }

  void fetchProducts() async {
    final products = await kalamatiIsarService.getTarkariPrice(selectedDate);
    if (products.isNotEmpty) {
      emit(state.copyWith(vegAndFruits: products, state: RequestState.success));
    } else {
      _fetchProducts();
    }
  }

  Future<void> _fetchProducts() async {
    // if (state.vegAndFruits.isNotEmpty) return;
    emit(state.copyWith(state: RequestState.loading));

    try {
      final response = await API.getWithFullUrl(
        '${Config.kalimatiTarkari}kalimati_tarkari',
      );
      KalamatiIsarService kalamatiIsarService = KalamatiIsarService();
      if (response.statusCode == 200) {
        debugPrint('fetchProducts');
        List<VegAndFruit> products =
            List.from(response.data.map((json) => VegAndFruit.fromJson(json)));
        // print(products);
        //save to the db
        debugPrint('Save to the db');
        await kalamatiIsarService.addTarkariPrice(products);
        //emit the state
        emit(ProductState(
          vegAndFruits: List.from(products),
          state: RequestState.success,
        ));
      } else {
        emit(state.copyWith(state: RequestState.fail, error: 'Failed to load'));
      }
    } on DioException catch (e) {
      if (e.response!.statusCode! >= 500) {
        emit(state.copyWith(state: RequestState.fail, error: 'Server error'));
      } else {
        emit(state.copyWith(
            state: RequestState.fail, error: "SOmething went wrong"));
      }
    } catch (e) {
      emit(state.copyWith(
          state: RequestState.fail, error: "Something went wrong"));
    }
  }
}
