import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingBloc extends Cubit<int> {
  OnBoardingBloc() : super(0);
  void update(int page) {
    emit(page);
  }
}
