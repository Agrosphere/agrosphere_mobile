class SubApp {
  String appname;
  String imageUrl;
  String description;
  String route;
  SubApp(
      {required this.appname,
      required this.imageUrl,
      required this.description,
      required this.route});
  SubApp copyWith(
      {String? appname, String? imageUrl, String? description, String? route}) {
    return SubApp(
      appname: appname ?? this.appname,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      route: route ?? this.route,
    );
  }
}
