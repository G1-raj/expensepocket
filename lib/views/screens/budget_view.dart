import 'package:expensepoket/controllers/auth_controller.dart';
import 'package:expensepoket/controllers/budget_controller.dart';
import 'package:expensepoket/widgets/budget_home_card/budget_home_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetView extends StatelessWidget {
  BudgetView({super.key});

  final AuthController _authController = Get.find<AuthController>();
  final BudgetController _budgetController = Get.find<BudgetController>();

  @override
  Widget build(BuildContext context) {

    _budgetController.calculateSpentAmount();
    _budgetController.fetchThisMonthEmis();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Expensepocket"),
          actions: [
            IconButton(onPressed: () {_authController.logOut();}, icon: Icon(Icons.logout_outlined))
          ],
        ),
        body: Center(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed("/budget_home_view");
                },
                child: Obx(
                  () {
                    return BudgetHomeCard(
                      month: "February",
                      emiLeft: _budgetController.emisRemaning.value,
                      spent: _budgetController.spentThisMonth.value,
                      budget: 18000,
                    );
                  }
                ),
              );
            },
          )
        ),
      ),
    );
  }
}