import 'package:get/get.dart';

class EmiModel {
  final String emiMonth;
  final String emiDate;
  final RxBool isPaid;
  final double emiAmount;

  EmiModel(
    {
      required this.emiMonth,
      required this.emiDate,
      required bool isPaid,
      required this.emiAmount
    }
  ) : isPaid = isPaid.obs;
}