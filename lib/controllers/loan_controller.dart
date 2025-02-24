import 'package:expensepoket/helpers/calculate_emi/calculate_emi.dart';
import 'package:expensepoket/models/loan/emi_model.dart';
import 'package:expensepoket/models/loan/loan_model.dart';
import 'package:get/get.dart';

class LoanController extends GetxController {
  RxDouble totalLoan = 0.0.obs;
  RxDouble totalPaid = 0.0.obs;
  RxDouble totalPayble = 0.0.obs;
  RxInt emiLeft = 0.obs;
  RxList<LoanModel> loans = <LoanModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    updateLoanPaid();
  }

  Future<void> addLoan(String lenderName, double loanAmount, String disbursalDate, double interest, int loanTenure, String firstEmiDate) async {
    try {

      List<EmiModel> emis = calculateEmi(loanAmount, loanTenure, disbursalDate, firstEmiDate, interest);

      LoanModel newLoan = LoanModel(
        lendersName: lenderName,
        loanAmount: loanAmount,
        loanDisbursedDate: disbursalDate,
        interestAnually: interest,
        tenureInMonths: loanTenure,
        firstEmiDate: firstEmiDate,
        emiDetails: emis
      );

      loans.add(newLoan);

      _updateLoanStatus();


      Get.back();


      
    } catch (e) {
      throw Exception("Failed to add loan");
    }
  }

  void updateLoanPaid() {

      for (var loan in loans) {
        double paidAmount = loan.emiDetails.fold(0.0, (emiSum, emi) {
          return emi.isPaid.value ? emiSum + emi.emiAmount : emiSum;
        });

        double pendingAmount = loan.loanAmount - paidAmount;

        loan.paidAmount.value = paidAmount;
        loan.pendingAmount.value = pendingAmount;

      }

      loans.refresh();
  }



  void _updateLoanStatus() {
    totalLoan.value = loans.fold(0.0, (sum, loan) => sum + loan.loanAmount);

    totalPayble.value = loans.fold(0.0, (sum, loan) {
      double interestAmount = (loan.loanAmount * loan.interestAnually * loan.tenureInMonths) / (12 * 100);
      return sum + loan.loanAmount + interestAmount;
    });

    totalPaid.value = loans.fold(0.0, (sum, loan) {
      double paidAmount = loan.emiDetails.fold(0.0, (emiSum, emi) {
        return emi.isPaid.value ? emiSum + emi.emiAmount : emiSum;
      });
      return sum + paidAmount;
    });
  }

  void emiLeftForLoan(int index) {

    var loan = loans[index];
    
    emiLeft.value = loan.emiDetails.fold(0, (emiStatus, emi) {
      return emi.isPaid.value ? emiStatus : emiStatus + 1;
    });

  }


  void markEmiAsPaid(int loanIndex, int emiIndex) {
    var loan = loans[loanIndex];
    var emi = loan.emiDetails[emiIndex];

    emi.isPaid.value = true;  

    updateLoanPaid();
    _updateLoanStatus();
    
    update();  
  }
}