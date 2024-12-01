import 'package:flutter_bloc/flutter_bloc.dart';

class NavbarBloc extends Cubit<int> {
  NavbarBloc() : super(0);

  void update(int pageNo) {
    emit(pageNo);
  }
}
