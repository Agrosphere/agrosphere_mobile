import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/utils/enums.dart';

class FirebaseMessagingService {
  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._internal();

  factory FirebaseMessagingService() => _instance;

  FirebaseMessagingService._internal();

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static FirebaseMessaging getInstance() {
    return _firebaseMessaging;
  }

  static add() async {
    String? token = await getFCMToken();
    try {
      if (token != null) {
        await API.request(
          "fcm",
          RequestMethod.post,
          body: {"token": token},
        );
      }
    } catch (e) {
      //error
    }
  }

  static Future<String?> getFCMToken() async {
    try {
      return await _firebaseMessaging.getToken();
    } catch (e) {
      // print('Error getting FCM token: $e');
      return null;
    }
  }
}
