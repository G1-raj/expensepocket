import 'package:expensepoket/constants.dart';
import 'package:expensepoket/controllers/loan_controller.dart';
import 'package:expensepoket/helpers/calculate_emi_date/calculate_next_emi_date.dart';
import 'package:expensepoket/views/loan_input/loan_input.dart';
import 'package:expensepoket/widgets/loan_card/loan_card.dart';
import 'package:expensepoket/widgets/loan_overview_list_card/loan_overview_list_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoansView extends StatelessWidget {
  LoansView({super.key});

  final LoanController _loanController = Get.find<LoanController>();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Loans"),
          centerTitle: false,
        ),
        body: Center(
          child: Column(
            children: [
              Obx(() =>  LoanCard(
                payable: _loanController.totalPayble.value.toStringAsFixed(2),
                paid: _loanController.totalPaid.value.toStringAsFixed(2),
                taken: _loanController.totalLoan.value.toStringAsFixed(2),
              ),),

              Expanded(
                child: Obx(
                  () {

                    if(_loanController.loans.isEmpty) {
                      return Center(
                        child: Text("No loans"),
                      );
                    }



                    return ListView.builder(
                      itemCount: _loanController.loans.length,
                      itemBuilder: (context, index) {

                        _loanController.emiLeftForLoan(index);



                        return GestureDetector(
                          onTap: () {
                            Get.toNamed('/loanDetails_view', arguments: {'index': index});
                          },
                          child: LoanOverviewListCard(
                            lendersName: _loanController.loans[index].lendersName, 
                            emiLeft: _loanController.emiLeft.value,
                            nextEmiDate: nextEmiDate(_loanController.loans[index].emiDetails),
                          )
                        );
                      },
                    );
                  }
                ),
              )
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Get.to(LoanInput(), transition: Transition.leftToRight);
          },
          backgroundColor: appTheme,
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

//  SingleChildScrollView(
//           child: Center(
//             child: Obx(
//                () {
          
//                 if (_loanController.loans.isEmpty) {
//                   return const Center(child: Text("No loans"));
//                 }
          
//                 return Column(
//                   children: [
//                     LoanCard(
//                       payable: _loanController.totalPayble.value.toStringAsFixed(2),
//                       paid: _loanController.totalPaid.value.toStringAsFixed(2),
//                       taken: _loanController.totalLoan.value.toStringAsFixed(2),
//                     ),
          
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: _loanController.loans.length,
//                         itemBuilder: (context, index) {
//                           return GestureDetector(
//                             onTap: () {
//                               Get.toNamed('/loanDetails_view', arguments: {'index': index});
//                             },
//                             child: LoanOverviewListCard(
//                               lendersName: _loanController.loans[index].lendersName, 
//                               emiLeft: _loanController.loans[index].emiDetails.length,
//                               nextEmiDate: nextEmiDate(_loanController.loans[index].emiDetails),
//                             )
//                           );
//                         },
//                       ),
//                     )
                
//                     // LoanOverviewListCard(),
//                     // LoanOverviewListCard(),
//                     // LoanOverviewListCard()
//                   ],
//                 );
//               }
//             ),
//           ),
//         ),