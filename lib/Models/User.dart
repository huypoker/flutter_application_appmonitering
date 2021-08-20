
class User {
  final String email;
  final String photoUrl;
  final String displayName;

  User(
    this.email,
    this.photoUrl,
    this.displayName,
  );

  Map<String, dynamic> toJson() => {
    'email': email,
    'photoUrl': photoUrl,
    'username': displayName,
  };
}