import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/config/config.dart';
import 'package:late_blight/screen/diseases/bloc/diseases_bloc.dart';
import 'package:late_blight/screen/insects/bloc/insects_bloc.dart';
import 'package:late_blight/screen/login/login_bloc.dart';
import 'package:late_blight/services/isolate.dart';
import 'package:late_blight/shared_prefs.dart';
import 'package:late_blight/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    loadData();
    setUser();

    Future.delayed(const Duration(seconds: 2), () {
      YajnaKrishiSharePrefs.getOnBoarding().then((value) async {
        if (value == null || !value) {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, "/main_app");
          // Navigator.pushReplacementNamed(context, "/onboarding");
        } else {
          if (kIsWeb) {
            // ignore: use_build_context_synchronously
            Navigator.pushReplacementNamed(context, "/main_app");
            return;
          }
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, "/main_app");
          // YajnaKrishiSharePrefs.getAccessToken().then((data) {a
          //   if (data == null || data.isEmpty) {
          //     Navigator.pushReplacementNamed(context, "/login");
          //   } else {
          //     Navigator.pushReplacementNamed(context, "/home");
          //   }
          // });
        }
      });
    });
    super.initState();
  }

  void loadData() {
    BlocProvider.of<DiseasesBloc>(context).fetchDiseases().then((value) {});
    // ignore: use_build_context_synchronously
    BlocProvider.of<InsectsBloc>(context).fetchInsects().then((value) {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  void checkForToken(String accessToken) async {
    if (accessToken.isNotEmpty) {
      try {
        int code = await checkUserTokenIsExpired(accessToken);
        if (code == 401) {
          // ignore: use_build_context_synchronously
          context.read<LoginBloc>().logout();
        }
      } catch (e) {
        // ignore: use_build_context_synchronously
        context.read<LoginBloc>().logout();
      }
    }
  }

  void setUser() async {
    final user = await YajnaKrishiSharePrefs.getUser();
    // ignore: use_build_context_synchronously
    context.read<LoginBloc>().setLoggedInUser(user);
    checkForToken(Config.accessToken!);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (kIsWeb) {
      if (kIsWeb) {
        SystemChrome.setApplicationSwitcherDescription(
          ApplicationSwitcherDescription(
            label: '${TextUtils.appname}-${TextUtils.login}',
            primaryColor: 0xFF0000,
          ),
        );
      }
    }
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SizedBox(
            height: size.height * 0.6,
            width: size.width * 0.6,
            child: Image.asset(
              "assets/logo.png",
              colorBlendMode: BlendMode.color,
            ),
          ),
        ),
      ),
    );
  }
}
