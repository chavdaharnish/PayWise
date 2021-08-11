import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paywise/expense_tracker/Tracker.dart';
import 'package:paywise/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseTracker extends StatefulWidget {
  @override
  _ExpenseTracker createState() => new _ExpenseTracker();
}

class _ExpenseTracker extends State<ExpenseTracker> {
  Future _data;
  void initState() {
    _data = getFriends();
    super.initState();
  }

  Future getFriends() async {
    var friend = FirebaseFirestore.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');

    QuerySnapshot qn = await friend
        .collection('Customer_Sign_In')
        .doc(email)
        .collection('tracker')
        .get();
    return qn.docs;
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(
                  post: post,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: Card(
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(15.0),
          //       ),
          //       color: Colors.blueGrey,
          //       elevation: 10,
          //       child: Padding(
          //         // padding: const EdgeInsets.only(left: 25, top: 10, bottom: 10),
          //         padding: EdgeInsets.all(10),
          //         child: Table(
          //           defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          //           children: [
          //             TableRow(children: [
          //               Center(
          //                 child: Text(
          //                   "Income",
          //                   textScaleFactor: 1.5,
          //                   style: TextStyle(
          //                       fontFamily: "muli",
          //                       color: Colors.white,
          //                       fontWeight: FontWeight.bold,
          //                       letterSpacing: 1.2),
          //                 ),
          //               ),
          //               Center(
          //                 child: Text(
          //                   "Expense",
          //                   textScaleFactor: 1.5,
          //                   style: TextStyle(
          //                       fontFamily: "muli",
          //                       color: Colors.white,
          //                       fontWeight: FontWeight.bold,
          //                       letterSpacing: 1.2),
          //                 ),
          //               ),
          //               Center(
          //                   child: Text(
          //                 "Balance",
          //                 textScaleFactor: 1.5,
          //                 style: TextStyle(
          //                     fontFamily: "muli",
          //                     color: Colors.white,
          //                     fontWeight: FontWeight.bold,
          //                     letterSpacing: 1.2),
          //               )),
          //             ]),
          //             TableRow(children: [
          //               Center(
          //                 child: Text(
          //                   "5000",
          //                   textScaleFactor: 1.5,
          //                   style: TextStyle(
          //                       fontFamily: "muli",
          //                       color: Colors.white,
          //                       fontSize: getProportionateScreenWidth(12),
          //                       // fontWeight: FontWeight.bold,
          //                       letterSpacing: 1.2),
          //                 ),
          //               ),
          //               Center(
          //                 child: Text(
          //                   "400",
          //                   textScaleFactor: 1.5,
          //                   style: TextStyle(
          //                       fontFamily: "muli",
          //                       color: Colors.white,
          //                       fontSize: getProportionateScreenWidth(12),
          //                       // fontWeight: FontWeight.bold,
          //                       letterSpacing: 1.2),
          //                 ),
          //               ),
          //               Center(
          //                   child: Text(
          //                 "4600",
          //                 textScaleFactor: 1.5,
          //                 style: TextStyle(
          //                     fontFamily: "muli",
          //                     color: Colors.white,
          //                     fontSize: getProportionateScreenWidth(12),
          //                     // fontWeight: FontWeight.bold,
          //                     letterSpacing: 1.2),
          //               )),
          //             ])
          //           ],
          //         ),
          //       )),
          // ),
          Expanded(
            child: Container(
                padding: EdgeInsets.all(8.0),
                child: FutureBuilder(
                    future: _data,
                    // ignore: missing_return
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Text("Loading..."),
                        );
                      } else {
                        if (snapshot.data.length > 0) {
                          return ListView.separated(
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.all(5),
                              clipBehavior: Clip.hardEdge,
                              separatorBuilder: (context, index) => Divider(
                                    color: Colors.white,
                                    height: 20,
                                    thickness: 0,
                                  ),
                              shrinkWrap: false,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                final item = snapshot.data[index].toString();
                                return Dismissible(
                                    key: Key(item),
                                    onDismissed: (direction) {
                                      // showDialog(
                                      //     barrierDismissible: false,
                                      //     context: context,
                                      //     builder: (BuildContext context) =>
                                      //         CupertinoAlertDialog(
                                      //           title: Text('Remove ' +
                                      //               snapshot.data[index]
                                      //                   .data()['name']),
                                      //           content: Text(
                                      //               'Are you sure you want to remove ' +
                                      //                   snapshot.data[index]
                                      //                       .data()['name'] +
                                      //                   ' ? Your data and expenses will be deleted and your friend will also be notified about this remove and your data will never be recovered'),
                                      //           actions: <Widget>[
                                      //             CupertinoDialogAction(
                                      //                 child: Text('No'),
                                      //                 onPressed: () => {
                                      //                       // setState(() {
                                      //                       //   count = 1;
                                      //                       //   if (count == 1) {
                                      //                       //     _data = getFriends();
                                      //                       //     count = 0;
                                      //                       //   }
                                      //                       // }),
                                      //                       Navigator.of(
                                      //                               context)
                                      //                           .pop(),
                                      //                     }),
                                      //             CupertinoDialogAction(
                                      //               child: Text('Yes'),
                                      //               onPressed: () => {
                                      //                 EasyLoading.show(
                                      //                     status: 'loading...'),
                                      //                 setState(() {
                                      //                   String friendEmail =
                                      //                       snapshot.data[index]
                                      //                               .data()[
                                      //                           'email'];
                                      //                   // removeFriend(
                                      //                   //     friendEmail, context);
                                      //                   // ignore: unnecessary_statements
                                      //                   snapshot.data
                                      //                       .removeAt[index];
                                      //                   Navigator.of(context)
                                      //                       .pop();
                                      //                 })
                                      //               },
                                      //             ),
                                      //           ],
                                      //         ));
                                    },
                                    background: Container(
                                        color: Colors.red,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right:
                                                        getProportionateScreenWidth(
                                                            20)),
                                                child: Icon(
                                                  Icons.delete_forever,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ])),
                                    child: Container(
                                      child: ListTile(
                                          leading: Image.asset(
                                            "assets/images/app_logo.png",
                                          ),
                                          // trailing: Text(
                                          //     '\u20B9' +
                                          //         (int.parse(snapshot
                                          //                 .data[index]
                                          //                 .data()['total']))
                                          //             .abs()
                                          //             .toString(),
                                          //     style: TextStyle(
                                          //         color: int.parse(snapshot
                                          //                         .data[index]
                                          //                         .data()[
                                          //                     'total']) <
                                          //                 0
                                          //             ? Colors.red
                                          //             : Colors.green,
                                          //         fontFamily: 'Muli',
                                          //         fontWeight: FontWeight.bold,
                                          //         fontSize:
                                          //             getProportionateScreenWidth(
                                          //                 15))),
                                          title: Text.rich(
                                            TextSpan(
                                              style: TextStyle(
                                                  color: Colors.black),
                                              children: [
                                                TextSpan(
                                                  text: snapshot.data[index]
                                                      .data()['date']
                                                      .replaceAll(" ", " - "),
                                                  style: TextStyle(
                                                    fontFamily: 'Muli',
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            18),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // subtitle: Text.rich(
                                          //   TextSpan(
                                          //     style: TextStyle(
                                          //         color: Colors.black),
                                          //     children: [
                                          //       TextSpan(
                                          //           text: snapshot.data[index]
                                          //               .data()['mobile']),
                                          //     ],
                                          //   ),
                                          // ),
                                          onTap: () => {
                                                navigateToDetail(
                                                    snapshot.data[index]),
                                              }),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            blurRadius: 6,
                                            offset: Offset(-4, 4),
                                          ),
                                        ],
                                      ),
                                    ));
                              });
                        } else {
                          return Column(children: [
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
                          ]);
                        }
                      }
                    })),
          )
        ],
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

class DetailPage extends StatefulWidget {
  final DocumentSnapshot post;

  DetailPage({this.post});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future _data;
  int count = 0;
  String name;
  String currentUserNumber;
  String dropdownValue = 'You Paid';
  var income = 0;
  var expense = 0;
  var balance = 0;

  void initState() {
    _data = getData();
    super.initState();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    String date = widget.post.id.toString().trim();

    var friend = FirebaseFirestore.instance
        .collection('Customer_Sign_In')
        .doc(email)
        .collection('tracker');

    QuerySnapshot qn = await friend.doc(date).collection('Expense').get();

    income = 0;
    expense = 0;

    qn.docs.forEach((element) {
      if (element['type'] != null) {
        if (element['type'] == 'Expense') {
          setState(() {
            expense = expense + int.parse(element['amount']);
          });
        } else if (element['type'] == 'Income') {
          setState(() {
            income = income + int.parse(element['amount']);
          });
        }
      }
    });
    setState(() {
      balance = income - expense;
    });

    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            widget.post.id.replaceAll(" ", " - "),
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'muli',
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
            child: Column(children: [
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
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
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
                            income.toString(),
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
                            expense.toString(),
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
                          balance.toString(),
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
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: FutureBuilder(
                  future: _data,
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Text("Loading..."),
                      );
                    } else {
                      if (snapshot.data != null) {
                        if (snapshot.data.length > 0) {
                          return ListView.separated(
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.all(5),
                              clipBehavior: Clip.hardEdge,
                              separatorBuilder: (context, index) => Divider(
                                    color: Colors.white,
                                    height: 20,
                                    thickness: 0,
                                  ),
                              shrinkWrap: false,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                final item = snapshot.data[index].toString();
                                return Dismissible(
                                    key: Key(item),
                                    onDismissed: (direction) {},
                                    background: Container(
                                        color: Colors.red,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right:
                                                        getProportionateScreenWidth(
                                                            20)),
                                                child: Icon(
                                                  Icons.delete_forever,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ])),
                                    child: Container(
                                      child: ListTile(
                                          // leading: Image.asset(
                                          //   "assets/images/app_logo.png",
                                          // ),
                                          trailing: Text(
                                              '\u20B9' +
                                                  snapshot.data[index]
                                                      .data()['amount'],
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontFamily: 'Muli',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      getProportionateScreenWidth(
                                                          15))),
                                          title: Text.rich(
                                            TextSpan(
                                              style: TextStyle(
                                                  color: Colors.black),
                                              children: [
                                                TextSpan(
                                                  text: 'Description : ' +
                                                      snapshot.data[index]
                                                              .data()[
                                                          'description'],
                                                  style: TextStyle(
                                                    fontFamily: 'Muli',
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            14),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // subtitle: Text.rich(
                                          //   TextSpan(
                                          //     style: TextStyle(
                                          //         color: Colors.black),
                                          //     children: [
                                          //       // TextSpan(
                                          //       //     text: 'To : ' +
                                          //       //         snapshot.data[index]
                                          //       //             .data()['toName']),
                                          //       TextSpan(
                                          //           text: '\nDescription : ' +
                                          //               snapshot.data[index]
                                          //                       .data()[
                                          //                   'description']),
                                          //     ],
                                          //   ),
                                          // ),
                                          onTap: () => {
                                                // navigateToDetail(snapshot.data[index]),
                                              }),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            blurRadius: 6,
                                            offset: Offset(-4, 4),
                                          ),
                                        ],
                                      ),
                                    ));
                              });
                        } else {
                          return SingleChildScrollView(
                              child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: getProportionateScreenHeight(150),
                              ),
                              Center(
                                  child: Image.asset(
                                'assets/images/broke.png',
                                scale: 2,
                              )),
                              Text(
                                'No Expanses Yet',
                                style: TextStyle(
                                    fontFamily: 'Muli',
                                    color: Colors.grey,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: getProportionateScreenWidth(22)),
                              )
                            ],
                          ));
                        }
                      }
                    }
                  }),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(50),
          )
        ])));
  }
}
