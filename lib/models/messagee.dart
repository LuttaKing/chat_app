import 'package:cloud_firestore/cloud_firestore.dart';

class Messagee {
  final String message;
  final String senderEmail;
  final String senderId;
  final Timestamp timestamp;
  final String recieverId;

  const Messagee({
    required this.senderId,
    required this.message,
    required this.senderEmail,
    required this.timestamp,
    required this.recieverId,
  });

  // quikmethod to convert it to a map; coz thats how its stored in firebase
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'message': message,
      'timestamp': timestamp,
      'recieverId': recieverId,
    };
  }
}
