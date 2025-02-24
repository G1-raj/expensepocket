import 'package:expensepoket/views/screens/budget_page_view.dart';
import 'package:expensepoket/views/screens/budget_planner_emi_view.dart';
import 'package:flutter/material.dart';

class BudgetTabs extends StatelessWidget {
  const BudgetTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TabBar(
          indicatorColor: Colors.blueAccent,
          labelColor: Colors.blueAccent,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(icon: Icon(Icons.attach_money), text: "Expenses"),
            Tab(icon: Icon(Icons.money_off), text: "EMI's"),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              Center(
                child: BudgetPageView()
              ),
              Center(
                child: BudgetPlannerEmiView(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
