import 'dart:convert';

import 'package:expensepoket/controllers/loan_controller.dart';
import 'package:expensepoket/models/budget/budget_model.dart';
import 'package:expensepoket/models/loan/emi_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class BudgetController extends GetxController {

  final FlutterSecureStorage _storage = FlutterSecureStorage();
  RxList<BudgetModel> expenses = <BudgetModel>[].obs;
  RxDouble salary = 0.0.obs;
  RxDouble monthRemainingSalary = 0.0.obs;
  RxDouble spentThisMonth = 0.0.obs;
  RxDouble budgetUsedPercentag = 0.0.obs;
  RxList<EmiModel> thisMonthEmis = <EmiModel>[].obs;
  final LoanController _loanController = Get.find<LoanController>();
  RxInt emisRemaning = 0.obs;

  @override
  void onInit() {
    super.onInit();

    calculateSpentAmount();
    calculateRemainingSalary();
    calculateBudgetUsed();
  }

  Future<void> addSalary(double monthlySalary) async {
    try {

      salary.value = monthlySalary;

      await _storage.write(key: "salary", value: salary.value.toString());
      
    } catch (e) {
      throw Exception("Failed to add salary");
    }
  }

  Future<void> fetchThisMonthEmis() async {

    try {

      thisMonthEmis.clear();

      DateTime now = DateTime.now();
      String currentMonthYear = "${now.year}-${now.month.toString().padLeft(2, '0')}";


      for (var loan in _loanController.loans) {
        for (var emi in loan.emiDetails) {
          DateTime emiDate = DateTime.parse(emi.emiDate);
          String emiMonthYear = "${emiDate.year}-${emiDate.month.toString().padLeft(2, '0')}";

          if (emiMonthYear == currentMonthYear) {
            thisMonthEmis.add(emi);
          }
        }
      }

      emisRemaning.value = thisMonthEmis.length;
      
    } catch (e) {
      throw Exception("Failed to fetch this month emis");
    }

  }

  void markEmiAsPaid(int emiIndex) {
    var emi = thisMonthEmis[emiIndex];

    emi.isPaid.value = true;
    spentThisMonth.value += emi.emiAmount;
    monthRemainingSalary.value -= emi.emiAmount;
    emisRemaning.value -= 1;  
    
    update();  
  }

  Future<void> calculateSpentAmount() async {
    try {

      double amountSpent = 0.0;
      for(int i = 0; i < expenses.length; i++) {
        amountSpent += expenses[i].amount;
      }

      spentThisMonth.value = amountSpent;
      
    } catch (e) {
      throw Exception("Failed to calculatd spent amount");
    }
  }

  Future<void> calculateRemainingSalary() async {
    try {

      double remainingAmount = 0.0;
      monthRemainingSalary.value = salary.value;

      remainingAmount = salary.value - spentThisMonth.value;


      monthRemainingSalary.value = remainingAmount;
      
    } catch (e) {
      throw Exception("Failed to calculate remaining budget");
    }

  }

  Future<void> calculateBudgetUsed() async {

    try {
      
      budgetUsedPercentag.value = spentThisMonth.value / salary.value;

    } catch (e) {
      throw Exception("Failed to calculate percentage");
    }

  }

  Future<void> addExpense(BudgetModel expense) async {

    try {

      expenses.add(expense);
      await _saveExpenses();
      
    } catch (e) {
      throw Exception("Failed to add budget");
    }

  }

   Future<void> _saveExpenses() async {
  try {
    final List<Map<String, dynamic>> expenseList =
        expenses.map((e) => e.toJson()).toList();


    // Write new data
    await _storage.write(key: 'cost', value: jsonEncode(expenseList));
  } catch (e) {
    throw Exception("Failed to save expenses: ${e.toString()}");
  }
}
  
}