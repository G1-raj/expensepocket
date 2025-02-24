import 'package:expensepoket/models/loan/emi_model.dart';

String nextEmiDate(List<EmiModel> loanEmis) {

  for(int index = 0; index < loanEmis.length; index++) {

    // ignore: unrelated_type_equality_checks
    if(loanEmis[index].isPaid == false) {
      return loanEmis[index].emiDate;
    }

  }


  return "";
}