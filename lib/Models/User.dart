
class User {
  final String id;
  final String email;
  final String photoUrl;
  final String displayName;

  User(
    this.id,
    this.email,
    this.photoUrl,
    this.displayName,
  );

  User.fromData(Map<String, dynamic> data)
    : id = data["id"],
      email = data['email'],
      displayName = data['displayName'],
      photoUrl = data['photoUrl'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
    };
  }
}