class Transaction {
  final String id;
  final String category;
  final double amount;
  final DateTime date;
  final bool isExpense; // true if expense, false if income

  Transaction({
    required this.id,
    required this.category,
    required this.amount,
    required this.date,
    required this.isExpense,
  });

  // Convert from JSON
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      category: json['category'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      isExpense: json['isExpense'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'amount': amount,
      'date': date.toIso8601String(),
      'isExpense': isExpense,
    };
  }
}
  