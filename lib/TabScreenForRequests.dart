import 'package:sportsbnb/EnglishLanguage.dart' as Language;
import 'package:flutter/material.dart';
import 'package:sportsbnb/MatchRequests.dart';
import 'package:sportsbnb/TabScreenForMatchDetails.dart';
import 'package:sportsbnb/TeamRequests.dart';

class TabScreenForRequests extends StatefulWidget {
 
 
  @override
  TabScreenForRequestsState createState() => TabScreenForRequestsState();
}

class TabScreenForRequestsState extends State<TabScreenForRequests> with SingleTickerProviderStateMixin {



TabController tabController;



@override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      

      appBar: AppBar(
      
        title: Text(Language.Language.requests),
    bottom: TabBar(
      controller: tabController,
      indicatorColor: Theme.of(context).buttonColor,
      indicatorWeight: 5,
      // indicatorPadding: EdgeInsets.all(20),
  
      tabs: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              color: Theme.of(context).buttonColor,
              height: MediaQuery.of(context).size.height/25,
              width: MediaQuery.of(context).size.width/3,
              child: Center(
                child: Text(Language.Language.matchRequests
                ,
                style: TextStyle(
                  color: Colors.white
                ),),
              ),
            ),
          ),



          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              color: Theme.of(context).buttonColor,
              height: MediaQuery.of(context).size.height/25,
              width: MediaQuery.of(context).size.width/3,
              child: Center(
                child: Text(Language.Language.teamRequests
                ,
                style: TextStyle(
                  color: Colors.white
                ),),
              ),
            ),
          ),




// ClipRRect(
//             borderRadius: BorderRadius.circular(30),
//             child: Container(
//               color: Theme.of(context).buttonColor,
//               height: MediaQuery.of(context).size.height/25,
//               width: MediaQuery.of(context).size.width/3,
//               child: Center(
//                 child: Text(Language.Language.declinedPlayers
//                 ,
//                 style: TextStyle(
//                   color: Colors.white
//                 ),),
//               ),
//             ),
//           ),

      ]
      ),
      ),
 body: TabBarView(
   controller: tabController,
   children: 
   [
MatchRequests(),
TeamRequests()
 ]
 )
 ,   
    ); 
    }



                      
}