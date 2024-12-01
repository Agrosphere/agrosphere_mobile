import 'package:flutter/material.dart';

class LoginFeatures extends StatelessWidget {
  const LoginFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    Widget item(
      String title,
      Widget icon, {
      String? route,
    }) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              if (route != null) {
                Navigator.pushNamed(context, route);
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.green[100],
                  ),
                ),
                Positioned(
                  bottom: title.isEmpty ? 25 : 45,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 50,
                      width: 50,
                      color: Colors.white60,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon,
                    if (title.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          title,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    final features = [
      item(
          "Chat",
          route: "/chat",
          Image.asset(
            "assets/chat.gif",
            height: 48,
            width: 48,
          )),
      item(
        "Chat with AI",
        route: "/chat-ai",
        Image.asset(
          "assets/chat-bot.gif",
          height: 48,
          width: 48,
        ),
      ),
      item(
        "Market Price",
        route: "/market-price",
        Image.asset(
          "assets/veg.png",
          height: 36,
          width: 36,
        ),
      ),
      item(
        "",
        route: "/news",
        Image.asset(
          "assets/world-news.png",
          height: 48,
          width: 48,
        ),
      ),
    ];

    // Login to get the all features
    return SliverGrid.extent(
      maxCrossAxisExtent: 150,
      childAspectRatio: 1,
      children: [
        ...features,
      ],
    );
  }
}
