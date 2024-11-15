import 'package:clinicapplication/screen/main/dashboard_screen.dart';
import 'package:clinicapplication/screen/walkthrough/walkthrough_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkFirstTimeInstall();
  }

  Future<void> _checkFirstTimeInstall() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstTime') ?? true;

    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      if (isFirstTime) {
        // Pertama kali install, arahkan ke walkthrough
        await prefs.setBool('isFirstTime', false);
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => const WalkthroughScreen(),
          ),
        );
      } else {
        // TODO: Implementasi validasi token
        // if (userToken != null) {
        //   Navigator.pushReplacement(
        // } else {
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(builder: (context) => const LoginScreen()),
        //   );
        // }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mendapatkan ukuran layar
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo aplikasi
            Image.asset(
              'assets/logo.png', // Pastikan menambahkan logo di assets
              width: size.width * 0.4, // Responsive width 40% dari lebar layar
            ),
            const SizedBox(height: 20),
            // Judul aplikasi
            Text(
              'Nama Aplikasi',
              style: TextStyle(
                fontSize: size.width * 0.06, // Responsive font size
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            // Loading indicator
            SizedBox(
              width: size.width * 0.3, // Responsive width
              child: const LinearProgressIndicator(
                backgroundColor: Colors.white30,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
