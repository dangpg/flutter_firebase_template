class UserData {
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final String username;

  UserData.fromMap(Map<String, dynamic> map, String id)
      : id = id,
        firstname = map['firstname'] ?? '',
        lastname = map['lastname'] ?? '',
        email = map['email'] ?? '',
        username = map['username'] ?? '';
}
