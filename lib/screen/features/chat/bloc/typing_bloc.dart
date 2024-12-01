import 'package:flutter_bloc/flutter_bloc.dart';

class TypingBloc extends Cubit<Map<String, String>> {
  TypingBloc() : super({});

  void setTyping(String typing, String receiverId) {
    emit({receiverId: typing});
  }
}
