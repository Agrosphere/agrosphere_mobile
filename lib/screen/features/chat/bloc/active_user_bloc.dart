import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:late_blight/model/user.dart';

class ActiveUserBloc extends Cubit<List<User>> {
  ActiveUserBloc() : super([]);

  void addActiveUser(User user) {
    final userList = state;
    userList.add(user);
    emit(userList);
  }

  void users(List<User> users) {
    emit(users);
  }
}
