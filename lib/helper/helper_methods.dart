// return a formatted data as a string
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String formatData(Timestamp timestamp) {
  // Timestamp is the object we retrieve from the firebase
  // so to display it, lets convert it to a text string

  DateTime dateTime = timestamp.toDate();

  // get the year
  String year = dateTime.year.toString();

  // get month
  String month = dateTime.month.toString();

  // get day
  String day = dateTime.day.toString();

  // final formatted data
  String formattedData = '$day/$month/$year';

  return formattedData;
}

String formatDate(DateTime dateTime, List<DocumentSnapshot> messages) {
  DateTime now = DateTime.now();
  DateTime todayStart = DateTime(now.year, now.month, now.day);
  DateTime yesterdayStart = DateTime(now.year, now.month, now.day - 1);

  if (dateTime.isAfter(todayStart)) {
    // Find the newest message timestamp for today
    DateTime newestMessageTime = DateTime.fromMillisecondsSinceEpoch(0);
    for (var doc in messages) {
      DateTime messageTime = (doc['timestamp'] as Timestamp).toDate();
      if (messageTime.isAfter(newestMessageTime) && messageTime.isBefore(now)) {
        newestMessageTime = messageTime;
      }
    }
    String timeFormat =
        DateFormat.jm().format(newestMessageTime); // Format time as "h:mm a"
    return "Today $timeFormat";
  } else if (dateTime.isAfter(yesterdayStart)) {
    return "Yesterday";
  } else {
    return DateFormat('MMMM dd, yyyy').format(dateTime);
  }
}
