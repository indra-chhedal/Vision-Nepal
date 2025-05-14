

class Login {
  final String username;
  final String email;

  Login({required this.username, required this.email});

  factory Login.fromMap(Map<String, dynamic> map) {
    return Login(username: map['username'], email: map['email']);
  }
}
