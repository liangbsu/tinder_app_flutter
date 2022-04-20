final List<User> welcomeUsers = [
  User(imageUrl: 'https://cdn.wallpapersafari.com/28/53/PjfrGv.jpg', name: 'Adina 68'),
  User(imageUrl: 'https://pbs.twimg.com/media/FCLkS0CXMAcOYIb?format=jpg&name=small', name: 'Kendrick Lamar'),
  User(imageUrl: 'https://cdn.wallpapersafari.com/28/53/PjfrGv.jpg', name: 'Adina 28'),
  User(imageUrl: 'https://pbs.twimg.com/media/FCLkS0CXMAcOYIb?format=jpg&name=small', name: 'Kendrick Lamar 2'),
  User(imageUrl: 'https://cdn.wallpapersafari.com/28/53/PjfrGv.jpg', name: 'Adina 8'),
  User(imageUrl: 'https://pbs.twimg.com/media/FCLkS0CXMAcOYIb?format=jpg&name=small', name: 'Kendrick Lamar 3')
];

class User {
  String? imageUrl;
  String? name;
  int? age;

  User({this.imageUrl, this.name, this.age});
}