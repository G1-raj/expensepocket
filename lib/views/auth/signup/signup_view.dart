import 'package:expensepoket/constants.dart';
import 'package:expensepoket/widgets/input_form_field/input_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _cnfPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;



    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 72,
                    backgroundImage: AssetImage(appLogo),
                  ),
            
                  const SizedBox(height: 18,),
          
                    SizedBox(
                      width: screenWidth * 0.9,
                      child: InputFormField(
                        title: "Email",
                        controller: _emailController,
                        fieldIcon: const Icon(Icons.email),
                      ),
                    ),
          
                    SizedBox(
                      width: screenWidth * 0.9,
                      child: InputFormField(
                        title: "User name",
                        controller: _usernameController,
                        fieldIcon: const Icon(Icons.person),
                      ),
                    ),
          
                    SizedBox(
                      width: screenWidth * 0.9,
                      child: InputFormField(
                        title: "Password",
                        controller: _passController,
                        fieldIcon: const Icon(Icons.lock),
                        hidePassword: true,
                      ),
                    ),
          
                    SizedBox(
                      width: screenWidth * 0.9,
                      child: InputFormField(
                        title: "Confirm Password",
                        controller: _cnfPassController,
                        fieldIcon: const Icon(Icons.lock),
                        hidePassword: true,
                      ),
                    ),
          
                    SizedBox(
                      width: screenWidth * 0.6,
                      height: screenHeight * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed('/basicDetails_view', arguments: {
                            'email': _emailController.text,
                            'userName': _usernameController.text,
                            'password': _passController.text,
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
          
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        "Already have an account? log in",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
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
}