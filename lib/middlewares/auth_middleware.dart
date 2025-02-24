import 'package:expensepoket/controllers/auth_controller.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {

    final AuthController auth = Get.put(AuthController());
    bool isLoggedIn = auth.isLoggedIn.value;
    
    if(!isLoggedIn) {
      return RouteSettings(name: '/login_view');
    }


    return null;
  }
}