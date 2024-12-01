import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/screen/login/login_bloc.dart';
import 'package:late_blight/shared_prefs.dart';
import 'package:late_blight/utils/enums.dart';
import 'package:late_blight/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:late_blight/widgets/text_field.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
          label: '${TextUtils.appname}-${TextUtils.login}',
          primaryColor: 0xFF0000,
        ),
      );
    }
    // Size size = MediaQuery.of(context).size;
    Color blueColor = const Color(0xFF2196F3);
    LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    Widget buildMobile() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 25,
          ),
          Center(
            child: SizedBox(
              height: 125,
              width: 125,
              child: Image.asset("assets/logo.png"),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Center(
            child: Text(
              TextUtils.loginPage,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                KrishiTextField(
                  labelText: TextUtils.email,
                  hintText: TextUtils.email,
                  validator: (p0) {
                    if (p0 == null || p0.trim().isEmpty) {
                      return "ईमेल आवश्यक छ";
                    }
                    //check for the email is valid or not
                    if (!checkEmail(p0.trim())) {
                      return "ईमेल अमान्य छ";
                    }
                    return null;
                  },
                  onChanged: (p0) {
                    loginBloc.updateEmail(p0.trim());
                  },
                ),
                KrishiTextField(
                  isPassword: true,
                  validator: (p0) {
                    if (p0 == null || p0.trim().isEmpty) {
                      return "पासवर्ड आवश्यक छ";
                    }
                    return null;
                  },
                  onChanged: (p0) => loginBloc.updatePassword(p0),
                  labelText: TextUtils.password,
                  hintText: TextUtils.password,
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(4.0),
          //   child: TextButton(
          //     style: ButtonStyle(
          //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //         RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(2),
          //         ),
          //       ),
          //     ),
          //     child: Text(
          //       TextUtils.forgotPassword,
          //       style: TextStyle(
          //         fontSize: 16,
          //         color: blueColor,
          //       ),
          //     ),
          //     onPressed: () {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         const SnackBar(
          //           content: Text("Under development"),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          const SizedBox(
            height: 20,
          ),
          BlocConsumer<LoginBloc, LoginBlocModelState>(
            listener: (context, state) {
              switch (state.requestState) {
                case RequestState.success:
                  YajnaKrishiSharePrefs.saveUser(
                    state.loggedInUser!,
                  );
                  Navigator.pushReplacementNamed(context, "/main_app");
                  break;
                case RequestState.fail:
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message ?? "असफल भयो"),
                    ),
                  );
                  loginBloc.idel();
                  break;
                default:
                //do nothing
              }
            },
            builder: (context, state) {
              return Center(
                child: SizedBox(
                  width: 220,
                  child: CupertinoButton(
                    color: blueColor,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        loginBloc.login();
                      }
                    },
                    child: state.requestState == RequestState.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            TextUtils.login,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  TextUtils.dontHaveAccount,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/register");
                  },
                  child: Text(
                    TextUtils.register,
                    style: TextStyle(
                      color: blueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: LayoutBuilder(builder: (context, constraints) {
              return buildMobile();
            }),
          ),
        ),
      ),
    );
  }
}
