class User {
  String name;
  String email;
  String phoneNumber;
  String gender;
  String city;
  String password;
  User({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.city,
    required this.password,
  });
  List<User> user = [];
}
