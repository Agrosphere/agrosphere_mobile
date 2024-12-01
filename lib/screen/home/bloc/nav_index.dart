import 'package:flutter_bloc/flutter_bloc.dart';

class NavIndexBloc extends Cubit<int> {
  NavIndexBloc() : super(0);

  void updateIndex(int index) {
    emit(index);
  }
}
