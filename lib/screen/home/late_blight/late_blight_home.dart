import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:late_blight/colors/colors.dart';
import 'package:late_blight/config/config.dart';
import 'package:late_blight/model/popup.item.dart';
import 'package:late_blight/screen/home/late_blight/bloc/navbar_bloc.dart';
import 'package:late_blight/screen/home/late_blight/information/about_disease.dart';
import 'package:late_blight/screen/home/late_blight/mainpage.dart';
import 'package:late_blight/screen/home/late_blight/map/map.dart';
import 'package:late_blight/services/late_blight_fcm.dart';
import 'package:late_blight/shared_prefs.dart';
import 'package:late_blight/utils/utils.dart';
import 'package:late_blight/widgets/logout.dart';

class LateBlightHome extends StatefulWidget {
  const LateBlightHome({super.key});

  @override
  State<LateBlightHome> createState() => _HomeState();
}

class _HomeState extends State<LateBlightHome> {
  final FirebaseMessaging instance = FirebaseMessagingService.getInstance();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  initState() {
    super.initState();
    YajnaKrishiSharePrefs.getAccessToken().then(
      (value) => Config.setAccessToken(value),
    );
    _subscribeToTopic();
    FirebaseMessagingService.getFCMToken().then((value) => {});
    _initializeNotifications();
    _configureFirebaseMessaging();
  }

  void _subscribeToTopic() {
    if (!kIsWeb) instance.subscribeToTopic('lateblight');
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _configureFirebaseMessaging() {
    instance.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print('Received message: ${message.notification?.title}');
      _showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationClick(message);
    });
  }

  Future<void> _showNotification(RemoteMessage message) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      "LateBlight",
      "LateBlight",
      channelDescription: "Notification for Late Blight",
      importance: Importance.max,
      priority: Priority.high,
    );

    try {
      final NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await _flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title,
        message.notification?.body,
        platformChannelSpecifics,
      );
    } on Exception {
      //print('Error displaying notification: $e');
    }
  }

  void _handleNotificationClick(RemoteMessage message) {
    //
    // if (message.notification?.android != null) {
    //   final channelId = message.notification?.android?.channelId;
    // }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const LateBlightMainPage(),
      const LateBlightMap(),
      const AboutDisease(),
    ];
    List<LateBlightPopupItem> popupItems = [
      // LateBlightPopupItem(
      //   value: "AboutUs",
      //   icon: Icons.info,
      //   label: TextUtils.aboutUs,
      // ),
      LateBlightPopupItem(
        value: "help",
        icon: Icons.help,
        label: TextUtils.help,
      ),
      // LateBlightPopupItem(
      //   value: "logout",
      //   icon: Icons.logout,
      //   label: TextUtils.logout,
      // )
    ];
    Map<String, dynamic> arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: null,
          shadowColor: Colors.black,
          actions: [
            // IconButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, "/search-lateblight");
            //   },
            //   icon: Icon(Icons.search),
            // ),
            PopupMenuButton(
              icon: const Icon(Icons.more_vert), // Three dots icon
              itemBuilder: (BuildContext context) {
                return [
                  for (final item in popupItems)
                    PopupMenuItem(
                      value: item.value,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.label,
                            ),
                            Icon(
                              item.icon,
                              color: Colors.black,
                            ),
                          ]),
                    ),
                ];
              },
              onSelected: (value) {
                if (value == "help") {
                  Navigator.pushNamed(context, "/help");
                } else if (value == "AboutUs") {
                  Navigator.pushNamed(context, "/aboutus");
                }
                //handle for logout
                if (value == "logout") {
                  showLogoutDialog(context);
                }
              },
            ),
          ],
          elevation: 1,
          backgroundColor: appBarColor,
          centerTitle: true,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  arg['name'].toString(),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 4,
          enableFeedback: true,
          fixedColor: Colors.blue[900],
          backgroundColor: Colors.white,
          showUnselectedLabels: false,
          unselectedIconTheme: const IconThemeData(color: Colors.black),
          type: BottomNavigationBarType.fixed,
          iconSize: 28,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.place),
              label: "Map",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: "Information",
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.person),
            //   label: "Account",
            // ),
          ],
          onTap: (selected) {
            BlocProvider.of<NavbarBloc>(context, listen: false)
                .update(selected);
          },
          currentIndex:
              BlocProvider.of<NavbarBloc>(context, listen: false).state,
        ),
        body: pages.elementAt(
          (BlocProvider.of<NavbarBloc>(context, listen: true).state),
        ),
      ),
    );
  }
}
