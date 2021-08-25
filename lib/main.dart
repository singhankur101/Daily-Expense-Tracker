import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tracker/widget/new_transactions.dart';
import './widget/transaction_list.dart';
import 'package:tracker/widget/user_transactions.dart';
import './models/transaction.dart';
import './widget/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.amber,

      ),

      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //String amountInput;
  //String titleInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
   /*Transaction(
      id: 't1',
      title: 'New shoe',
      date: DateTime.now(),
      amount: 28.34,
    ),
    Transaction(
      id: 't1',
      title: 'New shoe',
      date: DateTime.now(),
      amount: 28.34,
    ),*/

  ];

  List<Transaction> get _recentTransactions {

    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),),);
    }).toList();
  }
  void _addNewTransaction(String txTitle,double txAmount,DateTime chosenDate)
  {
    final newTx=Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),

    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      elevation: 5,
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,

        );
      },
    );
  }
  void _deleteTransaction(String id)
  {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id==id;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Personal Expense Tracker'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
              ),
              onPressed: () => _startAddNewTransaction(context),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Chart(_recentTransactions),
              TransactionList(_userTransactions,_deleteTransaction),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ));
  }
}
