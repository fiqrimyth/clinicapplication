import 'package:clinicapplication/screen/menu/clinic/booking/input_patient_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputBuyerDataScreen extends StatefulWidget {
  const InputBuyerDataScreen({super.key});

  @override
  State<InputBuyerDataScreen> createState() => _InputBuyerDataScreenState();
}

class _InputBuyerDataScreenState extends State<InputBuyerDataScreen> {
  bool _isSameAsProfile = false;
  bool _showCheckboxError = false;
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  final Map<String, bool> _fieldsTouched = {
    'name': false,
    'age': false,
    'phone': false,
    'address': false,
  };

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child:
                Icon(Icons.arrow_back_ios, size: 16, color: Colors.grey[800]),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Input Buyer Data',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F1F1F),
          ),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'This data is needed for registration purposes.',
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          maxLength: 100,
                          decoration: _buildInputDecoration('Name').copyWith(
                            counterText: "",
                          ),
                          onChanged: (value) {
                            if (_fieldsTouched['name'] == true) {
                              setState(() {
                                _formKey.currentState?.validate();
                              });
                            }
                          },
                          validator: (value) {
                            if (!_fieldsTouched['name']!) return null;
                            if (value == null || value.isEmpty) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                          onTap: () {
                            setState(() {
                              _fieldsTouched['name'] = true;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _ageController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(3),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: _buildInputDecoration('Age').copyWith(
                            counterText: "",
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (_fieldsTouched['age'] == true) {
                              setState(() {
                                _formKey.currentState?.validate();
                              });
                            }
                          },
                          validator: (value) {
                            if (!_fieldsTouched['age']!) return null;
                            if (value == null || value.isEmpty) {
                              return 'Please enter age';
                            }
                            return null;
                          },
                          onTap: () {
                            setState(() {
                              _fieldsTouched['age'] = true;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _phoneController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(15),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: _buildInputDecoration('Phone Number'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (_fieldsTouched['phone'] == true) {
                              setState(() {
                                _formKey.currentState?.validate();
                              });
                            }
                          },
                          validator: (value) {
                            if (!_fieldsTouched['phone']!) return null;
                            if (value == null || value.isEmpty) {
                              return 'Please enter phone number';
                            }
                            if (!value.startsWith('0')) {
                              return 'Phone number must start with 0';
                            }
                            return null;
                          },
                          onTap: () {
                            setState(() {
                              _fieldsTouched['phone'] = true;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _addressController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(100),
                          ],
                          decoration: _buildInputDecoration('Address'),
                          maxLines: 3,
                          onChanged: (value) {
                            if (_fieldsTouched['address'] == true) {
                              setState(() {
                                _formKey.currentState?.validate();
                              });
                            }
                          },
                          validator: (value) {
                            if (!_fieldsTouched['address']!) return null;
                            if (value == null || value.isEmpty) {
                              return 'Please enter address';
                            }
                            return null;
                          },
                          onTap: () {
                            setState(() {
                              _fieldsTouched['address'] = true;
                            });
                          },
                        ),
                        const SizedBox(height: 24),
                        CheckboxListTile(
                          value: _isSameAsProfile,
                          onChanged: (value) {
                            setState(() {
                              _isSameAsProfile = value ?? false;
                              _showCheckboxError = false;
                            });
                          },
                          title: const Text(
                            'Buyer data is the same as user profile',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF1F1F1F),
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          activeColor: const Color(0xFF617BF4),
                          checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        if (_showCheckboxError)
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Text(
                                'Please check the checkbox',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _fieldsTouched.forEach((key, value) {
                  _fieldsTouched[key] = true;
                });
              });

              bool isFormValid = _formKey.currentState!.validate();
              bool isAllFieldsFilled = _nameController.text.isNotEmpty &&
                  _ageController.text.isNotEmpty &&
                  _phoneController.text.isNotEmpty &&
                  _addressController.text.isNotEmpty;

              if (isAllFieldsFilled && isFormValid) {
                if (!_isSameAsProfile) {
                  setState(() {
                    _showCheckboxError = true;
                  });
                  return;
                }
                setState(() {
                  _showCheckboxError = false;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InputPatientDataScreen(),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF617BF4),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Next',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.grey[600],
        fontSize: 14,
      ),
      filled: true,
      fillColor: const Color(0xFFF8F9FE),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF617BF4)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    );
  }
}
