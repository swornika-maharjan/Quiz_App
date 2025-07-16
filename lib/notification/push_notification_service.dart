// import 'dart:convert';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:http/http.dart' as http;

// Future<void> sendPushNotification() async {
//   final serverKey =
//       'BKjUsj_OX4GeMf-MALTlF-yq26KltYAchjNwA3Az8eAYwLAkxu-3IIBIU7wvk0MVv7vbi1zpvUByJSbmcqsP33w';
//   final fcmToken = await FirebaseMessaging.instance.getToken();

//   if (fcmToken == null) {
//     print('Unable to get FCM token');
//     return;
//   }

//   final body = {
//     "to": fcmToken,
//     "notification": {
//       "title": "🎉 Quiz Completed!",
//       "body": "You’ve successfully submitted the quiz!",
//       "sound": "default",
//     },
//     "priority": "high",
//   };

//   final response = await http.post(
//     Uri.parse(
//       'https://fcm.googleapis.com/v1/projects/quiz-app-1542a/messages:send',
//     ),

//     headers: {
//       "Content-Type": "application/json",
//       "Authorization": "key=$serverKey",
//     },
//     body: jsonEncode(body),
//   );

//   print("FCM Token: $fcmToken");
//   print("Payload: ${jsonEncode(body)}");
//   print("Status Code: ${response.statusCode}");
//   print("Push Response: ${response.body}");
//   print("Authorization header: key=$serverKey");
// }
