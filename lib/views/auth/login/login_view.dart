import 'package:expensepoket/constants.dart';
import 'package:expensepoket/controllers/auth_controller.dart';
import 'package:expensepoket/widgets/input_form_field/input_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with SingleTickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController auth = Get.find<AuthController>();
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 99,
                      backgroundImage: AssetImage(appLogo),
                    ),
                  
                    const SizedBox(height: 10),
            
                    Column(
                      children: [
                        const SizedBox(height: 15),
                        InputFormField(
                          title: "User Name",
                          controller: _usernameController,
                          fieldIcon: const Icon(Icons.email),
                        ),
                
                        InputFormField(
                          title: "Password",
                          controller: _passwordController,
                          fieldIcon: const Icon(Icons.lock),
                          hidePassword: true,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: screenWidth * 0.65,
                          height: screenHeight * 0.06,
                          child: ElevatedButton(
                            onPressed: () {
                              auth.logIn(_usernameController.text, _passwordController.text);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurpleAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            child: const Text(
                              "Log in",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  
            
                    const SizedBox(height: 10),
            
                    // Signup Text
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/signup_view');
                      },
                      child: const Text(
                        "Don't have an account? Sign up",
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
      ),
    );
  }
}
