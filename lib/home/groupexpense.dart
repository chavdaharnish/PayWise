import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paywise/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseHistory extends StatefulWidget {
  @override
  _ExpenseHistory createState() => _ExpenseHistory();
}

class _ExpenseHistory extends State<ExpenseHistory> {
  Future _data;
  String name;
  String currentUserNumber;
  int count = 0;
  void initState() {
    getFriend();
    _data = getData();
    super.initState();
  }

  getFriend() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    CollectionReference getUserMobileNumber =
        FirebaseFirestore.instance.collection('Customer_Sign_In');
    getUserMobileNumber.where('email', isEqualTo: email).get().then((value) => {
          if (value.size > 0)
            {
              value.docs.forEach((element) {
                if (element['fname'] != null && element['lname'] != null) {
                  setState(() {
                    count = 1;
                    if (count == 1) {
                      _data = getData();
                      count = 0;
                    }
                    currentUserNumber = element['mobile'];
                    name = element['fname'] + ' ' + element['lname'];
                  });
                } else {
                  Fluttertoast.showToast(
                      msg: 'Email doesn\'t match',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              })
            }
          else
            {
              Fluttertoast.showToast(
                  msg: 'Friend Email doesn\'t match',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  fontSize: 16.0)
            }
        });
  }

  getData() async {
    var friend = FirebaseFirestore.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');

    QuerySnapshot qn = await friend
        .collection('Customer_Sign_In')
        .doc(email)
        .collection('history')
        .get();

    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: getProportionateScreenWidth(
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
                                          snapshot.data[index].data()['amount'],
                                      style: TextStyle(
                                          color: snapshot.data[index]
                                                      .data()['from'] ==
                                                  currentUserNumber
                                              ? Colors.green
                                              : Colors.red,
                                          fontFamily: 'Muli',
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              getProportionateScreenWidth(15))),
                                  title: Text.rich(
                                    TextSpan(
                                      style: TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                          text: 'From : ' +
                                              snapshot.data[index]
                                                  .data()['fromName'],
                                          style: TextStyle(
                                            fontFamily: 'Muli',
                                            fontSize:
                                                getProportionateScreenWidth(14),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: Text.rich(
                                    TextSpan(
                                      style: TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                            text: 'To : ' +
                                                snapshot.data[index]
                                                    .data()['toName']),
                                        TextSpan(
                                            text: '\nDescription : ' +
                                                snapshot.data[index]
                                                    .data()['description']),
                                      ],
                                    ),
                                  ),
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
    );
  }
}
