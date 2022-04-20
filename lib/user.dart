
class User {
  String? id;
  String? firstName;
  String? lastName;
  int? age;
  String? imageUrl;

  User({this.id, this.firstName, this.lastName, this.imageUrl, this.age});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      imageUrl: json['picture'],
    );
  }
}