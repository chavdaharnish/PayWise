import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:paywise/account/account.dart';
import 'package:paywise/constants.dart';
import 'package:paywise/friends_dashboard/friendsdashborad.dart';
import 'package:paywise/home/groupdashboard.dart';
import 'package:paywise/home/groupexpense.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '\homescreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          elevation: 4,
          bottom: TabBar(
            indicatorColor: Colors.indigo[900],
            indicatorWeight: 4,
            tabs: [
              Tab(
                text: "Tracker",
              ),
              Tab(
                text: "Friends",
              ),
              Tab(
                text: "Activity",
              ),
            ],
          ),
          centerTitle: true,
          title: Text(
            "PayWise",
            style: TextStyle(
              fontFamily: 'Muli',
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 24,
              color: Colors.white,
              letterSpacing: 0.8,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.supervised_user_circle,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, Account.routeName);
              },
              tooltip: "My Account",
            )
          ],
        ),
        body: TabBarView(
          children: [
            ExpenseTracker(),
            Friendsdashboard(),
            ExpenseHistory(),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _deviceToken();
  }

  _deviceToken() async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.getToken().then((token) {
      finalToken = token;
      _updateDeviceToken(token);
    });
  }

  _updateDeviceToken(String token) async {
    CollectionReference signIn =
        FirebaseFirestore.instance.collection('Customer_Sign_In');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    if (token.isNotEmpty) {
      return signIn.doc(email).update({'devicetoken': token});
    }
  }
}
