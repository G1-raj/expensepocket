import 'package:expensepoket/controllers/auth_controller.dart';
import 'package:expensepoket/controllers/budget_controller.dart';
import 'package:expensepoket/controllers/loan_controller.dart';
import 'package:expensepoket/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  Get.put(AuthController(), permanent: true);
  Get.put(LoanController(), permanent: true);
  Get.put(BudgetController(), permanent: true);


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: AppRoutes.appRoute(),
    );
  }
}