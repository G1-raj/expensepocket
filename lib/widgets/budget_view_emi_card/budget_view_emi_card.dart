import 'package:expensepoket/controllers/budget_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BudgetViewEmiCard extends StatefulWidget {
  final int emiIndex;
  const BudgetViewEmiCard({super.key, required this.emiIndex});

  @override
  State<BudgetViewEmiCard> createState() => _EmiDataCardState();
}

class _EmiDataCardState extends State<BudgetViewEmiCard> {
  String? paidDate;
  final BudgetController _budgetController = Get.find<BudgetController>();
  

  @override
  Widget build(BuildContext context) {


    bool isPaid = _budgetController.thisMonthEmis[widget.emiIndex].isPaid.value;

   

    void markAsPaid() {
      if (!isPaid) {
        setState(() {
          isPaid = true;
          paidDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
        });
      }

      _budgetController.markEmiAsPaid(widget.emiIndex);
     
    }

     
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: Row(
            children: [
              // EMI Icon & Details
              const Icon(Icons.monetization_on, color: Colors.green, size: 40),
              const SizedBox(width: 12),

              // EMI Text Data
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "EMI Amount: \$${_budgetController.thisMonthEmis[widget.emiIndex].emiAmount}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6,),
                    Text(
                      "EMI Month: ${_budgetController.thisMonthEmis[widget.emiIndex].emiMonth}",
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    if (isPaid) // Show only if EMI is paid
                      Text(
                        "Paid on: $paidDate",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                  ],
                ),
              ),

              // Interactive Button
              InkWell(
                onTap: isPaid ? null : markAsPaid, // Disable if already paid
                borderRadius: BorderRadius.circular(8),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: isPaid
                        ? null // No gradient when paid
                        : const LinearGradient(
                            colors: [Colors.redAccent, Colors.orangeAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                    color: isPaid ? Colors.grey : null,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: isPaid
                            // ignore: deprecated_member_use
                            ? Colors.grey.withOpacity(0.3)
                            // ignore: deprecated_member_use
                            : Colors.redAccent.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(2, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    isPaid ? "Paid" : "Unpaid",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
