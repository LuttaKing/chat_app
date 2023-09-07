// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chat_app/components/constants.dart';
import 'package:chat_app/service/notif.dart';
import 'package:chat_app/service/auths.dart';
import 'package:chat_app/pages/chatpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
        ),
        backgroundColor: secondaryColor,
        actions: [
          IconButton(
              onPressed: () {
                _authService.signOut(context);
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: _buildUserList(),
    );
  }

  _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
         if (snapshot.hasError) {
          Text('Error ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          CupertinoActivityIndicator();
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot doc) {
        String? currentsEmail = Provider.of<MainNotifier>(context).email;
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;

    //display all users except current
    if (currentsEmail != data['email']) {
      return ListTile(
        title: Text(data['email']),
        onTap: () {
          goToPage(context, ChatPage(recieverEmail: data['email'], recieverUid: data['uid'],));
        },
      );
    }
    return SizedBox();
  }
}
