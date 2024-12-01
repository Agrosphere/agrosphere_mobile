import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/screen/login/login_bloc.dart';
import 'package:late_blight/screen/register/register_bloc.dart';

getUserBlocProviders() {
  final userProviders = [
    BlocProvider(create: (context) => RegisterBloc()),
    BlocProvider(create: (context) => LoginBloc()),
  ];
  return userProviders;
}
