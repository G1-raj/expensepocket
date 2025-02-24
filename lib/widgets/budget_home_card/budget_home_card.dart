import 'package:flutter/material.dart';

class BudgetHomeCard extends StatelessWidget {
  final String month;
  final int emiLeft;
  final double spent;
  final double budget;

  const BudgetHomeCard({
    super.key,
    required this.month,
    required this.emiLeft,
    required this.spent,
    required this.budget,
  });

  @override
  Widget build(BuildContext context) {
    bool isOverspent = spent > budget;
    double width = MediaQuery.of(context).size.width * 0.9;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: width,
              minHeight: 150, // Ensure it doesn't shrink infinitely
            ),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Prevent infinite height
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Month Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          month,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Icon(
                          Icons.calendar_today,
                          color: Colors.blueAccent.shade700,
                        ),
                      ],
                    ),
                    const Divider(),

                    // EMI Left
                    Row(
                      children: [
                        const Icon(Icons.payment, color: Colors.orange),
                        const SizedBox(width: 10),
                        Text(
                          "EMI Left: $emiLeft",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Spent/Overspend Indicator
                    Row(
                      children: [
                        Icon(
                          isOverspent ? Icons.warning : Icons.check_circle,
                          color: isOverspent ? Colors.redAccent : Colors.green,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          isOverspent
                              ? "Overspent by ₹${(spent - budget).toStringAsFixed(2)}"
                              : "Spent: \$${spent.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: isOverspent ? Colors.red : Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
