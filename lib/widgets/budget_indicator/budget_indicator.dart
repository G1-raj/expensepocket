import 'package:flutter/material.dart';

class BudgetIndicator extends StatefulWidget {
  final double percentage;

  const BudgetIndicator({super.key, required this.percentage});

  @override
  // ignore: library_private_types_in_public_api
  _BudgetIndicatorState createState() => _BudgetIndicatorState();
}

class _BudgetIndicatorState extends State<BudgetIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0.0, end: widget.percentage).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color getIndicatorColor(double value) {
    if (value <= 0.4) return Colors.green;
    if (value <= 0.7) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.4;
    double strokeWidthUsed = size * 0.1; // Thicker stroke for used budget
    double strokeWidthRemaining = strokeWidthUsed * 0.5; // Thinner stroke for remaining budget

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              /// Background progress (Remaining Budget - Thin Stroke)
              SizedBox(
                height: size,
                width: size,
                child: CircularProgressIndicator(
                  value: 1, // Always full to show the complete circle
                  strokeWidth: strokeWidthRemaining,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.shade300),
                ),
              ),

              /// Foreground progress (Used Budget - Thick Stroke)
              SizedBox(
                height: size,
                width: size,
                child: CircularProgressIndicator(
                  value: _animation.value,
                  strokeWidth: strokeWidthUsed,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    getIndicatorColor(_animation.value),
                  ),
                ),
              ),

              /// Text Percentage
              Text(
                "${(_animation.value * 100).toInt()}%",
                style: TextStyle(
                  fontSize: size * 0.2,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
