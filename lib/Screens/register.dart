import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/Screens/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool showProgress = false;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  bool _isObscure = true;
  bool _isObscure2 = true;
  File? file;

  var options = ['13'.tr, '14'.tr];
  var _currentItemSelected = "13".tr;
  var role = "13".tr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 230, 230),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(12),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    const Icon(Icons.lock, size: 100),
                    const SizedBox(height: 50),
                    Text(
                      "15".tr,
                      style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                    ),
                    const SizedBox(height: 50),
                   _buildTextFormField(
                      controller: nameController,
                      hintText: '16'.tr,
                      icon: Icons.person,
                      validator: _nameValidator,
                    ),
                    
                    const SizedBox(height: 20),
                    
                    _buildTextFormField(
                      controller: prenomController,
                      hintText: '17'.tr,
                      icon: Icons.person,
                      validator: _nameValidator,
                    ),
                    const SizedBox(height: 20),
                     _buildTextFormField(
                      controller: emailController,
                      hintText: '7'.tr,
                      icon: Icons.mail,
                      validator: _emailValidator,
                    ),
                    const SizedBox(height: 20),
                    _buildPasswordFormField(
                      controller: passwordController,
                      hintText: '8'.tr,
                      obscureText: _isObscure,
                      toggleVisibility: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildPasswordFormField(
                      controller: confirmPasswordController,
                      hintText: '18'.tr,
                      obscureText: _isObscure2,
                      toggleVisibility: () {
                        setState(() {
                          _isObscure2 = !_isObscure2;
                        });
                      },
                      validator: (value) {
                        if (value != passwordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "19:".tr,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        DropdownButton<String>(
                          dropdownColor: Colors.blue[900],
                          iconEnabledColor: Colors.black,
                          items: options.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(
                                dropDownStringItem,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValueSelected) {
                            setState(() {
                              _currentItemSelected = newValueSelected!;
                              role = newValueSelected;
                            });
                          },
                          value: _currentItemSelected,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                          elevation: 5.0,
                          height: 40,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          }, 
                          child: Text(
                            "10".tr,
                            style: const TextStyle(fontSize: 20),
                          ),
                          color: Colors.blue,
                        ),
                        MaterialButton(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                          elevation: 5.0,
                          height: 40,
                          onPressed: () {
                            setState(() {
                              showProgress = true;
                            });
                            signUp(
                              emailController.text,
                              passwordController.text,
                              nameController.text,
                              prenomController.text,
                              role,
                            );
                          },
                          child: Text(
                            "20".tr,
                            style: const TextStyle(fontSize: 20),
                          ),
                          color: Colors.blue,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildPasswordFormField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback toggleVisibility,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.fingerprint),
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: toggleVisibility,
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: validator,
    );
  }

  String? _emailValidator(String? value) {
    if (value!.isEmpty) {
      return "Email cannot be empty";
    }
    if (!RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-z]+$').hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? _nameValidator(String? value) {
    if (value!.isEmpty) {
      return "Name cannot be empty";
    }
    return null;
  }

  Future<void> signUp(String email, String password, String name, String username, String role) async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      try {
        await _auth.createUserWithEmailAndPassword(email: email, password: password);
        await postDetailsToFirestore(email, name, username, role);
        Navigator.of(context).pop();  // Close the progress dialog
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
      } catch (e) {
        print(e);
        Navigator.of(context).pop();  // Close the progress dialog
      }
    }
  }

  Future<void> postDetailsToFirestore(String email, String firstName, String lastName, String role) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    CollectionReference ref = firebaseFirestore.collection('users');

    await ref.doc(user!.uid).set({
      
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'role': role,
      'image' : '',
    'location' : '',
    'states' : 'active',
    'message': '',
      'createdAt': FieldValue.serverTimestamp(),
    }).catchError((e) {
      print("Error while adding user to Firestore: $e");
    });
  }
}
