import 'package:late_blight/providers/chat_providers.dart';
import 'package:late_blight/providers/diseases_providers.dart';
import 'package:late_blight/providers/others.dart';
import 'package:late_blight/providers/user_providers.dart';

getAppBlocProviders(String? lccVersion) {
  final appProviders = [
    ...getOtherProviders(),
    ...getDiseasesProviders(lccVersion),
    ...getUserBlocProviders(),
    ...getChatProviders()
  ];
  return appProviders;
}
