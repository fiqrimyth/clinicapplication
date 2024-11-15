import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false;
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _emailError;
  String? _phoneError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                GestureDetector(
                  onTap: () {
                    // Tutup keyboard sebelum navigasi
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Image.asset(
                  'assets/illustration/create_accountn.png',
                  height: MediaQuery.of(context).size.height * 0.3,
                ),

                const Text(
                  'Create New Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Sign Up and Get Started',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 32),

                // Email field
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

                // Phone field
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        _phoneError = value.length < 10 || value.length > 13
                            ? 'Nomor telepon harus 10-13 digit'
                            : null;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    errorText: _phoneError,
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

                const SizedBox(height: 32),

                // Create Account button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Validasi form
                      bool isValid = true;

                      // Validasi email
                      if (_emailController.text.isEmpty) {
                        setState(() {
                          _emailError = 'Email tidak boleh kosong';
                          isValid = false;
                        });
                      }

                      // Validasi phone
                      if (_phoneController.text.isEmpty) {
                        setState(() {
                          _phoneError = 'Nomor telepon tidak boleh kosong';
                          isValid = false;
                        });
                      }

                      // Validasi password
                      if (_passwordController.text.isEmpty) {
                        setState(() {
                          _passwordError = 'Password tidak boleh kosong';
                          isValid = false;
                        });
                      }

                      if (isValid) {
                        // Lanjutkan dengan proses pendaftaran
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
                      'Create Account',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
