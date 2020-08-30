import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sportsbnb/BenchListOfPlayers.dart';
import 'package:sportsbnb/DeclinedRequests.dart';
import 'package:sportsbnb/EnglishLanguage.dart'as Language;
import 'package:sportsbnb/OnBenchMatches.dart';
import 'package:sportsbnb/OrganizerMAtchDetails.dart';
import 'package:sportsbnb/PlayerMatches.dart';
import 'package:sportsbnb/SearchPlayers.dart';
import 'package:sportsbnb/UnConfirmedPlayers.dart';
import 'package:sportsbnb/WaitingListPlayers.dart';
class TabSCreenForMatchDetails extends StatefulWidget {
 
 
  @override
  _TabScreenForMatchDetailsState createState() => _TabScreenForMatchDetailsState();
}

class _TabScreenForMatchDetailsState extends State<TabSCreenForMatchDetails> with SingleTickerProviderStateMixin {



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
      
        title: Text(Language.Language.playingMatches),
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
                child: Text(Language.Language.confirmed
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
                child: Text(Language.Language.onBench
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
PlayerMatches(),
OnBenchMatches()
 ]
 )
 ,   
    ); 
    }



                      
}