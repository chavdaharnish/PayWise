import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paywise/home/home_screen.dart';
import 'package:paywise/size_config.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackerDetails extends StatefulWidget {
  @override
  _TrackerDetailsState createState() => _TrackerDetailsState();
}

class _TrackerDetailsState extends State<TrackerDetails> {
  String dropdownValue = 'Expense';
  DateTime selectedDate;
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }
  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != selectedDate)
  //     setState(() {
  //       selectedDate = picked;
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: DropdownButton<String>(
            value: dropdownValue,
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items: <String>['Expense', 'Income']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                        letterSpacing: 1.1,
                        fontFamily: 'muli',
                        fontSize: getProportionateScreenWidth(18)),
                  ));
            }).toList(),
          ),
          // title: Text(
          //   'Expense Tracker',
          //   style: TextStyle(letterSpacing: 1.1, fontFamily: 'muli'),
          // ),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: showFab
            ? Transform.scale(
                scale: 1.1,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    String des, amount;
                    des = _descriptionController.text.trim();
                    amount = _amountController.text.trim();
                    if (des != null && amount != null) {
                      EasyLoading.show(status: 'loading...');
                      addDetails(selectedDate, des, amount);
                    }
                  },
                  backgroundColor: Colors.cyan,
                  label: Text("Add"),
                  icon: Icon(Icons.add_circle),
                ))
            : null,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(getProportionateScreenWidth(10)),
          child: Column(
            children: [
              Image.asset("assets/images/app_logo.png"),
              // SizedBox(height: SizeConfig.screenHeight * 0.04),
              // Text(
              //   "Welcome to Expense Tracker",
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontSize: getProportionateScreenWidth(20),
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // SizedBox(height: SizeConfig.screenHeight * 0.01),
              Text(
                "You can set montly Income and deduct expenses from it.",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              buildDescriptionFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildAmountFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              // Text(
              //   "${selectedDate.toLocal()}".split(' ')[0],
              //   style:
              //       TextStyle(fontWeight: FontWeight.bold, fontFamily: 'muli'),
              // ),
              // SizedBox(
              //   height: 20.0,
              // ),
              // ignore: deprecated_member_use
              RaisedButton(
                color: Colors.blueGrey,
                // onPressed: () => _selectDate(context),
                onPressed: () {
                  showMonthPicker(
                    context: context,
                    firstDate: DateTime(DateTime.now().year - 1, 5),
                    lastDate: DateTime(DateTime.now().year + 1, 9),
                    initialDate: selectedDate ?? DateTime.now(),
                    locale: Locale("en"),
                  ).then((date) {
                    if (date != null) {
                      setState(() {
                        selectedDate = date;
                      });
                    }
                  });
                },
                child: Text(
                  'Year: ${selectedDate?.year}\nMonth: ${selectedDate?.month}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'muli',
                      color: Colors.white),
                ),
                // child: Text(
                //   "${selectedDate.toLocal()}".split(' ')[0],
                //   style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontFamily: 'muli',
                //       color: Colors.white),
                // ),
              ),
            ],
          ),
        ));
  }

  addDetails(var date, var des, var amount) async {
    var addTracker = FirebaseFirestore.instance.collection('Customer_Sign_In');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    String finalDate = date?.month.toString() + " " + date?.year.toString();

    addTracker
        .doc(email)
        .collection('tracker')
        .doc(finalDate)
        .collection('Expense')
        .add({
      'description': des,
      'amount': amount,
      'finalDate': finalDate,
      'type': dropdownValue
    }).then((value) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(
          msg: '...Data Added Successfully...',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen(),
        ),
        (route) => false,
      );
    });
  }

  TextFormField buildDescriptionFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: _descriptionController,
      decoration: InputDecoration(
          labelText: "Description",
          hintText: "Enter your Description",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(
            Icons.notes_rounded,
            color: Colors.cyan,
          )),
    );
  }

  TextFormField buildAmountFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _amountController,
      decoration: InputDecoration(
        labelText: "Amount",
        hintText: "Enter your Amount",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
