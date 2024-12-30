class User {
  final String id;
  final String email;
  
  // Constructor untuk membuat objek User
  User({required this.id, required this.email});

  // Factory method untuk mengonversi JSON (data yang diterima dari API) ke objek User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],            // Misalnya ID pengguna dari API
      email: json['email'],      // Email pengguna
    );
  }
}
