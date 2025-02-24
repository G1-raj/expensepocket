import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class MobileAuthView extends StatefulWidget {

  const MobileAuthView({super.key});

  @override
  State<MobileAuthView> createState() => _MobileAuthViewState();
}

class _MobileAuthViewState extends State<MobileAuthView> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _isOtpSent = false;
  String _selectedCountryCode = "+91"; // Default to India

  final List<String> _countryCodes = [
    "+1",  // USA
    "+44", // UK
    "+91", // India
    "+61", // Australia
    "+81", // Japan
    "+49", // Germany
    "+33", // France
    "+86", // China
    "+971", // UAE
  ];

  late String userName;
  late String email;
  late String password;
 

  @override
  void initState() {
    super.initState();

    final args = Get.arguments;
    userName = args['userName'];
    email = args['email'];
    password = args['password'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mobile Authentication")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Enter your mobile number",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
        
              // Mobile Number Input with Country Code
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedCountryCode,
                      items: _countryCodes.map((code) {
                        return DropdownMenuItem(
                          value: code,
                          child: Text(code, style: const TextStyle(fontSize: 16)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCountryCode = value!;
                        });
                      },
                      underline: const SizedBox(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Mobile Number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        
              const SizedBox(height: 20),
        
              // Send OTP Button
              if (!_isOtpSent)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isOtpSent = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    "Send OTP",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
        
              if (_isOtpSent) ...[
                const SizedBox(height: 30),
                const Text(
                  "Enter the 4-digit OTP sent to your mobile number",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
        
                // OTP Input
                Pinput(
                  length: 4,
                  controller: _otpController,
                  defaultPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
        
                const SizedBox(height: 20),
        
                // Verify OTP Button
                ElevatedButton(
                  onPressed: () {
                   Get.toNamed("/basicDetails_view", arguments: {
                    'userName': userName,
                    'email': email,
                    'password': password,
                    'mobileno': _mobileController.text
        
                   });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    "Verify OTP",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
