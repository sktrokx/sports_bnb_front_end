import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sportsbnb/ErrorConnecting.dart';
import 'package:sportsbnb/Loading.dart' as Loading ;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:sportsbnb/DatabaseHelper.dart';
import 'package:sportsbnb/FoundMatchData.dart';
import 'package:sportsbnb/MatchRequestData.dart';
import 'package:sportsbnb/NotAuthorizaed.dart';
import 'package:sportsbnb/PlayerFoundData.dart';
import 'package:sportsbnb/PlayerMatchesFound.dart';
import 'package:sportsbnb/UserCredentials.dart';
import 'package:sportsbnb/EnglishLanguage.dart' as Language;


class PlayerMatches extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
 
 return PlayerMatchesState();
  }
  
}


class PlayerMatchesState <T extends StatefulWidget> extends State<T>
{


 FirebaseMessaging _fm;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  




@override
  void initState() {


_fm  = FirebaseMessaging();



    // debugPrint('show notification method is working');
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var androidInitializer = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializer = IOSInitializationSettings();
    var generalInitializer = InitializationSettings(androidInitializer, iosInitializer);
    flutterLocalNotificationsPlugin.initialize(generalInitializer,onSelectNotification: (value)
    {

    }
    );


    _fm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
     
      },
  
     
      onLaunch: (Map<String, dynamic> message) async {
   print("onLaunch: $message");
          await showNotification(message);
      
      },
      onResume: (Map<String, dynamic> message) async {
   print("onResume: $message");
          await showNotification(message);
      
      }
   );



    super.initState();
   
    // showNotification('messageBody');
    debugPrint('init chal para hai');
  
  }




bool canSendRequestResponse = false;


// String  getUrlToAddPlayerToMatchOfThree = 'http://192.68.10.26:8000/organize_matches/add_player_to_match_of_three/';
// String getUrlToAddPlayerToMatchOfSeven = 'http://192.68.10.26:8000/organize_matches/add_player_to_match_of_seven/';
String getUrlToAddPlayerToMatchOfEleven = 'http://192.168.10.26:8000/organize_matches/delete_player_from_match_of_eleven/<match_id>/<player_id>';


// String urlToDeletePlayerFromMatchOfThree = 'http://192.168.10.26:8000/organize_matches/delete_player_from_match_of_three/';//yet to override
// String urlToDeletePlayerFromMatchOfSeven = 'http://192.168.10.26:8000/organize_matches/delete_player_from_match_of_seven/';//yet to override
String urlToDeletePlayerFromMatchOfEleven = 'http://192.168.10.26:8000/organize_matches/delete_player_from_match_of_eleven/';//yet to override



String get getRequestsOfEleven
{
  return 'http://192.168.10.26:8000/organize_matches/show_player_their_matches_of_eleven/${UserCredentials.credentialsInstance.getIdOfUser}';
}

// String get getRequestsOfSeven
// {
//   return 'http://192.168.10.26:8000/organize_matches/show_player_their_matches_of_seven/${UserCredentials.credentialsInstance.getIdOfUser}';
// }

// String get getRequestsOfThree
// {
//   return 'http://192.168.10.26:8000/organize_matches/show_player_their_matches_of_three/${UserCredentials.credentialsInstance.getIdOfUser}';
// }





String get appBarTitle
{
  return Language.Language.playing;
}

  @override
  Widget build(BuildContext context) {
      return
//        Scaffold(
// appBar: AppBar(
//   title: Text(appBarTitle),
// leading: Container(),
// ),
// body: 
Container(
 child: getCustomTile(context,getRequestsOfEleven,getUrlToAddPlayerToMatchOfEleven
    ,urlToDeletePlayerFromMatchOfEleven));
    // Expanded(child: getCustomTile(context,getRequestsOfSeven,getUrlToAddPlayerToMatchOfSeven,
    // urlToDeletePlayerFromMatchOfSeven
    // )),
    // Expanded(child: getCustomTile(context,getRequestsOfThree,getUrlToAddPlayerToMatchOfEleven,
    // urlToDeletePlayerFromMatchOfThree
    // ))
  

      
  }
    List<PlayersMatchesFound> playerMatchesFound;
Widget getCustomTile(context,urlToGetData,urlToPostRequest,urlToDelete)
{
  return Container(
    child:FutureBuilder(
      future: getFutureBuilderData(urlToGetData),  
      builder: (context,snapshot)
      {
        if(snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.active)
        {
          return SpinKitChasingDots(
            color: Theme.of(context).bottomAppBarColor,
          );
        }
        if(snapshot.connectionState == ConnectionState.done)
        {
          if(snapshot.data == null)
          {
               return noMatchesCard(context);
          }
          return Container(
            height: MediaQuery.of(context).size.height,
            width:  MediaQuery.of(context).size.width,
                      child: ListView.builder(
              // scrollDirection: Axis.horizontal,
              itemCount: (snapshot.data == null)?
              0:
              snapshot.data.length,
              itemBuilder: (context,index)
              { 
                return customTile(snapshot.data[index],urlToPostRequest,urlToDelete);
                            } 
                            ),
          );
                      }
                    }
                    )
                  
                );
              }  
              
              Future<dynamic> getFutureBuilderData(urlToGetData)
              async
              {
                try{
                var response =await http.get(urlToGetData
                ,
                headers: <String,String>
                {
                  'Content-Type':'application/json',
                  'Authorization':'Token '+UserCredentials.credentialsInstance.getTokenOfUser
                }
                );
                if(response.statusCode == 200)
                {
                  playerMatchesFound  = List<PlayersMatchesFound>();
                  List<dynamic> json = jsonDecode(response.body);
                  if(json.isNotEmpty)
                  {
                    for(var item in json)
                    {
                      PlayersMatchesFound data = PlayersMatchesFound(item);
                      playerMatchesFound.add(data);
              
                    }
                    return playerMatchesFound;
                  }
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
              
                Widget customTile(data,urlToPostRequest,urlToDelete) 
                {
                  return Padding(
                    padding: const EdgeInsets.only(top:15,bottom: 8,left:3,right:3),
                    child: Card(
                      shape: RoundedRectangleBorder(

                            borderRadius: BorderRadius.circular(15),
                      ),
                                    elevation: 10,                            
                                                          child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30)                                       
                                    
                                ),
                                height: MediaQuery.of(context).size.height/3,
                                // width: MediaQuery.of(context).size.width/2,
                                // color:Theme.of(context).bottomAppBarColor.withOpacity(0.6)
                                // color:Colors.white
                              // ,
                              child: Stack(
                        children: [
                          

                          Positioned(
                              top: MediaQuery.of(context).size.height/30,
                              left: MediaQuery.of(context).size.width/50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(150),
                                    child: Container(
                                      height: MediaQuery.of(context).size.height/8.4,
                                      width: MediaQuery.of(context).size.width/4,
                                      child:
                                       (data.organizerData.organizerImage!=null)?Image.memory(data.organizerData.organizerImage):
                                      (data.organizerData.organizerImage == null)?
                                      Image.asset('assets/noImage.jpeg')
                                      :
                                      Container()
                                      
                                    ),
                              )
                                              
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height/8,
                                child: 
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)
                                  
                                ),
                                elevation: 10,
                                child: Container(

                                  height:(data.organizerData.name.length <= 15)? MediaQuery.of(context).size.height/30:
                                                  (data.organizerData.name.length >= 15)?MediaQuery.of(context).size.height/15:
                                                  MediaQuery.of(context).size.height/15,
                                  width: MediaQuery.of(context).size.width/3,
                                  // color: Colors.red,
                                child: Center(child: Text(data.organizerData.name)),
                                ),
                              )
                              ),

                                         
                              Positioned(
                                top: MediaQuery.of(context).size.height/20,
                                left:MediaQuery.of(context).size.width/2.7,
                                
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),                        child: Container(
                                    child: Container(
                                      height: MediaQuery.of(context).size.height/6,
                                      width: MediaQuery.of(context).size.width/1.63,
                                      
                                      color:Theme.of(context).buttonColor,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: MediaQuery.of(context).size.height/20,
                                            left: MediaQuery.of(context).size.width/15,
                                                                                    child: Text(data.matchData.addressOfStadium,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white
                                            ),
                                            ),
                                          ),
                                          Positioned(
                                              top: MediaQuery.of(context).size.height/13,
                                            left: MediaQuery.of(context).size.width/15,
                                          
                                                                                    child: Text(data.matchData.city,
                                            style: TextStyle(
                                              fontSize: 18
                                              ,color: Colors.white
                                            ),
                                            ),
                                          ),
                                          Positioned(
                                              top: MediaQuery.of(context).size.height/9.5,
                                            left: MediaQuery.of(context).size.width/15,
                                          
                                                                                    child: Text('${Language.Language.date} ${data.matchData.date}   ',
                                            style: TextStyle(
                                              fontSize: 18
                                            ,
                                            color: Colors.white
                                            ),
                                            ),
                                          ),

                                            Positioned(
                                              top: MediaQuery.of(context).size.height/7.5,
                                            left: MediaQuery.of(context).size.width/15,
                                          
                                                                                    child: Text('${Language.Language.time}  ${data.matchData.time}',
                                            style: TextStyle(
                                              fontSize: 18
                                            ,
                                            color: Colors.white
                                            ),
                                            ),
                                          )



                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                ),
                                                                                         Positioned(

                                                                   top: MediaQuery.of(context).size.height/30,
                                left:MediaQuery.of(context).size.width/2.7,
                                

                                                     child: Card(
                                            elevation: 10,
                                            child: Container(
                                            height: MediaQuery.of(context).size.height/25,
                                            width: MediaQuery.of(context).size.width/2,
                                            // color: Colors.red,
                                            child: Center(child: Text(data.matchData.title,
                                            style: TextStyle(
                                              fontSize: 18
                                            
                                                     ))))),
                                                           ),

      Positioned(
        bottom: 50,
        child: getPlayersOfMatch(context,data,urlToPostRequest,urlToDelete)
      ),

      Positioned(
        bottom: 25,
        right: 10,
        child: getMaxPlayers(data.maxPlayers),
      ),

      Positioned(
        bottom: 10,
        right: 10,
        child: getCostOfMatch(data.matchData.cost),
        
              )
                                ],
                              ),
                                                ),
                                    )           
                                                     
                          );
                          
                        }
                        Widget getMaxPlayers(maxPlayers)
                        {
                            return Container(
                              height: 25,
                              width: 150,
                              // color: Colors.red,
                              child: Center(child: Text('${Language.Language.maxPlayers} ${maxPlayers}')));
                        }
        
        Widget getPlayersOfMatch(context,snapshotData,urlToPostRequest,urlToDelete)
        {
          return   Container(
              height: MediaQuery.of(context).size.height/20,
              width: MediaQuery.of(context).size.width,
              // color: Theme.of(context).buttonColor,
              child:(snapshotData.hasAccepted ==  false && snapshotData.hasDeclined == false)?
              Row(
                children: [
        
                  Padding(
                    padding: const EdgeInsets.only(left:25),
                    child: getCustomButton(Language.Language.quitMatch,
                    ()
        
                    async{
                      Loading.ShowLoadingDialog.showLoaderDialog(context);
                      try{
                      var response = await http.delete('${urlToDelete}${snapshotData.matchId}/${UserCredentials.credentialsInstance.getIdOfUser}',
                      headers: <String,String>
                      {
                          'Content-Type':'application/json',
                          'Authorization': 'Token ' + UserCredentials.credentialsInstance.getTokenOfUser
                      }
                      );
                      if(response.statusCode == 200)
                      {
                        Navigator.pop(context);
                        setState(() {
                          
                        });
                      }
                    }
        catch(e)
        {
          Navigator.pop(context);
          ErrorConnecting.ConnectingIssue(context);
        }
                    }
                    ,
                    true
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:25),
                    child: getCustomButton('${Language.Language.players}: ${snapshotData.totalPlayers}',
                    ()
                    async
        {
         try{
          var response  = await http.post(urlToPostRequest
          ,
          headers: <String,String>
          {
            'Content-Type':'application/json',
            'Authorization': 'Token ' + UserCredentials.credentialsInstance.getTokenOfUser
          },
          body: jsonEncode(<String,dynamic>
          {
            'user_id': UserCredentials.credentialsInstance.getIdOfUser,
            'match_id':snapshotData.matchId
          }
          )
          );
          if (response.statusCode == 200)
          {
            setState(() {
              
            });
          }
        }
        catch(e)
        {
          // Navigator.pop(context);
          ErrorConnecting.ConnectingIssue(context);
        }
        }   ,
        false       
                    ),
                  )
                ],
              ):
              Container()
              );
        
        }
        
        
        
        
        
        Widget getCustomButton(option,Function toDo,bool okToDo)
        {
          return GestureDetector(
            onTap: ()
            {
              if( okToDo == true)
              
              {
               toDo();
              }
            }
            ,
              child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child:Container(
              height: MediaQuery.of(context).size.height/22,
              width: MediaQuery.of(context).size.width/3,
              color: Theme.of(context).buttonColor,
              child: Center(
                child: Text(
                  option.toString(),
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
            ),
          )
          );
        }
        
        noMatchesCard(BuildContext context)
        {
           return Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            height: MediaQuery.of(context).size.height/15,
                            width: MediaQuery.of(context).size.width/1.7,
                            color: Theme.of(context).bottomAppBarColor,
                            child: Center(
                              child:
                              Text(noWahat,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                              )
                            ),
                          ),
                        ),
                      );
        }
        String get noWahat
        {
          return Language.Language.noMatches;
        }
        Future showNotification(Map<String,dynamic> messageBody)
          async
          {
            
           
            var androidSettings = AndroidNotificationDetails('channel Id', 'channelName', 'channelDescription',
            importance: Importance.Max,
              priority: Priority.Max,
              ongoing: true,
              autoCancel: false
            );
            var iosSettings = IOSNotificationDetails();
            var platform   = NotificationDetails(androidSettings, iosSettings);
          return await flutterLocalNotificationsPlugin.show(0, messageBody['title'],messageBody['message_body'], platform);
          }
        
         Widget getCostOfMatch(cost) 
          {
                            return Container(
                              height: 25,
                              width: 150,
                              // color: Colors.red,
                              child: Center(child: Text('${Language.Language.cost} ${cost.toString()}')));
                        }
          }
