class User {
  int id;
  final String name;
  final String profilePicture;

  User(this.id,
    this.name,
    this.profilePicture,
  );

  User.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        profilePicture = json["profile_picture"];
}
