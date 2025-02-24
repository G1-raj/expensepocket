class BudgetModel {
  final String month;
  final String title;
  final double amount;
  final bool isPaid;

  BudgetModel(
    {
      required this.month,
      required this.title,
      required this.amount,
      required this.isPaid
    }
  );

  factory BudgetModel.fromJson(Map<String, dynamic> json) {
    return BudgetModel(
      month: json['month'],
      title: json['title'],
      amount: json['amount'],
      isPaid: json['isPaid']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'title': title,
      'amount': amount,
      'isPaid': isPaid
    };
  }

}