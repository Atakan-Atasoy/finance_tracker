import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'transaction_provider.dart';   // Import TransactionProvider
import 'home_screen.dart';            // Import HomeScreen
import 'splash_screen.dart';          // Import SplashScreen
import 'add_transaction_screen.dart'; 
import 'transaction_model.dart';
// Import AddTransactionScreen


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final List<Transaction> transactions = transactionProvider.transactions;

    // Calculate total income, total expenses, and balance
    double totalIncome = transactions
        .where((tx) => !tx.isExpense)
        .fold(0.0, (sum, tx) => sum + tx.amount);
    double totalExpenses = transactions
        .where((tx) => tx.isExpense)
        .fold(0.0, (sum, tx) => sum + tx.amount);
    double balance = totalIncome - totalExpenses;

    return Scaffold(
      appBar: AppBar(
        title: Text('Finance Tracker'),
      ),
      body: Column(
        children: [
          _buildFinancialSummary(balance, totalIncome, totalExpenses),
          Expanded(
            child: transactions.isEmpty
                ? Center(
                    child: Text(
                      'No transactions yet, add some!',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final Transaction tx = transactions[index];
                      return _buildTransactionCard(context, tx);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    Navigator.of(context).pushNamed('/add-transaction');  // Navigate to AddTransactionScreen
  },
  child: Icon(Icons.add),
),

    );
  }

  // Build the financial summary
  Widget _buildFinancialSummary(double balance, double totalIncome, double totalExpenses) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Total Balance',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            '\$${balance.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 36, color: balance >= 0 ? Colors.green : Colors.red),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    'Income',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '\$${totalIncome.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Expenses',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '-\$${totalExpenses.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Build each transaction card with a delete button
  Widget _buildTransactionCard(BuildContext context, Transaction tx) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      elevation: 5,
      child: ListTile(
        title: Text(
          tx.category,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(tx.date.toLocal().toString()),
        trailing: Container(
          width: 120, // Set a fixed width to ensure content fits within screen
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(  // Ensure the Text can shrink or wrap as needed
                child: Text(
                  tx.isExpense ? '-\$${tx.amount}' : '+\$${tx.amount}',
                  style: TextStyle(
                    fontSize: 18,
                    color: tx.isExpense ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,  // Add ellipsis if the text is too long
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  Provider.of<TransactionProvider>(context, listen: false)
                      .removeTransaction(tx.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
