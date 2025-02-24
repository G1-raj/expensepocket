import 'package:expensepoket/controllers/auth_controller.dart';
import 'package:expensepoket/controllers/budget_controller.dart';
import 'package:expensepoket/models/budget/budget_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasicDetails extends StatefulWidget {

  const BasicDetails({super.key});

  @override
  State<BasicDetails> createState() => _BasicDetailsState();
}

class _BasicDetailsState extends State<BasicDetails> {
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _groceryController = TextEditingController();
  final TextEditingController _electricityController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _internetController = TextEditingController();
  final TextEditingController _subscriptionsController = TextEditingController();
  final AuthController auth = Get.find<AuthController>();
  final BudgetController budget = Get.find<BudgetController>();
  

  bool _salaryEntered = false; // To track when salary is entered

  late String userName;
  late String email;
  late String password;
  late String mobileno;

  @override
  void initState() {
    super.initState();

    final args = Get.arguments;
    userName = args['userName'];
    email = args['email'];
    password = args['password'];
    mobileno = args['mobileno'];

  }

  void _submitSalary() {
    if (_salaryController.text.isNotEmpty) {
      setState(() {
        budget.addSalary(double.parse(_salaryController.text));
        _salaryEntered = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Expense Tracker")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!_salaryEntered) // Show Salary Input First
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Enter your Monthly Salary:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _salaryController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Salary Amount",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: _submitSalary,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text("Next", style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ],
              ),
      
            if (_salaryEntered) // Show Expense Details After Salary Entry
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Enter Your Monthly Expenses:",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      _buildExpenseField("Grocery Bill", _groceryController),
                      _buildExpenseField("Electricity Bill", _electricityController),
                      _buildExpenseField("Phone Bill", _phoneController),
                      _buildExpenseField("Internet Bill", _internetController),
                      _buildExpenseField("Subscriptions", _subscriptionsController),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
          
                            auth.createAccount(
                                userName, 
                                email, 
                                password, 
                                mobileno, 
                              );

                              budget.addExpense(
                                BudgetModel(
                                  month: DateTime.now().month.toString(), 
                                  title: "Grocery", 
                                  amount: double.parse(_groceryController.text), 
                                  isPaid: false,
                                )
                              );

                              budget.addExpense(
                                BudgetModel(
                                  month: DateTime.now().month.toString(), 
                                  title: "Electricity Bill", 
                                  amount: double.parse(_electricityController.text), 
                                  isPaid: false,
                                )
                              );

                              budget.addExpense(
                                BudgetModel(
                                  month: DateTime.now().month.toString(), 
                                  title: "Mobile bill", 
                                  amount: double.parse(_phoneController.text), 
                                  isPaid: false,
                                )
                              );

                              budget.addExpense(
                                BudgetModel(
                                  month: DateTime.now().month.toString(), 
                                  title: "Internet Bill", 
                                  amount: double.parse(_internetController.text), 
                                  isPaid: false,
                                )
                              );

                              budget.addExpense(
                                BudgetModel(
                                  month: DateTime.now().month.toString(), 
                                  title: "Subscriptions", 
                                  amount: double.parse(_subscriptionsController.text), 
                                  isPaid: false,
                                )
                              );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text("Submit", style: TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Helper method to create expense input fields
  Widget _buildExpenseField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
