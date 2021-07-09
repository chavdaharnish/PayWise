import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:paywise/constants.dart';

// Future<http.Response> sendNotification(String title, String token) {
//   // EasyLoading.show(status: 'loading...');
//   return http.post(
//     Uri.https('fcm.googleapis.com', 'fcm/send'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Authorization': 'key=$serverKey'
//     },
//     body: jsonEncode(<String, Object>{
//       'to': token,
//       'notification': {'title': title, 'body': 'Your Request has been accepted'}
//     }),
//   );
// }

Future<http.Response> sendFriendNotification(String title, String token) {
  // EasyLoading.show(status: 'loading...');
  return http.post(
    Uri.https('fcm.googleapis.com', 'fcm/send'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'key=$serverKey'
    },
    body: jsonEncode(<String, Object>{
      'to': token,
      'notification': {
        'title': title,
        'body': 'added you for Expense Money!! Check it now!!'
      }
    }),
  );
}