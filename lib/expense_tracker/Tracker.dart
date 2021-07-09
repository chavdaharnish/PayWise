import 'package:flutter/material.dart';
import 'package:paywise/size_config.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class TrackerDetails extends StatefulWidget {
  @override
  _TrackerDetailsState createState() => _TrackerDetailsState();
}

class _TrackerDetailsState extends State<TrackerDetails> {
  String dropdownValue = 'Expense';
  DateTime selectedDate;
  // DateTime? selectedDate;

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
    return Scaffold(
        appBar: AppBar(
          title: DropdownButton<String>(
            value: dropdownValue,
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items: <String>['Expense', 'Income', 'Balance']
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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: Colors.cyan,
          label: Text("Add"),
          icon: Icon(Icons.add_circle),
        ),
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
                "You can change Expense to Income or Balance and add money",
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
                  // textAlign: TextAlign.center,
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

  TextFormField buildDescriptionFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Description",
        hintText: "Enter your Description",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // icon: Icon(Icons.note),
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildAmountFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Amount",
        hintText: "Enter your Amount",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // icon: Icon(Icons.note),
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
