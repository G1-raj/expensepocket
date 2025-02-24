import 'dart:convert';

import 'package:expensepoket/models/auth/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

  final FlutterSecureStorage _storage = FlutterSecureStorage();
  RxString name = "".obs;
  RxBool isLoggedIn = false.obs;

  @override
  void onInit() {

    super.onInit();
    loadUserData();

  }

  Future<void> loadUserData() async {

    try {
      String? userJson = await _storage.read(key: 'user');

      if (userJson != null) {
        Map<String, dynamic> userData = jsonDecode(userJson);

        name.value = userData['userName'];
        isLoggedIn.value = true;
      }
    } catch (e) {
     throw Exception("Failed to load user data error is: $e");
    }

  }

  Future<void> createAccount(String userName, String email, String password, String mobileNo) async {

    try {

      UserModel user = UserModel(
        userName: userName, 
        email: email, 
        password: password, 
        mobileNo: mobileNo, 
      );

      String userJson = jsonEncode(user.toJson());

      await _storage.write(key: 'user', value: userJson);

      Get.snackbar(
          "Success", 
          "Account created successfully",
          snackPosition: SnackPosition.TOP,
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          borderRadius: 8.0, 
          margin: EdgeInsets.all(16.0), 
          duration: Duration(seconds: 3), 
          isDismissible: true, 
          icon: Icon(Icons.check, color: Colors.white), 
          boxShadows: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.5),
              blurRadius: 6,
              offset: Offset(2, 2),
            ),
          ], 
        );

      Get.offAllNamed("/login_view");
      
    } catch (e) {
      throw Exception("Failed to create user");
    }

  }

    Future<String> logIn(String userName, String password) async {
      try {

        String? metaDeta = await _storage.read(key: 'user');

        if(metaDeta == null) {
          Get.snackbar(
            "Error", 
            "User is not registered please create account first",
            snackPosition: SnackPosition.TOP,
            snackStyle: SnackStyle.FLOATING,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            borderRadius: 8.0, 
            margin: EdgeInsets.all(16.0), 
            duration: Duration(seconds: 3), 
            isDismissible: true, 
            icon: Icon(Icons.check, color: Colors.white), 
            boxShadows: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.5),
                blurRadius: 6,
                offset: Offset(2, 2),
              ),
            ], 
          );
          Get.toNamed('/signup_view');
          return "User not found sign up";
        }


        Map<String, dynamic> decodedUser = jsonDecode(metaDeta);

        final String username = decodedUser['userName'];
        final String pass = decodedUser['password'];


        if(userName == username && password == pass) {

          name.value = username;
          isLoggedIn.value = true;

          Get.snackbar(
            "Success", 
            "Log in successful",
            snackPosition: SnackPosition.TOP,
            snackStyle: SnackStyle.FLOATING,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            borderRadius: 8.0, 
            margin: EdgeInsets.all(16.0), 
            duration: Duration(seconds: 3), 
            isDismissible: true, 
            icon: Icon(Icons.check, color: Colors.white), 
            boxShadows: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.5),
                blurRadius: 6,
                offset: Offset(2, 2),
              ),
            ], 
          );
          Get.offAllNamed('/');
          return "Log in successfull";
        } else {
          Get.snackbar(
            "Error", 
            "Failed to login please check your user name or password",
            snackPosition: SnackPosition.TOP,
            snackStyle: SnackStyle.FLOATING,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            borderRadius: 8.0, 
            margin: EdgeInsets.all(16.0), 
            duration: Duration(seconds: 3), 
            isDismissible: true, 
            icon: Icon(Icons.check, color: Colors.white), 
            boxShadows: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.5),
                blurRadius: 6,
                offset: Offset(2, 2),
              ),
            ], 
          );
          return "Invalid credentials";
        }
        
      } catch (e) {
        throw Exception("Failed to log in");
      }
  }

  Future<void> logOut() async {
    await _storage.delete(key: 'user');
    Get.snackbar(
          "Success", 
          "Log out successful",
          snackPosition: SnackPosition.TOP,
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 8.0, 
          margin: EdgeInsets.all(16.0), 
          duration: Duration(seconds: 3), 
          isDismissible: true, 
          icon: Icon(Icons.check, color: Colors.white), 
          boxShadows: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.5),
              blurRadius: 6,
              offset: Offset(2, 2),
            ),
          ], 
        );
    Get.offAllNamed('/login_view');
  }

}

// class AuthController extends GetxController {


//   RxDouble income = 0.0.obs;
//   RxDouble groceryPayment = 0.0.obs;
//   RxDouble electricityPayment = 0.0.obs;
//   RxDouble phonePayment = 0.0.obs;
//   RxDouble internetPayment = 0.0.obs;
//   RxDouble subscriptionsPayment = 0.0.obs;
 

//   @override
//   void onInit() {

//     super.onInit();
//     loadUserData();

//   }

//   Future<void> loadUserData() async {

//     try {
//       String? userJson = await _storage.read(key: 'user');

//       if (userJson != null) {
//         Map<String, dynamic> userData = jsonDecode(userJson);

//         name.value = userData['userName'];
//         income.value = userData['salary'];
//         groceryPayment.value = userData['groceryBill'];
//         electricityPayment.value = userData['electricityBill'];
//         phonePayment.value = userData['phoneBill'];
//         internetPayment.value = userData['internetBill'];
//         subscriptionsPayment.value = userData['subscriptions'];
//         isLoggedIn.value = true;
//       }
//     } catch (e) {
//       print("Failed to load user data: $e");
//     }

//   }

//   Future<void> createAccount(
//     String userName, String email, String password, String mobileNo, double salary, double groceryBill, double electricityBill, 
//     double phoneBill, double internetBill, double subscriptions
//   ) async {

//     try {

//       UserModel user = UserModel(
//         userName: userName, 
//         email: email, 
//         password: password, 
//         mobileNo: mobileNo, 
//         salary: salary, 
//         groceryBill: groceryBill, 
//         electricityBill: electricityBill, 
//         phoneBill: phoneBill, 
//         internetBill: internetBill, 
//         subscriptions: subscriptions
//       );

//       String userJson = jsonEncode(user.toJson());

//       await _storage.write(key: 'user', value: userJson);

//       Get.snackbar(
//           "Success", 
//           "Account created successfully",
//           snackPosition: SnackPosition.TOP,
//           snackStyle: SnackStyle.FLOATING,
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//           borderRadius: 8.0, 
//           margin: EdgeInsets.all(16.0), 
//           duration: Duration(seconds: 3), 
//           isDismissible: true, 
//           icon: Icon(Icons.check, color: Colors.white), 
//           boxShadows: [
//             BoxShadow(
//               // ignore: deprecated_member_use
//               color: Colors.black.withOpacity(0.5),
//               blurRadius: 6,
//               offset: Offset(2, 2),
//             ),
//           ], 
//         );

//       Get.offAllNamed("/login_view");
      
//     } catch (e) {
//       throw Exception("Failed to create user");
//     }

//   }

//   Future<String> logIn(String userName, String password) async {
//     try {

//       String? metaDeta = await _storage.read(key: 'user');

//       if(metaDeta == null) {
//         Get.snackbar(
//           "Error", 
//           "User is not registered please create account first",
//           snackPosition: SnackPosition.TOP,
//           snackStyle: SnackStyle.FLOATING,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//           borderRadius: 8.0, 
//           margin: EdgeInsets.all(16.0), 
//           duration: Duration(seconds: 3), 
//           isDismissible: true, 
//           icon: Icon(Icons.check, color: Colors.white), 
//           boxShadows: [
//             BoxShadow(
//               // ignore: deprecated_member_use
//               color: Colors.black.withOpacity(0.5),
//               blurRadius: 6,
//               offset: Offset(2, 2),
//             ),
//           ], 
//         );
//         Get.toNamed('/signup_view');
//         return "User not found sign up";
//       }


//       Map<String, dynamic> decodedUser = jsonDecode(metaDeta);

//       final String username = decodedUser['userName'];
//       final String pass = decodedUser['password'];
//       final double salary = decodedUser['salary'];
//       final double groceryBill = decodedUser['groceryBill'];
//       final double electricity = decodedUser['electricityBill'];
//       final double internet = decodedUser['internetBill'];
//       final double subscriptions = decodedUser['subscriptions'];

//       print("User naem is: $username");

//       if(userName == username && password == pass) {

//         name.value = username;
//         income.value = salary;
//         groceryPayment.value = groceryBill;
//         electricityPayment.value = electricity;
//         internetPayment.value = internet;
//         subscriptionsPayment.value = subscriptions;
//         isLoggedIn.value = true;

//         Get.snackbar(
//           "Success", 
//           "Log in successful",
//           snackPosition: SnackPosition.TOP,
//           snackStyle: SnackStyle.FLOATING,
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//           borderRadius: 8.0, 
//           margin: EdgeInsets.all(16.0), 
//           duration: Duration(seconds: 3), 
//           isDismissible: true, 
//           icon: Icon(Icons.check, color: Colors.white), 
//           boxShadows: [
//             BoxShadow(
//               // ignore: deprecated_member_use
//               color: Colors.black.withOpacity(0.5),
//               blurRadius: 6,
//               offset: Offset(2, 2),
//             ),
//           ], 
//         );
//         Get.offAllNamed('/');
//         return "Log in successfull";
//       } else {
//         Get.snackbar(
//           "Error", 
//           "Failed to login please check your user name or password",
//           snackPosition: SnackPosition.TOP,
//           snackStyle: SnackStyle.FLOATING,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//           borderRadius: 8.0, 
//           margin: EdgeInsets.all(16.0), 
//           duration: Duration(seconds: 3), 
//           isDismissible: true, 
//           icon: Icon(Icons.check, color: Colors.white), 
//           boxShadows: [
//             BoxShadow(
//               // ignore: deprecated_member_use
//               color: Colors.black.withOpacity(0.5),
//               blurRadius: 6,
//               offset: Offset(2, 2),
//             ),
//           ], 
//         );
//         return "Invalid credentials";
//       }
      
//     } catch (e) {
//       throw Exception("Failed to log in");
//     }
//   }

//   Future<void> logOut() async {
//     await _storage.delete(key: 'user');
//     Get.snackbar(
//           "Success", 
//           "Log out successful",
//           snackPosition: SnackPosition.TOP,
//           snackStyle: SnackStyle.FLOATING,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//           borderRadius: 8.0, 
//           margin: EdgeInsets.all(16.0), 
//           duration: Duration(seconds: 3), 
//           isDismissible: true, 
//           icon: Icon(Icons.check, color: Colors.white), 
//           boxShadows: [
//             BoxShadow(
//               // ignore: deprecated_member_use
//               color: Colors.black.withOpacity(0.5),
//               blurRadius: 6,
//               offset: Offset(2, 2),
//             ),
//           ], 
//         );
//     Get.offAllNamed('/login_view');
//   }
// }