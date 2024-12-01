class User {
  String? id;
  String firstname;
  String lastname;
  String email;
  String? password;
  String? confirmPassword;
  String? accessToken;
  String? phone;
  String? profile;
  String? username;
  String? coverPicture;

  User(
      {required this.firstname,
      required this.lastname,
      required this.email,
      this.password,
      this.confirmPassword,
      this.accessToken,
      this.phone,
      this.profile,
      this.username,
      this.coverPicture,
      this.id});

  // From JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json.containsKey('_id')
          ? json['_id']
          : json.containsKey('id')
              ? json['id']
              : null,
      firstname: json.containsKey('firstname')
          ? json['firstname']
          : json['first_name'],
      lastname:
          json.containsKey('lastname') ? json['lastname'] : json['last_name'],
      email: json['email'],
      accessToken: json.containsKey('accessToken')
          ? json['accessToken']
          : json.containsKey("access_token")
              ? json['access_token']
              : null,
      phone: json['phone'],
      profile: json.containsKey("profile") ? json['profile'] : null,
      username: json['username'],
      coverPicture:
          json.containsKey("cover_image") ? json['cover_image'] : null,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'access_token': accessToken,
      'phone': phone,
      'profile': profile,
      'username': username,
      'cover_image': coverPicture,
    };
  }

  // Copy with
  User copyWith({
    String? firstname,
    String? lastname,
    String? email,
    String? password,
    String? confirmPassword,
    String? accessToken,
    String? phone,
    String? profile,
    String? username,
    String? coverPicture,
  }) {
    return User(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      accessToken: accessToken ?? this.accessToken,
      phone: phone ?? this.phone,
      profile: profile ?? this.profile,
      username: username ?? this.username,
      coverPicture: coverPicture ?? this.coverPicture,
    );
  }
}
