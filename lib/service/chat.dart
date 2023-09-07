import 'package:chat_app/models/messagee.dart';
import 'package:chat_app/service/notif.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatService extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(
      BuildContext context, String recieverId, String message) async {
    final String currentUserEmail = Provider.of<MainNotifier>(context,listen: false).email!;
    final String currentUserId = Provider.of<MainNotifier>(context,listen: false).uid!;
    final Timestamp timestamp = Timestamp.now();

    Messagee newMessage = Messagee(
        senderId: currentUserId,
        message: message,
        senderEmail: currentUserEmail,
        timestamp: timestamp,
        recieverId: recieverId);
    // create room with currents and reciever ids
    List ids = [currentUserId, recieverId];
    ids.sort(); // to ensure its always the same for any pair
    String chatroomId = ids.join('___');

    //add to database
    _firestore
        .collection('chat_rooms')
        .doc(chatroomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessage(String userId, String otherUserId) {
    // create room with currents and reciever ids
    List ids = [userId, otherUserId];
    ids.sort(); // to ensure its always the same for any pair
    String chatroomId = ids.join('___');

    return _firestore
        .collection('chat_rooms')
        .doc(chatroomId)
        .collection('messages')
        .orderBy('timestamp', descending: false).snapshots();
  }
}
