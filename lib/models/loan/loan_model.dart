import 'package:expensepoket/models/loan/emi_model.dart';
import 'package:get/get.dart';

class LoanModel {
  static int _idCounter = 0;

  final int id;
  final String lendersName;
  final double loanAmount;
  final String loanDisbursedDate;
  final double interestAnually;
  final int tenureInMonths;
  final String firstEmiDate;
  final List<EmiModel> emiDetails;

  RxDouble paidAmount = 0.0.obs;
  RxDouble pendingAmount = 0.0.obs;

  LoanModel(
    {
      required this.lendersName,
      required this.loanAmount,
      required this.loanDisbursedDate,
      required this.interestAnually,
      required this.tenureInMonths,
      required this.firstEmiDate,
      required this.emiDetails
    }
  ): id = _idCounter++;
}