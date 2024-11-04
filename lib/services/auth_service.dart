import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  // Register a new user and save their profile in SharedPreferences
  Future<void> createAccount(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userKey = 'user_${user.email}';

    if (prefs.containsKey(userKey)) {
      throw Exception('User already exists');
    }

    // Save the user's data in JSON format with empty bookings and address
    User newUser = User(
      name: user.name,
      email: user.email,
      password: user.password,
      bookings: [],
      address: '',
    );
    prefs.setString(userKey, jsonEncode(newUser.toMap()));
  }

  // Login and retrieve the user's data
  Future<User?> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final userKey = 'user_$email';

    if (!prefs.containsKey(userKey)) {
      return null; // Return null if user is not found
    }

    final userData = jsonDecode(prefs.getString(userKey)!);
    final user = User.fromMap(userData);

    if (user.password != password) {
      return null; // Return null if password is invalid
    }

    // Save logged-in user's email for session management
    await prefs.setString('loggedInUser', email);

    return user;
  }

  // Retrieve email of the logged-in user
  Future<String?> getLoggedInUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('loggedInUser');
  }

  // Update user profile (phone, address, bookings)
  Future<void> updateUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userKey = 'user_${user.email}';
    prefs.setString(userKey, jsonEncode(user.toMap()));
  }

  // Add a booking for the current user
  Future<void> addBooking(String email, Map<String, String> booking) async {
    final prefs = await SharedPreferences.getInstance();
    final userKey = 'user_$email';

    if (!prefs.containsKey(userKey)) {
      return; // Exit if user is not found
    }

    final userData = jsonDecode(prefs.getString(userKey)!);
    final user = User.fromMap(userData);

    // Add the booking to the user's list of bookings
    user.bookings.add(booking);

    // Update the user's data in SharedPreferences
    prefs.setString(userKey, jsonEncode(user.toMap()));
  }

  // Retrieve user bookings
  Future<List<Map<String, String>>> getUserBookings(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final userKey = 'user_$email';

    if (!prefs.containsKey(userKey)) {
      return []; // Return an empty list if user is not found
    }

    final userData = jsonDecode(prefs.getString(userKey)!);
    final user = User.fromMap(userData);

    return user.bookings;
  }
}
