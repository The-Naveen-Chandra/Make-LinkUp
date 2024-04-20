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

String formatChatTimestamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  DateTime now = DateTime.now();

  // Check if the timestamp is from today
  if (dateTime.year == now.year &&
      dateTime.month == now.month &&
      dateTime.day == now.day) {
    // Format time with AM/PM for today's messages
    return DateFormat.jm().format(dateTime); // E.g., '6:00 PM'
  }

  // Check if the timestamp is from yesterday
  DateTime yesterday = now.subtract(const Duration(days: 1));
  if (dateTime.year == yesterday.year &&
      dateTime.month == yesterday.month &&
      dateTime.day == yesterday.day) {
    return 'Yesterday';
  }

  // For older dates, return in dd-MM-yyyy format
  return DateFormat('dd-MM-yyyy').format(dateTime); // E.g., '01-01-2024'
}
