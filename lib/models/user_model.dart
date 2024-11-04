class User {
  final String name;
  final String email;
  final String password;
  String phoneNumber;
  String address;
  List<Map<String, String>> bookings;

  User({
    required this.name,
    required this.email,
    required this.password,
    this.phoneNumber = '',
    this.address = '',
    this.bookings = const [],
  });

  // Convert User to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'address': address,
      'bookings': bookings.map((booking) => Map<String, String>.from(booking)).toList(),
    };
  }

  // Create a User from Map
  static User fromMap(Map<String, dynamic> map) {
    List<Map<String, String>> bookingsList = [];
    if (map['bookings'] != null && map['bookings'] is List) {
      bookingsList = (map['bookings'] as List).map((booking) {
        // Perform explicit casting and check for types
        if (booking is Map) {
          return Map<String, String>.from(
              booking.map((key, value) => MapEntry(key.toString(), value.toString())));
        }
        return {}; // Return empty map if casting fails
      }).toList().cast<Map<String, String>>();
    }

    return User(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
      bookings: bookingsList,
    );
  }
}
