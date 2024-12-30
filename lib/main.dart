import 'package:flutter/material.dart';
import 'package:responsi_wpk/screens/login_screen.dart';
import 'package:responsi_wpk/screens/resgistration_screen.dart';
import 'package:responsi_wpk/screens/home_screen.dart'; // Mengimpor HomeScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 2, 18, 247),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/', // Splash screen sebagai initial route
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(), // Tambahkan route untuk Register
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}

// SplashScreen widget
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigasi ke login screen setelah 1 detik
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Tampilkan GIF
              Image.asset(
                'images/motor.gif', // Sesuaikan path gambar GIF Anda
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 20),
              // Tampilkan teks di bawah GIF
              const Text(
                'FLAMESH',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Visby',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
