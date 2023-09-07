

import 'package:flutter/material.dart';

const Color primaryColor = Color(0xff26BAD9);
const Color secondaryColor = Color(0xff187589);


void goToPage(BuildContext context, Widget page) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => page,
     
    ),
  );
}

showSnackx(BuildContext context,String message){
          return ScaffoldMessenger.of(context).showSnackBar(  
            
            SnackBar(duration: const Duration(seconds: 5),
              content: Text(message))
            
            
            );

}