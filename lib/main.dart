

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sportsbnb/HomeBar.dart';
import 'package:sportsbnb/LoginOrRegister.dart';

void main()
{
  runApp(
    MaterialApp(
      title: 'Dk Demo App',
      home: LoginOrRegister(),
      routes: {
        'homeBar': (context) => HomeBar(),
        'loginOrRegister':(context)=>LoginOrRegister() 
      },

      
      theme: ThemeData(
        bottomAppBarColor: Colors.blue,
        primaryColor: Colors.blue,
        accentColor: Colors.blue,
        buttonColor: Colors.blue[900],
        backgroundColor: Colors.white,
        cursorColor: Colors.blue,
       scaffoldBackgroundColor: Colors.white,
       indicatorColor: Colors.blue,
     textTheme: TextTheme(
   
     )
        
      ),
    )
  );
}