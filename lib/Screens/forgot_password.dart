import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
 final emailController = TextEditingController();

@override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }


void resetPassword(BuildContext context) async {
  final String email = emailController.text.trim();

  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text('Password reset email sent!'),
    // ));
    
    showDialog(
        context: context,
         builder: (context){
          return AlertDialog(
            content: Text('Password reset link sent! check your email'),
          );
         });
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('No user found for that email.'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${e.message}'),
      ));
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Error: $e'),
    ));
  }
}


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
       body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
         children: [
             Padding(
              padding:  EdgeInsets.symmetric(horizontal:25.0),
              child: Text(textAlign: TextAlign.center,
                       style: TextStyle(fontSize: 30),
                       '25'.tr),
            ),
          const SizedBox(height: 10,),
        //email textfield
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            controller: emailController,
            decoration:  InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide:const BorderSide(color: Colors.white),
                borderRadius:  BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:const  BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: '7'.tr,
                fillColor: Colors.grey[200],
                filled: true,
                ),

          ),
          ),
            SizedBox(height: 10,),
          MaterialButton(
            onPressed: () {
              resetPassword(context);
            },
            child: Text('26'.tr),
            color: Colors.blue,
            ),


         ],
       ),
    );

   
  }
}