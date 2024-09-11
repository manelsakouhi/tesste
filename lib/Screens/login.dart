import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:teste/Visiteur_Simple/Visiteur.dart';
import 'package:teste/Admin/Admin.dart';
import 'package:teste/Visiteur_pro/VisiteurPro.dart';
import '../core/services/services.dart';
import 'forgot_password.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 230, 230),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(12),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      //logo
                      const Icon(
                        Icons.lock,
                        size: 100,
                      ),
                      const SizedBox(
                        height: 50,
                      ),

                      //Bienvennue
                      Text(
                        '2'.tr,
                        style: const TextStyle(
                            color: Colors.blueGrey, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.mail),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: '7'.tr,
                          enabled: true,
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "21".tr;
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("22".tr);
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          emailController.text = value!;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: _isObscure3,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.fingerprint),
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure3
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscure3 = !_isObscure3;
                                });
                              }),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: '8'.tr,
                          enabled: true,
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 15.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return "23".tr;
                          }
                          if (!regex.hasMatch(value)) {
                            return ("24".tr);
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          passwordController.text = value!;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //forgot password*
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const ForgotPasswordPage();
                                }));
                              },
                              child: Text(
                                '9'.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),

//okhty maaya
                      const SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        elevation: 5.0,
                        height: 40,
                        onPressed: () {
                          signIn(emailController.text, passwordController.text);
                        },
                        child: Text(
                          "10".tr,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: visible,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('11'.tr),
              const SizedBox(width: 4),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                elevation: 5.0,
                height: 50,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Register(),
                    ),
                  );
                },
                color: Colors.blue[900],
                child: Text(
                  "12".tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ]),
      ),
    );
  }

 void route() {
  MyServices myServices = Get.find();
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // Check the 'states' field
        var states = documentSnapshot.get('states');
        if (states == "active") {
          var role = documentSnapshot.get('role');
          if (role == "professional visitor") {
            myServices.sharedPreferences.setString("step", "2");
            Get.offAll(const VisiteurPro());
          } else if (role == "visitor") {
            myServices.sharedPreferences.setString("step", "3");
            Get.offAll(const Visiteur());
          } else {
            myServices.sharedPreferences.setString("step", "4");
            Get.offAll(const Admin());
          }
        } else {
          // Show dialog with the message from Firestore
          var message = documentSnapshot.get('message') ?? "Your account is not active.";
          Get.defaultDialog(
            title: "Account Inactive",
            middleText: message,
          );
        }
      } else {
        Get.defaultDialog(
          title: "Error",
          middleText: "Document does not exist on the database.",
        );
      }
    }).catchError((error) {
      Get.defaultDialog(
        title: "Error",
        middleText: error.toString(),
      );
    });
  } else {
    Get.defaultDialog(
      title: "Error",
      middleText: "User is not authenticated.",
    );
  }
}

void signIn(String email, String password) async {
  if (_formkey.currentState!.validate()) {
    try {
      setState(() {
        visible = true;
      });

      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      route(); // Call route after successful sign-in
    } on FirebaseAuthException catch (e) {
      setState(() {
        visible = false;
      });

      if (e.code == 'user-not-found') {
        Get.defaultDialog(
          title: "Warning",
          middleText: "No user found for that email.",
        );
      } else if (e.code == 'wrong-password') {
        Get.defaultDialog(
          title: "Warning",
          middleText: "Wrong password provided for that user.",
        );
      }
    } catch (e) {
      setState(() {
        visible = false;
      });

      Get.defaultDialog(
        title: "Error",
        middleText: e.toString(),
      );
    }
  }
}

}