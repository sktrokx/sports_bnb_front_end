import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sportsbnb/ErrorConnecting.dart';
import 'package:sportsbnb/FoundMatchDetails.dart';
import 'package:sportsbnb/NotAuthorizaed.dart';
import 'package:sportsbnb/OrganizerMAtchDetails.dart';

import 'package:http/http.dart' as http;

import 'package:sportsbnb/EnglishLanguage.dart' as Language;
import 'package:sportsbnb/UserCredentials.dart';
class WaitingListOfPlayers extends StatefulWidget {
   int matchId;
   int totalPlayers;
   int matchType;
  WaitingListOfPlayers(matchId,totalPlayers,matchType)
  {
    this.matchId = matchId;
    this.totalPlayers = totalPlayers;
    this.matchType  = matchType;
  }
  
  @override
  WaitingListOfPlayersState createState()
  {
   return WaitingListOfPlayersState(matchId,totalPlayers,matchType);
  }
}

class WaitingListOfPlayersState <T extends StatefulWidget> extends State<T>
 {
   int matchId;
   int totalPlayers;
   int matchType;
  WaitingListOfPlayersState(int matchId, int totalPlayers, int matchType) 
{
  this.matchId = matchId;
  this.totalPlayers = totalPlayers;
  this.matchType = matchType;
}

  // TODO: implement nothingFound
  String get nothingFound => Language.Language.onWaiting0;

  String get appBarTitle 
 {
   return Language.Language.onWaiting;
 }

  String get pathToGetDetails 
  {
return 'http://192.168.10.26:8000/organize_matches/show_organizer_waiting_list_of_match/${matchId}';
  }

  @override
  void initState() {
    
    super.initState();
    getMatchDetails  = matchDetails();
  }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      
      // floatingActionButton: getFloatingActionButton(),
      appBar: AppBar(
        title: Text(appBarTitle),
      // actions: [
      //  getActionButton()
      //                  ],
                       ),
                         body:
                         
                FutureBuilder(
                           future: getMatchDetails
                           ,builder:(context,snapshot)
                           {
                 
                             if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.waiting)
                             {
                               return SpinKitChasingDots(
                                   color:Theme.of(context).bottomAppBarColor,
                               );
                             }
                 
                             if (snapshot.connectionState == ConnectionState.done)
                             {
if(snapshot.data == null)
{
   return Center(
                                     child: ClipRRect(
                                       borderRadius: BorderRadius.circular(50),
                                       child: Container(
                                         height: MediaQuery.of(context).size.height/15,
                                         width: MediaQuery.of(context).size.width/2.1,
                                         color: Theme.of(context).buttonColor,
                                         child: Center(
                                           child: Row(
                                             children: [
                                                 Padding(
                                                   padding: const EdgeInsets.only(left:20),
                                                   child: Text(Language.Language.noBench,
                                                   style: TextStyle(
                                                     color: Colors.white,
                                                     fontSize: 18,
                                                     fontWeight: FontWeight.bold
                                                   ),
                                                   
                                                   ),
                                                 ),
                                                 Padding(
                                                   padding: const EdgeInsets.only(left:50),
                                                   child: addIcon
                                                 )
                                             ],
                                           ),
                                         ),
                                       ),
                                     ),
                                 );
}

                               if(snapshot.data.isEmpty)
                               {
                                 return Center(
                                     child: ClipRRect(
                                       borderRadius: BorderRadius.circular(50),
                                       child: Container(
                                         height: MediaQuery.of(context).size.height/15,
                                         width: MediaQuery.of(context).size.width/2.1,
                                         color: Theme.of(context).buttonColor,
                                         child: Center(
                                           child: Row(
                                             children: [
                                                 Padding(
                                                   padding: const EdgeInsets.only(left:20),
                                                   child: Text(nothingFound,
                                                   style: TextStyle(
                                                     color: Colors.white,
                                                     fontSize: 18,
                                                     fontWeight: FontWeight.bold
                                                   ),
                                                   
                                                   ),
                                                 ),
                                                 Padding(
                                                   padding: const EdgeInsets.only(left:50),
                                                   child: addIcon
                                                 )
                                             ],
                                           ),
                                         ),
                                       ),
                                     ),
                                 );
                               }
                 
                               else if(snapshot.data != null)
                               {
                                 return ListView.builder(
                                   itemCount: snapshot.data.length,
                                   itemBuilder: (context,index)
                                   {
                                       return playerDateGui(snapshot.data[index]);
                                                         }
                                                         );
                                                     }
                                                   }
                                                 }
                                                  )
                                           ) 
                                           
                                           ;
                                         }
                 
                                         Widget get addIcon
                                         {
                                           return Icon(Icons.add,
                                             color: Colors.white);
                                         }
                 
                 
                 
                                         Future matchDetails()
                                         async
                                         {
                                                 String pathToGetMAtchDetails = pathToGetDetails;
                                           try{
                                             var response = await http.get(pathToGetMAtchDetails,
                                             headers: <String,String>
                                             {
                                               'Content-Type':'application/json',
                                               'Authorization':'Token'+ UserCredentials.credentialsInstance.getTokenOfUser
                                             }
                                             );
                                             if(response.statusCode == 200)
                                          {
                                       listOfMatcheDetails = List<FoundMatchDetails>();
                                       
                                                 List<dynamic> json = jsonDecode(response.body);
                                                 for(var item in json)
                                                 {
                                                   FoundMatchDetails currentMatch =  FoundMatchDetails(item);
                                                   listOfMatcheDetails.add(currentMatch);
                                                   // debugPrint(currentMatch.title + 'current match title');
                                                 }
                                                 return listOfMatcheDetails;
                                               }
                                               else if(response.statusCode == 401)
{
  NotAuthorizaed.showNotAuthorizedAlert(context);
}
}
catch(e)
{
  // Navigator.pop(context);
  ErrorConnecting.ConnectingIssue(context);
}
                                         }
                                       
                                         Widget playerDateGui(snapshotData)
                                          {
                                             return Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Card(
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(15)
                           ),
                           elevation: 10,
                           
                                   child: Container(
                             height: MediaQuery.of(context).size.height/9,
                             decoration: BoxDecoration(
                               
                             ),
                             // color: Colors.red,
                             
                                                 width: MediaQuery.of(context).size.width-20,
                             child: Stack(
                               children: <Widget>[
                                   Positioned(
                                     top: MediaQuery.of(context).size.height/100,
                                     right: MediaQuery.of(context).size.width/1.4,
                 
                                     child:ClipRRect(
                                       borderRadius: BorderRadius.circular(150),
                                       child: Container(
                                         height: MediaQuery.of(context).size.height/10,
                                         width:MediaQuery.of(context).size.width/5
                                         ,child: (snapshotData.playerImage == null)
                                         ?
                                           Image.asset('assets/noImage.jpeg',
                                                                   height: MediaQuery.of(context).size.height/20,
                                         width:MediaQuery.of(context).size.width/6
                  ,
                                           ):
                                           (snapshotData.playerImage!=null)?
                                           Image.memory(snapshotData.playerImage):
                                           Container()
                                         ,
                                       ),
                                     ) 
                 
                                      ),
                                      Positioned(
                                        bottom: MediaQuery.of(context).size.height/14,
                                        left: MediaQuery.of(context).size.width/3.8,
                                        child: Text(snapshotData.playerName,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight:FontWeight.bold
                                        ),
                                        ),
                                      ),
                 
                                      Positioned(
                                        left: MediaQuery.of(context).size.width/3,
                                        bottom: MediaQuery.of(context).size.height/25,
                                        
                                        child: Text(snapshotData.playerPhoneNumber)),
                 
                                        Positioned(
                                        left: MediaQuery.of(context).size.width/3,
                                        bottom: MediaQuery.of(context).size.height/60,
                                        
                                        child: Text(snapshotData.playerEmailId))
                 
                               ]
                             )
                             )
                             )
                             );
                                          }
                //                            Widget getFloatingActionButton()
                //                           {
                //                             return FloatingActionButton(
                //                               child: Icon(Icons.add),
                //                               backgroundColor: Theme.of(context).buttonColor,
                //                               onPressed:()
                //                               {
                 
                //  if(totalPlayers >= matchType)
                //  {
                 
                //    return showDialog(context: context,
                //                    builder: (context)
                //                    {
                //                        return AlertDialog(
                //                            title: Text(Language.Language.alert),
                //                            content: Text(Language.Language.continueToLeave),
                //                            actions: <Widget>[
                //                              Row(
                //                                children: <Widget>[
                //                                                  dontDelete(Language.Language.no,context),
                //                                yesDelete(Language.Language.yes,matchId)
                                                                        
                //                                                  ],
                //                                             )
                //                                                          ],
                //                                                      );
                //                                                  }
                //                                  );
                //                                }
                 
                 
                //  else
                //  {
                //    goTo();
                //  }
                //  }
                                              
                                              
                //                               );
                //                           } 
                //  goTo()
                 
                //  {
                 
                //                                 Navigator.push(context, MaterialPageRoute(builder: (context)
                 
                //  {
                //    return SearchPlayers(matchId);
                //  }
                //  ));
                //  }
                 
//                   Widget dontDelete(String res,BuildContext context)
//                                                   {
                                                    
//                                                      return GestureDetector(
//                                                        onTap: ()
                                                       
//                                                        { 
//                                                              Navigator.pop(context);                      
//                                                        }
//                                                        ,
//                                                        child: Card(
//                                                          shape: RoundedRectangleBorder(
//                                                          borderRadius: BorderRadius.circular(10)
//                                                          ),
//                                                          child: Text(res),
//                                                        )
                                                       
//                                                        );
//                                                   }
                 
//                                                    Widget yesDelete(String res,int matchIde)
//                                                   {
                                                    
//                                                      return GestureDetector(
//                                                        onTap: ()
//                                                        async
//                                                        { 
//                                                          goTo();
//                                                        }
//                                                        ,
//                                                        child: Card(
//                                                          shape: RoundedRectangleBorder(
//                                                          borderRadius: BorderRadius.circular(10)
//                                                          ),
//                                                          child: Text(res),
//                                                        )
                                                       
//                                                        );
//                                                   }
                 
//                   dialogBoxForMenu()
//                    {
//           return showDialog(context: context,
//                                    builder: (context)
//                                    {
//                                        return AlertDialog(
//                                            title: Text(Language.Language.detailsDialog),
//                                            content: Text(Language.Language.detailsDialogContent),
//                                            actions: <Widget>[
//                                              Row(
//                                                children: <Widget>[
//                                                               dialogButton(
//                                                                 Language.Language.onWaiting,
//                                                                 ()
//                                                                 {
//                                                                   Navigator.push(context, MaterialPageRoute(builder: (context)
//                                                                   {
//                                                                      return WaitingListOfPlayers(matchId, totalPlayers, matchType);
//                                                                   }  
//                                                                   ));
//                                                                 }
//                                                               ),
       
//                                                               dialogButton(
//                                                                 Language.Language.onBench,
//                                                                 ()
//                                                                 {
//                                                                   Navigator.push(context, MaterialPageRoute(builder: (context)
//                                                                   {
//                                                                      return BenchListOfPlayers(matchId, totalPlayers, matchType);
//                                                                   }  
//                                                                   ));
//                                                                 }
//                                                               ),
                                                              
                                                                                                                      
//                                                                      ],
//                                                             )
//                                                                          ],
//                                                                      );
//                                                                  }
//                                                  );
//                                                }
                 
                              
//         Widget dialogButton(String str,Function function)
//         {
//           return GestureDetector(
//             onTap: () 
//             {
//        function();
//             },
//             child: Card(
//               child: Container(
//                 width: MediaQuery.of(context).size.width/4,
//                 height: MediaQuery.of(context).size.height/30,
//                color: Theme.of(context).buttonColor,
//               child: Center(
//         child:        Text(str,
//         style: TextStyle(
//           color: Colors.white
//         ),
//         )
//               ),
//               ),
//             ),
//           );
//         }
       
//         Widget getActionButton() 
//         {
//           return GestureDetector(
//           onTap: () => dialogBoxForMenu(),
//                             child: Container(
//                       // height:MediaQuery.of(context).size.height/50,
//                       width: MediaQuery.of(context).size.height/16,
//                       child: Icon(Icons.more_vert,
//                       size: MediaQuery.of(context).size.width/12,
//                       ),
//                       // color: Colors.red,
//                     ),
//                   );
//         }           
// }
}