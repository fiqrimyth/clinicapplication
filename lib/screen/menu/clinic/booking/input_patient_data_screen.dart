import 'package:clinicapplication/screen/menu/clinic/booking/choose_date_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputPatientDataScreen extends StatefulWidget {
  const InputPatientDataScreen({super.key});

  @override
  State<InputPatientDataScreen> createState() => _InputPatientDataScreenState();
}

class _InputPatientDataScreenState extends State<InputPatientDataScreen> {
  bool _isSameAsProfile = false;
  bool _showCheckboxError = false;
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _complaintController = TextEditingController();

  final Map<String, bool> _fieldsTouched = {
    'name': false,
    'age': false,
    'phone': false,
    'address': false,
    'complaint': false,
  };

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _complaintController.dispose();
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
          'Input Patient Data',
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
                        _buildTextField(
                          controller: _nameController,
                          label: 'Name',
                          field: 'name',
                          maxLength: 100,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _ageController,
                          label: 'Age',
                          field: 'age',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(3),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _phoneController,
                          label: 'Phone Number',
                          field: 'phone',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(15),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
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
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _addressController,
                          label: 'Address',
                          field: 'address',
                          maxLines: 3,
                          maxLength: 100,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _complaintController,
                          label: 'Complaint',
                          field: 'complaint',
                          maxLines: 3,
                          maxLength: 500,
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
                            'Patient data is the same as user profile',
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
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
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
                  _addressController.text.isNotEmpty &&
                  _complaintController.text.isNotEmpty;

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
                    builder: (context) => const ChooseDateScreen(),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String field,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    int? maxLines = 1,
    int? maxLength,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      maxLines: maxLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: _buildInputDecoration(label).copyWith(
        counterText: "",
      ),
      onChanged: (value) {
        if (_fieldsTouched[field] == true) {
          setState(() {
            _formKey.currentState?.validate();
          });
        }
      },
      validator: validator ??
          (value) {
            if (!_fieldsTouched[field]!) return null;
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
      onTap: () {
        setState(() {
          _fieldsTouched[field] = true;
        });
      },
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
