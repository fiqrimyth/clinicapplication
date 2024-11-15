import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String? _emailError;
  String? _newPasswordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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

                const SizedBox(height: 32),

                // Ilustrasi
                Center(
                  child: Image.asset(
                    'assets/illustration/security.png',
                    height: MediaQuery.of(context).size.height * 0.25,
                  ),
                ),

                const SizedBox(height: 32),

                // Header text
                const Center(
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F1F1F),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                const Center(
                  child: Text(
                    'Set your new password',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF9698A9),
                    ),
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
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    errorText: _emailError,
                    filled: true,
                    fillColor: const Color(0xFFF6F6F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                  ),
                ),

                const SizedBox(height: 16),

                // New Password field
                TextField(
                  controller: _newPasswordController,
                  obscureText: !_isNewPasswordVisible,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      final passwordRegex =
                          RegExp(r'^(?=.*?[!@#$%^&*(),.?":{}|<>])');
                      setState(() {
                        if (value.length < 8) {
                          _newPasswordError = 'Password minimal 8 karakter';
                        } else if (!passwordRegex.hasMatch(value)) {
                          _newPasswordError =
                              'Password harus mengandung karakter khusus';
                        }
                      });
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'New Password',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    errorText: _newPasswordError,
                    filled: true,
                    fillColor: const Color(0xFFF6F6F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isNewPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isNewPasswordVisible = !_isNewPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Confirm Password field
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      final passwordRegex =
                          RegExp(r'^(?=.*?[!@#$%^&*(),.?":{}|<>])');
                      setState(() {
                        if (value.length < 8) {
                          _confirmPasswordError = 'Password minimal 8 karakter';
                        } else if (!passwordRegex.hasMatch(value)) {
                          _confirmPasswordError =
                              'Password harus mengandung karakter khusus';
                        }
                      });
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Re-type Password',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    errorText: _confirmPasswordError,
                    filled: true,
                    fillColor: const Color(0xFFF6F6F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Reset Password button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle reset password
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5468FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Reset My Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
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
