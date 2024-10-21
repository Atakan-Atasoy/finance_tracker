import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'transaction_provider.dart';
import 'transaction_model.dart';

class AddTransactionScreen extends StatefulWidget {
  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  String _category = '';
  double _amount = 0.0;
  bool _isExpense = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
                onSaved: (value) {
                  _category = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
                onSaved: (value) {
                  _amount = double.parse(value!);
                },
              ),
              SwitchListTile(
                title: Text('Expense'),
                value: _isExpense,
                onChanged: (val) {
                  setState(() {
                    _isExpense = val;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Generate a unique ID using UUID
                    var uuid = Uuid();
                    final newTransaction = Transaction(
                      id: uuid.v4(),
                      category: _category,
                      amount: _amount,
                      date: DateTime.now(),
                      isExpense: _isExpense,
                    );

                    // Add the transaction to the provider
                    Provider.of<TransactionProvider>(context, listen: false)
                        .addTransaction(newTransaction);

                    // Go back to the previous screen
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Add Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
