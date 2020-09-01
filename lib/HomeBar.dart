import 'package:sportsbnb/EnglishLanguage.dart' as Language;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sportsbnb/Logout.dart';
import 'package:sportsbnb/Matches.dart';
import 'package:sportsbnb/TabScreenForMatchDetails.dart';
import 'package:sportsbnb/TabScreenForRequests.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
class HomeBar extends StatefulWidget
{
 

  @override
  State<StatefulWidget> createState() {
 return HomeBarState();
  }
  
}


class HomeBarState extends State<HomeBar>
{

 
int page = 0;
  

@override
  void initState() {
    // TODO: implement initState
    super.initState();
   

  }


  
  
  

  @override
  Widget build(BuildContext context) {



final pages = [
  TabSCreenForMatchDetails(),
  // PlayerMatches(),
  // GoToOrganizedMatches(),
  Matches(),
  TabScreenForRequests(),
  Logout()
];
 
 return  Scaffold(
     
     bottomNavigationBar: CurvedNavigationBar(
       
       items:<Widget>[
         Column(
           children: [
             Expanded(
               flex: 10,
               child: Icon(MdiIcons.soccer)),
               Expanded(
                 flex: 1,
                 child: 
               
               Text(Language.Language.playing,
               style: TextStyle(
                 fontWeight: FontWeight.bold
               ),
               )
               )
           ],
         ),
             Column(
           children: [
             Expanded(
               flex: 10,
               child: Icon(MdiIcons.soccerField)),
               Expanded(
                 flex: 1,
                 child: 
               
               Text(Language.Language.organized,
               style: TextStyle(
                 fontWeight: FontWeight.bold
               ),
               )
               )
           ],
         ),
              Column(
           children: [
             Expanded(
               flex: 10,
               child: Icon(Icons.notifications_active)),
               Expanded(
                 flex: 1,
                 child: 
               
               Text(Language.Language.requests,
               style: TextStyle(
                 fontWeight: FontWeight.bold
               ),
               )
               )
           ],
         ),
             Column(
           children: [
             Expanded(
               flex: 10,
               child: Icon(Icons.lock)),
               Expanded(
                 flex: 1,
                 child: 
               
               Text(Language.Language.profile,
               style: TextStyle(
                 fontWeight: FontWeight.bold
               ),
               )
               )
           ],
         ),
       ],
       onTap: (index)
       {  
         setState(() {
           page = index;
         });
       },
       
       color: Colors.white,
       backgroundColor: Theme.of(context).primaryColor,
       buttonBackgroundColor: Colors.white,
       height: 45,
        ),
     body:pages[page]
   
 );
  }



 

  
}