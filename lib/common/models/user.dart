class User {
  // email, username, imageurl, id
  // String email;
  String username;
  String imageUrl;
  String id;

  User(
      {
      // required this.email,
      required this.username,
      this.imageUrl = '',
      required this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      // email: json['email'],
      username: json['username'],
      imageUrl: json['imageurl'],
      id: json['user_uuid'],
    );
  }

  Map<String, dynamic> toJson() => {
        // 'email': email,
        'username': username,
        'imageurl': imageUrl,
        'user_uuid': id,
      };
}
