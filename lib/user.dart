
class User {
  String? id;
  String? firstName;
  String? lastName;
  int? age;
  String? imageUrl;

  User({this.id, this.firstName, this.lastName, this.imageUrl, this.age});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    imageUrl = json['picture'];
    age = json['dateOfBirth'] != null ? calculateAge(DateTime.parse(json['dateOfBirth'])) : null;
  }

  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }
}

class ListUsers {
  final List<User> results = <User>[];

  ListUsers();

  ListUsers.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((user) {
      results.add(User.fromJson(user));
    });
  }
}