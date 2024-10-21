import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'transaction_provider.dart';   // Import TransactionProvider
import 'home_screen.dart';            // Import HomeScreen
import 'splash_screen.dart';          // Import SplashScreen
import 'add_transaction_screen.dart'; // Import AddTransactionScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TransactionProvider(),
      child: MaterialApp(
        title: 'Finance Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),         // SplashScreen route
          '/home': (context) => HomeScreen(),       // HomeScreen route
          '/add-transaction': (context) => AddTransactionScreen(), // AddTransactionScreen route
        },
      ),
    );
  }
}
