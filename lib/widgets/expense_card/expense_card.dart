import 'package:expensepoket/helpers/get_months/get_months.dart';
import 'package:expensepoket/widgets/expense_list/expense_list.dart';
import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        width: double.infinity,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.05,
                child: Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Row(
                    children: [
                      Text(getMonths(DateTime.now()), style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),),

                      const SizedBox(width: 5,),

                      Text("${DateTime.now().day}", style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),),
                      
                    ],
                  ),
                ),
              ),

              ExpenseList(
                expenseName: "Food",
                amount: 180,
                onDelete: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}