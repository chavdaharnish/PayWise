import 'package:flutter/material.dart';
import 'package:paywise/expense_tracker/Tracker.dart';
import 'package:paywise/size_config.dart';

class ExpenseTracker extends StatefulWidget {
  @override
  _ExpenseTracker createState() => new _ExpenseTracker();
}

class _ExpenseTracker extends State<ExpenseTracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.blueGrey,
                  elevation: 10,
                  child: Padding(
                    // padding: const EdgeInsets.only(left: 25, top: 10, bottom: 10),
                    padding: EdgeInsets.all(10),
                    child: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(children: [
                          Center(
                            child: Text(
                              "Income",
                              textScaleFactor: 1.5,
                              style: TextStyle(
                                  fontFamily: "muli",
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Expense",
                              textScaleFactor: 1.5,
                              style: TextStyle(
                                  fontFamily: "muli",
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2),
                            ),
                          ),
                          Center(
                              child: Text(
                            "Balance",
                            textScaleFactor: 1.5,
                            style: TextStyle(
                                fontFamily: "muli",
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2),
                          )),
                        ]),
                        TableRow(children: [
                          Center(
                            child: Text(
                              "0",
                              textScaleFactor: 1.5,
                              style: TextStyle(
                                  fontFamily: "muli",
                                  color: Colors.white,
                                  fontSize: getProportionateScreenWidth(12),
                                  // fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2),
                            ),
                          ),
                          Center(
                            child: Text(
                              "0",
                              textScaleFactor: 1.5,
                              style: TextStyle(
                                  fontFamily: "muli",
                                  color: Colors.white,
                                  fontSize: getProportionateScreenWidth(12),
                                  // fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2),
                            ),
                          ),
                          Center(
                              child: Text(
                            "0",
                            textScaleFactor: 1.5,
                            style: TextStyle(
                                fontFamily: "muli",
                                color: Colors.white,
                                fontSize: getProportionateScreenWidth(12),
                                // fontWeight: FontWeight.bold,
                                letterSpacing: 1.2),
                          )),
                        ])
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: getProportionateScreenHeight(120),
            ),
            Center(
                child: Image.asset(
              'assets/images/list.png',
              scale: 3,
            )),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Center(
              child: Text(
                'Set Your Daily/Weekly/Monthly Expenses',
                style: TextStyle(
                    fontFamily: 'Muli',
                    color: Colors.grey,
                    // fontWeight: FontWeight.bold,
                    fontSize: getProportionateScreenWidth(18)),
              ),
            )
          ],
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TrackerDetails()));
        },
        icon: Icon(Icons.add_circle),
        label: Text(
          'Create Own Expense',
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Muli'),
        ),
        tooltip: "Create an Expense to track daily ",
      ),
    );
  }
}
