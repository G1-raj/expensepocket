import 'package:expensepoket/controllers/auth_controller.dart';
import 'package:expensepoket/controllers/budget_controller.dart';
import 'package:expensepoket/widgets/budget_tabs/budget_tabs.dart';
import 'package:flutter/material.dart';
import 'package:expensepoket/widgets/budget_indicator/budget_indicator.dart';
import 'package:get/get.dart';

class BudgetHomeView extends StatefulWidget {
  const BudgetHomeView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BudgetHomeViewState createState() => _BudgetHomeViewState();
}

class _BudgetHomeViewState extends State<BudgetHomeView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  final AuthController _authController = Get.find<AuthController>();
  final BudgetController _budgetController = Get.find<BudgetController>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  // double calculateBudgetUsed() {

  //   double totalExpense = 0.0;

  //   for(int i = 0; i < _budgetController.expenses.length; i++) {
  //     totalExpense += _budgetController.expenses[i].amount;
  //   }

  //   return (totalExpense) / _budgetController.salary.value;

  // }

  // double totalExpense() {
  //   double totalExpense = 0.0;

  //   for(int i = 0; i < _budgetController.expenses.length; i++) {
  //     totalExpense += _budgetController.expenses[i].amount;
  //   }

  //   return totalExpense;
  // }

  @override
  void dispose() {
    if (mounted) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _budgetController.calculateBudgetUsed();
    _budgetController.monthRemainingSalary();


    final Size screenSize = MediaQuery.of(context).size;
    double cardHeight = screenSize.height * 0.25;

    // _budgetController.calculateBudgetUsed();
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 22.0, left: 14.0),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 10.0, bottom: 8.0),
                    child: Obx(() => Text(
                      "Hello ${_authController.name}! 👋",
                      style: TextStyle(
                        fontSize: screenSize.width * 0.08, 
                        fontWeight: FontWeight.bold
                      ),
                    )),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
                child: Center(
                  child: Card(
                    elevation: 16,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: cardHeight,
                      padding: EdgeInsets.all(screenSize.width * 0.05),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [Colors.blueAccent, Colors.deepPurple],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: constraints.maxWidth * 0.4,
                                height: constraints.maxWidth * 0.4,
                                child: Obx(() =>  BudgetIndicator(percentage: _budgetController.budgetUsedPercentag.value)),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(() {
                                      return Text(
                                        "\$${_budgetController.monthRemainingSalary.value.toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: screenSize.width * 0.07,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      );
                                    }),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Salary Remaining",
                                      style: TextStyle(
                                        fontSize: screenSize.width * 0.04,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18.0),

              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double firstContainerHeight = constraints.maxHeight; 
                    double secondContainerHeight = firstContainerHeight * 0.75; 
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: double.infinity,
                          height: firstContainerHeight,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.blueAccent, Colors.deepPurple],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(28.0),
                              topRight: Radius.circular(28.0),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.05,
                            vertical: screenSize.height * 0.02,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => _buildBudgetColumn("Salary", "\$${_budgetController.salary.value}", screenSize)),
                              Container(height: 50, width: 2, color: Colors.white54),
                              Obx(() => _buildBudgetColumn("Expenses", "\$${_budgetController.spentThisMonth.value.toStringAsFixed(2)}", screenSize)),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: secondContainerHeight,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(28.0),
                              topRight: Radius.circular(28.0),
                            ),
                          ),
                          child: DefaultTabController(
                            length: 2, 
                            child: BudgetTabs(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBudgetColumn(String title, String amount, Size screenSize) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenSize.width * 0.045,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Builder(
            builder: (context) {
              return Text(
                amount,
                style: TextStyle(
                  fontSize: screenSize.width * 0.055,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}