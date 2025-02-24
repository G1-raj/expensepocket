
import 'package:expensepoket/controllers/loan_controller.dart';
import 'package:expensepoket/widgets/emi_data_card/emi_data_card.dart';
import 'package:expensepoket/widgets/loan_card/loan_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LoanDetailView extends StatelessWidget {
  LoanDetailView({super.key});

  final LoanController _loanController = Get.find<LoanController>();

  late int indexL = 0;

 

  @override
  Widget build(BuildContext context) {

     final args = Get.arguments;
     indexL = args['index'];

    Future.microtask(() => _loanController.updateLoanPaid());


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [

              Obx(() => LoanCard(
                payable: _loanController.loans[indexL].pendingAmount.value.toStringAsFixed(2),
                paid: _loanController.loans[indexL].paidAmount.toStringAsFixed(2),
                taken:  _loanController.loans[indexL].loanAmount.toStringAsFixed(2),
              ),),
              

              Expanded(
                child: Obx(
                   () {
                    return ListView.builder(
                      itemCount: _loanController.loans[indexL].emiDetails.length,
                      itemBuilder: (context, index) =>  EmiDataCard(emiIndex: index, loanIndex: indexL,),
                    );
                  }
                ),
              ),
              // EmiDataCard()
            ],
          ),
        ),
      ),
    );
  }
}