import 'package:clinicapplication/screen/main/dashboard_screen.dart';
import 'package:clinicapplication/screen/auth/reset_password/reset_password_screen.dart';
import 'package:clinicapplication/screen/auth/register/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // Gambar ilustrasi
                  Image.asset(
                    'assets/illustration/doctors.png',
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),

                  const SizedBox(height: 14),

                  // Teks header
                  const Text(
                    'Hello there',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Login and Get Started',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Form login
                  TextField(
                    controller: _emailController,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        final emailRegex =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        setState(() {
                          _emailError = emailRegex.hasMatch(value)
                              ? null
                              : 'Format email tidak valid';
                        });
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Email',
                      errorText: _emailError,
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Password field
                  TextField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        final passwordRegex =
                            RegExp(r'^(?=.*?[!@#$%^&*(),.?":{}|<>])');
                        setState(() {
                          if (value.length < 8) {
                            _passwordError = 'Password minimal 8 karakter';
                          } else if (!passwordRegex.hasMatch(value)) {
                            _passwordError =
                                'Password harus mengandung karakter spesial';
                          } else {
                            _passwordError = null;
                          }
                        });
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                      errorText: _passwordError,
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),

                  // Forgot Password dengan alignment ke kanan
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ResetPasswordScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.black, // Ubah warna menjadi hitam
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Login button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Validasi email
                        final emailRegex =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                        if (_emailController.text.isEmpty) {
                          setState(() {
                            _emailError = 'Email tidak boleh kosong';
                          });
                          return;
                        }
                        if (!emailRegex.hasMatch(_emailController.text)) {
                          setState(() {
                            _emailError = 'Format email tidak valid';
                          });
                          return;
                        }

                        // Validasi password
                        final passwordRegex =
                            RegExp(r'^(?=.*?[!@#$%^&*(),.?":{}|<>])');

                        if (_passwordController.text.isEmpty) {
                          setState(() {
                            _passwordError = 'Password tidak boleh kosong';
                          });
                          return;
                        }
                        if (_passwordController.text.length < 8) {
                          setState(() {
                            _passwordError = 'Password minimal 8 karakter';
                          });
                          return;
                        }
                        if (!passwordRegex.hasMatch(_passwordController.text)) {
                          setState(() {
                            _passwordError =
                                'Password harus mengandung karakter spesial';
                          });
                          return;
                        }

                        // Reset error jika validasi berhasil
                        setState(() {
                          _emailError = null;
                          _passwordError = null;
                        });

                        // Lanjutkan dengan login
                        if (_emailError == null && _passwordError == null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DashboardScreen(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[400],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Or login with
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Or login with..'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Social login buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialLoginButton('assets/icon/sosmed/facebook.png'),
                      const SizedBox(width: 16),
                      _socialLoginButton('assets/icon/sosmed/google.png'),
                      const SizedBox(width: 16),
                      _socialLoginButton('assets/icon/sosmed/apple.png'),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Sign up link
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialLoginButton(String iconPath) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Image.asset(
          iconPath,
          height: 24,
          width: 24,
        ),
      ),
    );
  }
}
