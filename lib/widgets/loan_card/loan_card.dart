import 'package:flutter/material.dart';
import 'package:expensepoket/constants.dart';

class LoanCard extends StatelessWidget {
  final String payable;
  final String paid;
  final String taken;
  const LoanCard({super.key, required this.payable, required this.paid, required this.taken});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.02,
      ),
      child: FractionallySizedBox(
        widthFactor: 0.95, // Makes it responsive to the screen width
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 160, // Ensures the card has a minimum height
            maxHeight: screenHeight * 0.3,
          ),
          child: Card(
            color: appTheme,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 6,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02,
                horizontal: screenWidth * 0.05,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Payable Header
                  Flexible(
                    child: Text(
                      "Payable",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.06,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),

                  // Amount Payable
                  Flexible(
                    child:Text(
                      "\$$payable as of today",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.05,
                      ),
                    )
                  ),
                  SizedBox(height: screenHeight * 0.015),

                  // Divider
                  Divider(
                    thickness: 2,
                    indent: screenWidth * 0.05,
                    endIndent: screenWidth * 0.1,
                    color: Colors.white60,
                  ),
                  SizedBox(height: screenHeight * 0.015),

                  // Payment Info Row
                  _rowWidgetBuild(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _rowWidgetBuild(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(child: _infoColumn("Paid till today", "\$$paid", screenWidth)),
        SizedBox(
          height: screenHeight * 0.05,
          child: VerticalDivider(
            color: Colors.white60,
            thickness: 2,
          ),
        ),
        Flexible(child: _infoColumn("Total Taken", "\$$taken", screenWidth)),
      ],
    );
  }

  Widget _infoColumn(String title, String amount, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white70,
            fontSize: screenWidth * 0.04,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05,
          ),
        ),
      ],
    );
  }
}
