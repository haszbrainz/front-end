import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const secureStorage = FlutterSecureStorage();

// Base URL untuk API (bisa disesuaikan untuk produksi atau pengujian)
const String baseUrl = "http://192.168.1.108:8000/api";

// Fungsi untuk login
Future<void> login(String email, String password) async {
  final url = Uri.parse("$baseUrl/auth/login");

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      final accessToken = data['token']['access_token'];

      // Menyimpan access token di Flutter Secure Storage
      await secureStorage.write(key: 'access_token', value: accessToken);
      print('Access token berhasil disimpan!');
    } else {
      final error = json.decode(response.body);
      throw Exception("Login gagal: ${error['message'] ?? 'Kesalahan server'}");
    }
  } catch (e) {
    throw Exception("Login gagal: $e");
  }
}

// Fungsi untuk mengambil data yang dilindungi dengan token
Future<String> fetchProtectedData() async {
  final accessToken = await secureStorage.read(key: 'access_token');

  if (accessToken == null) {
    throw Exception("Access token tidak ditemukan. Silakan login ulang.");
  }

  final url = Uri.parse("$baseUrl/user/me");

  try {
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 401) {
      throw Exception("Access token tidak valid atau expired. Silakan login ulang.");
    } else {
      final error = json.decode(response.body);
      throw Exception("Kesalahan: ${error['message'] ?? 'Kesalahan server'}");
    }
  } catch (e) {
    throw Exception("Terjadi kesalahan: $e");
  }
}

// Fungsi untuk logout (menghapus token)
Future<void> logout() async {
  await secureStorage.delete(key: 'access_token');
  print("Access token berhasil dihapus.");
}

// Fungsi untuk registrasi pengguna baru
Future<void> register(String name, String email, String password) async {
  final url = Uri.parse("$baseUrl/auth/register");

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": password,
      }),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      print('Registrasi berhasil: ${data['message']}');
    } else {
      final error = json.decode(response.body);
      throw Exception("Registrasi gagal: ${error['message'] ?? 'Kesalahan server'}");
    }
  } catch (e) {
    throw Exception("Registrasi gagal: $e");
  }
}
