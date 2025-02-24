import 'package:expensepoket/controllers/budget_controller.dart';
import 'package:expensepoket/widgets/budget_view_emi_card/budget_view_emi_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetPlannerEmiView extends StatelessWidget {
  BudgetPlannerEmiView({super.key});

  final BudgetController _budgetController = Get.find<BudgetController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _budgetController.thisMonthEmis.isEmpty ?  
          Text("No emis for this month")
          :    ListView.builder(
            itemCount: _budgetController.thisMonthEmis.length,
            itemBuilder: (context, index) {
              return BudgetViewEmiCard(emiIndex: index);
            },
          ),
        ),
      ),
    );
  }
}