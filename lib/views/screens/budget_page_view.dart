import 'package:expensepoket/controllers/budget_controller.dart';
import 'package:expensepoket/models/budget/budget_model.dart';
import 'package:expensepoket/widgets/expense_card/expense_card.dart';
import 'package:expensepoket/widgets/input_form_field/input_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetPageView extends StatelessWidget {
  BudgetPageView({super.key});

  final TextEditingController expenseTextController = TextEditingController();
  final TextEditingController expenseAmountController = TextEditingController();
  final BudgetController _budgetController  = Get.find<BudgetController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return ExpenseCard();
            },
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
             Get.defaultDialog(
                title: "Add expense",
                content: Column(
                  children: [
                    InputFormField(title: "Expense title", controller: expenseTextController, fieldIcon: Icon(Icons.title)),
                    InputFormField(title: "Expense amount", controller: expenseAmountController, fieldIcon: Icon(Icons.money)),
                  ],
                ),
                textConfirm: "OK",
                textCancel: "Cancel",
                onConfirm: () {
                  _budgetController.addExpense(BudgetModel(
                    month: DateTime.now().month.toString(), 
                    title: expenseTextController.text, 
                    amount: double.parse(expenseAmountController.text), 
                    isPaid: false
                  ));
                  Get.back(); // Close dialog
                  Get.snackbar("Input", "You entered: ${expenseTextController.text}",
                      snackPosition: SnackPosition.BOTTOM);
                },
              );
          },
          elevation: 28,
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0)
          ),
          child: Icon(Icons.add, color: Colors.white,),
        )
      ),
    );
  }
}