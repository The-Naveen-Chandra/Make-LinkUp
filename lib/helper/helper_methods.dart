// return a formatted data as a string

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
