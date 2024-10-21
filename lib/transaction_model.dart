class Transaction {
  final String id;
  final String category;
  final double amount;
  final DateTime date;
  final bool isExpense;

  Transaction({
    required this.id,
    required this.category,
    required this.amount,
    required this.date,
    required this.isExpense,
  });

  // Convert from JSON (if you're using shared preferences or Firebase)
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      category: json['category'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      isExpense: json['isExpense'],
    );
  }

  // Convert to JSON (for saving to local storage or Firebase)
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
