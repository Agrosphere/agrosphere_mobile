import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/screen/login/login_bloc.dart';
import 'package:late_blight/screen/register/register_bloc.dart';
import 'package:late_blight/shared_prefs.dart';
import 'package:late_blight/utils/enums.dart';
import 'package:late_blight/utils/utils.dart';
import 'package:late_blight/widgets/text_field.dart';

Color blueColor = const Color(0xFF2196F3);

class Register extends StatelessWidget {
  Register({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
          label: '${TextUtils.appname}-${TextUtils.register}',
          primaryColor: 0xFF0000,
        ),
      );
    }
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return mobileScreen(context);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget mobileScreen(BuildContext context) {
    RegisterBloc registerBloc = BlocProvider.of<RegisterBloc>(context);
    return Column(
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
            TextUtils.registerPage,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        _buildForm(context),
        const SizedBox(
          height: 20,
        ),
        BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            switch (state.requestState) {
              case RequestState.success:
                YajnaKrishiSharePrefs.saveUser(state.user);
                BlocProvider.of<LoginBloc>(context).setLoggedInUser(state.user);
                Navigator.pushReplacementNamed(context, "/main_app");
                break;
              case RequestState.fail:
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
                registerBloc.idel();
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
                      registerBloc.register();
                    }
                  },
                  child: state.requestState == RequestState.loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Text(
                          TextUtils.register,
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
        _alreadyHaveAnAccount(context)
      ],
    );
  }

  Widget _alreadyHaveAnAccount(BuildContext context) {
    Color blueColor = const Color(0xFF2196F3);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            TextUtils.alreadyHaveAnAccount,
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
              Navigator.pushNamed(context, "/login");
            },
            child: Text(
              TextUtils.login,
              style: TextStyle(
                color: blueColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    RegisterBloc registerBloc = BlocProvider.of<RegisterBloc>(context);
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          KrishiTextField(
            keyboardType: TextInputType.name,
            hintText: TextUtils.firstname,
            labelText: TextUtils.firstname,
            validator: (p0) {
              if (p0 == null || p0.trim().isEmpty) {
                return "पहिलो नाम आवश्यक छ";
              }
              return null;
            },
            onChanged: (value) {
              registerBloc.updateFirstName(value);
            },
          ),
          KrishiTextField(
            keyboardType: TextInputType.name,
            onChanged: (value) {
              registerBloc.updateLastName(value);
            },
            validator: (p0) {
              if (p0 == null || p0.trim().isEmpty) {
                return "कृपया थर आवश्यक छ";
              }
              return null;
            },
            hintText: TextUtils.lastname,
            labelText: TextUtils.lastname,
          ),
          KrishiTextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              registerBloc.updateEmail(value.trim());
            },
            validator: (p0) {
              if (p0 == null || p0.trim().isEmpty) {
                return "कृपया ईमेल आवश्यक छ";
              }
              if (!checkEmail(p0.trim())) {
                return "ईमेल अमान्य छ";
              }
              return null;
            },
            hintText: TextUtils.email,
            labelText: TextUtils.email,
          ),
          KrishiTextField(
            keyboardType: TextInputType.text,
            isPassword: true,
            onChanged: (value) {
              registerBloc.updatePassword(value);
            },
            validator: passwordValidator,
            hintText: TextUtils.password,
            labelText: TextUtils.password,
          ),
          KrishiTextField(
            keyboardType: TextInputType.text,
            isPassword: true,
            validator: (p0) {
              if (p0 == null || p0.trim().isEmpty) {
                return "कृपया पासवर्ड पुष्टि आवश्यक छ";
              }
              if (p0.length <= 6) {
                return "पासवर्डको लम्बाई ६ भन्दा बढी हुनुपर्छ";
              }
              if (p0 != registerBloc.state.user.password) {
                return "पासवर्ड एकसाथ नै हुनुपर्छ";
              }
              return null;
            },
            onChanged: (value) {
              registerBloc.updateConfirmPassword(value);
            },
            hintText: TextUtils.confirmPassword,
            labelText: TextUtils.confirmPassword,
          ),
        ],
      ),
    );
  }
}
