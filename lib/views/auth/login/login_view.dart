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
  bool _showLoginFields = false;

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
                      radius: 52,
                      backgroundImage: AssetImage(googleLogo),
                    ),
                    const SizedBox(height: 25),
            
                    // Login with Email Button
                    SizedBox(
                      width: screenWidth * 0.75,
                      height: screenHeight * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() => _showLoginFields = !_showLoginFields);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Text(
                          _showLoginFields ? "Cancel" : "Log in with Email",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
            
                    // Animated Email & Password Fields
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: _showLoginFields
                          ? Column(
                              children: [
                                const SizedBox(height: 15),
                                InputFormField(
                                  title: "User Name",
                                  controller: _usernameController,
                                  fieldIcon: const Icon(Icons.email),
                                ),
                                const SizedBox(height: 15),
                                InputFormField(
                                  title: "Password",
                                  controller: _passwordController,
                                  fieldIcon: const Icon(Icons.lock),
                                  hidePassword: true,
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: screenWidth * 0.75,
                                  height: screenHeight * 0.06,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      auth.logIn(_usernameController.text, _passwordController.text);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: appTheme,
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
                            )
                          : const SizedBox.shrink(),
                    ),
            
                    const SizedBox(height: 20),
            
                    // Google Login Button
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: screenWidth * 0.75,
                        height: screenHeight * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: Colors.black54,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              googleLogo,
                              width: screenWidth * 0.07,
                              height: screenWidth * 0.07,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              "Log in with Google",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
            
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
