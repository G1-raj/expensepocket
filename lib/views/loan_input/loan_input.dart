import 'package:expensepoket/constants.dart';
import 'package:expensepoket/controllers/loan_controller.dart';
import 'package:expensepoket/widgets/date_input/date_input.dart';
import 'package:expensepoket/widgets/input_form_field/input_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanInput extends StatelessWidget {
  LoanInput({super.key});

  final TextEditingController _lenderNameController = TextEditingController();
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();
  final TextEditingController _tenureController = TextEditingController();
  final TextEditingController _disbursalDateController = TextEditingController();
  final TextEditingController _firstEmiDateController = TextEditingController();

  final LoanController _loanController = Get.find<LoanController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Loan"),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 5,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputFormField(
                  title: "Lender Name",
                  controller: _lenderNameController,
                  fieldIcon: Icon(Icons.bolt),
                ),
                const SizedBox(height: 12),
                InputFormField(
                  title: "Total loan amount",
                  controller: _loanAmountController,
                  fieldIcon: Icon(Icons.money),
                  keyboardType: TextInputType.numberWithOptions(),
                ),
                const SizedBox(height: 12),
                DateInput(title: "Loan disbursed on", isDisbursed: true, dateController: _disbursalDateController),
                const SizedBox(height: 12),
                InputFormField(
                  title: "Annual interest",
                  controller: _interestController,
                  fieldIcon: Icon(Icons.percent),
                  keyboardType: TextInputType.numberWithOptions(),
                ),
                const SizedBox(height: 12),
                InputFormField(
                  title: "Loan Tenure in Months",
                  controller: _tenureController,
                  fieldIcon: Icon(Icons.calendar_month),
                  keyboardType: TextInputType.numberWithOptions(),
                ),
                const SizedBox(height: 12),
                DateInput(title: "First EMI Date", isDisbursed: false, dateController: _firstEmiDateController,),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: screenWidth * 0.6,
                    child: ElevatedButton(
                      onPressed: () {
                        _loanController.addLoan(
                          _lenderNameController.text, 
                          double.parse(_loanAmountController.text), 
                          _disbursalDateController.text, 
                          double.parse(_interestController.text), 
                          int.parse(_tenureController.text), 
                          _firstEmiDateController.text
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appTheme,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Text("Add Loan"),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
