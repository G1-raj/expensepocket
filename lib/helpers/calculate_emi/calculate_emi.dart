import 'dart:math';

import 'package:expensepoket/models/loan/emi_model.dart';
import 'package:intl/intl.dart';

List<EmiModel> calculateEmi(double loanAmount, int loanDuration, String disbursalDate, String firstEmiDate, double annualInterestRate) {

  List<EmiModel> emiList = [];

  DateTime emiStartDate = DateFormat("yyyy-MM-dd").parse(firstEmiDate);

  double monthlyInterestRate = (annualInterestRate / 100) / 12;
  
 
  double emiAmount = (loanAmount * monthlyInterestRate * 
                     (pow(1 + monthlyInterestRate, loanDuration))) /
                     (pow(1 + monthlyInterestRate, loanDuration) - 1);

  for (int i = 0; i < loanDuration; i++) {
    DateTime emiDate = DateTime(emiStartDate.year, emiStartDate.month + i, emiStartDate.day);

    String emiMonth = DateFormat("MMMM yyyy").format(emiDate); 

    emiList.add(EmiModel(
      emiMonth: emiMonth,
      emiDate: DateFormat("yyyy-MM-dd").format(emiDate),
      isPaid: false,
      emiAmount: double.parse(emiAmount.toStringAsFixed(2)), 
    ));
  }



  return emiList;

}