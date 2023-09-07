// ignore_for_file: prefer_const_constructors

import 'package:chat_app/components/constants.dart';
import 'package:chat_app/components/mytextfil.dart';
import 'package:chat_app/service/chat.dart';
import 'package:chat_app/service/notif.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final String recieverEmail;
  final String recieverUid;
  const ChatPage(
      {super.key, required this.recieverEmail, required this.recieverUid});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ScrollController _scrollController = new ScrollController();

  TextEditingController _messagecontroller = TextEditingController();
  ChatService _chatService = ChatService();

  String message = 'default';

  void _sendMessage() async {
    if (_messagecontroller.text.isNotEmpty) {
      await _chatService.sendMessage(
          context, widget.recieverUid, 
          _messagecontroller.text);

    _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 500),
        ).hashCode;

      
      _messagecontroller.clear();

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recieverEmail),
        backgroundColor: secondaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            Expanded(child: _buildMessageList()),
            
            _buildMessageInput(),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }


  

  Widget _buildMessageItem(DocumentSnapshot doc) {
     double screenWidth = MediaQuery.of(context).size.width;
    final String currentUserId = Provider.of<MainNotifier>(context).uid!;
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;



    return Align(
        alignment: isCurrentUser(data, currentUserId)
              ? Alignment.centerRight
              : Alignment.centerLeft,
      child: UnconstrainedBox(
        child: Container(
               constraints:BoxConstraints(maxWidth: screenWidth*0.8,
               minWidth: screenWidth*0.15
               ),
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(10.0), // Adjust the radius as needed
           color:isCurrentUser(data, currentUserId)? primaryColor : Colors.lightBlue
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
            child: Column(
               crossAxisAlignment: isCurrentUser(data, currentUserId)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        mainAxisAlignment: isCurrentUser(data, currentUserId)
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
              children: [
                Text(data['message'],
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  _buildMessageList() {
    final String currentUserId = Provider.of<MainNotifier>(context).uid!;
    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.getMessage(widget.recieverUid, currentUserId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          Text('Error ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          CupertinoActivityIndicator();
        }

        return ListView(
         controller: _scrollController,
          children: snapshot.data!.docs.map<Widget>((doc) => _buildMessageItem(doc))
              .toList(),
        );
      },
    );
  }

  bool isCurrentUser(Map<String, dynamic> data, String currentUserId) {
   return data['senderId'] == currentUserId;
  }



  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _messagecontroller,
              decoration: inputdectoration('Enter message'),
            ),
          ),
          IconButton(
              onPressed: () {
                _sendMessage();
             
              }
              ,
              icon: const Icon(
                Icons.send,
                color: secondaryColor,size: 35,
              ))
        ],
      ),
    );
  }
}
