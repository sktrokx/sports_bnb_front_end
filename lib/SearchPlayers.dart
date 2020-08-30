import 'dart:convert';
import 'dart:ui';
import 'package:sportsbnb/ErrorConnecting.dart';
import 'package:sportsbnb/Loading.dart' as Loading ;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:sportsbnb/DatabaseHelper.dart';
import 'package:sportsbnb/LoginData.dart';
import 'package:sportsbnb/NotAuthorizaed.dart';
import 'package:sportsbnb/PlayerFoundData.dart';
import 'package:sportsbnb/EnglishLanguage.dart' as Language;
import 'UserCredentials.dart';

class SearchPlayers extends StatefulWidget
{
int id;
SearchPlayers(  int id)
{
this.id = id;
}
@override
State<StatefulWidget> createState() {
return SearchPlayersState(id);
}

}


class SearchPlayersState <T extends StatefulWidget> extends State<T>
{
bool searched = false;
TextEditingController playerNameController = TextEditingController();

List<PlayerFoundData> listOfPlayersWithCharacteristics;

final _formKey  = GlobalKey<FormState>();

int id;
SearchPlayersState( int id)
{
this.id = id;

}


  
@override

Widget build(BuildContext context) {

return Scaffold(
  backgroundColor: Theme.of(context).accentColor,
appBar: AppBar(
title: Text(Language.Language.searchPlayers),
backgroundColor: Theme.of(context).bottomAppBarColor,
),

body:  Form(
key: _formKey,


child: ListView(

children: <Widget>[
Container(
height: 100,
child: Stack(

children: <Widget>[
Container(
height:100,



),

Positioned(

child: 

Row(
children:<Widget>[
Expanded(
flex: 3,
child: Card(
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(20)
),
elevation: 20,
child: TextFormField(
obscureText: false,

decoration: InputDecoration(
border:OutlineInputBorder(
//  borderSide: new BorderSide(color: Colors.deepOrange),
borderRadius: BorderRadius.circular(20)
),

labelText: Language.Language.searchPlayers,

),
controller: playerNameController,
validator: (value)
{
if(value.isEmpty)
{
return Language.Language.enterFirstName;
}
},
),
),
),

  Expanded(
flex: 1,

child: GestureDetector(

onTap: ()
{
searchPlayer(id);
// debugPrint('ok');
},
child: Icon(Icons.search)),
)

]
),



),
],
),
),

(searched)?
Container(
height: MediaQuery.of(context).size.height/1.3,
// color: Colors.red,
child: ListView.builder(
itemCount: listOfPlayersWithCharacteristics.length
,itemBuilder: (context,index)
{
  debugPrint(listOfPlayersWithCharacteristics.length.toString());
return  Padding(
  padding: const EdgeInsets.all(8.0),
  child:   ClipRRect(
  borderRadius: BorderRadius.circular(15),
    child:      Card(
      color: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30)
      
      ),child: Container(
  height: MediaQuery.of(context).size.height/2.5,
  width: MediaQuery.of(context).size.width/2,
  // color: Theme.of(context).primaryColor.withOpacity(0.3),
  child: 
  BackdropFilter(
    filter: ImageFilter.blur(
      sigmaX: 30,
      sigmaY: 30
    ),
    child:   Stack(
    children: <Widget>[
    ClipRRect(
    
    borderRadius: BorderRadius.circular(100)
    ,
    child:(listOfPlayersWithCharacteristics[index].profilePicture != null)? 
     Container(
    height: MediaQuery.of(context).size.height/6,
    width: MediaQuery.of(context).size.width/2.9,
    child:Image.memory(listOfPlayersWithCharacteristics[index].profilePicture
    ,height: MediaQuery.of(context).size.height/6,
    width: MediaQuery.of(context).size.width/3,
    
    )
     )
    :
    Container(
    height: MediaQuery.of(context).size.height/6,
    width: MediaQuery.of(context).size.width/2.9,
    color: Colors.white,
    child: Center(
    child: Text('',
    style: TextStyle(
    fontSize: 25
    ),
    ),
    ),
    ),
    
    
    ),
  
    Positioned(
      top: MediaQuery.of(context).size.height/15,
      left: MediaQuery.of(context).size.width/2,
      child:
          Container(
      child: Column(
        children: <Widget>[
             Text('${listOfPlayersWithCharacteristics[index].firstName} ${listOfPlayersWithCharacteristics[index].lastName}',
            style: TextStyle(
              fontSize: 20 ,
              color: Colors.white
            ),
            ),
  
  
             Padding(
               padding: const EdgeInsets.only(top:15),
               child: Text('${listOfPlayersWithCharacteristics[index].phoneNumber}',
               style: TextStyle(
                fontSize: 20 ,
                color: Colors.white
            ),
               ),
             )
      ],
          ),
      )),
  
  
  Positioned(
    top: MediaQuery.of(context).size.height/6,
    left: MediaQuery.of(context).size.width/2.5,
    child: 
    Container(
      height: MediaQuery.of(context).size.height/5.5,
    
      width: MediaQuery.of(context).size.width-30,
        child: Column(
        children: <Widget>[
  
  //  (listOfPlayersWithCharacteristics[index].playerCharracteristics.leftFoot == null)?
                                                                              
      ((listOfPlayersWithCharacteristics[index].playerCharracteristics == null)
      ||
      (listOfPlayersWithCharacteristics[index].playerCharracteristics.leftFoot == null
      &&
      listOfPlayersWithCharacteristics[index].playerCharracteristics.rightFoot == null
      ))?
      customTileForAttr(Language.Language.playsWith," - ",Icons.perm_camera_mic)
      :
      listOfPlayersWithCharacteristics[index].playerCharracteristics.leftFoot?
      
      customTileForAttr(Language.Language.leftFoot,Language.Language.playsWith,Icons.pan_tool)
      :
      customTileForAttr(Language.Language.rightFoot,Language.Language.playsWith,Icons.pan_tool)
      
      ,
      ((listOfPlayersWithCharacteristics[index].playerCharracteristics == null)
      ||
      (listOfPlayersWithCharacteristics[index].playerCharracteristics.goalKeeper == null))
      
      ?
      customTileForAttr( Language.Language.isGoalKeeper,' - ', Icons.accessibility)
      :
      
      (listOfPlayersWithCharacteristics[index].playerCharracteristics.goalKeeper)?
      
      customTileForAttr(Language.Language.isGoalKeeper,Language.Language.yes,  Icons.accessibility)
      :
      customTileForAttr( Language.Language.isGoalKeeper,Language.Language.no, Icons.accessibility)
      
   
  
  
        ],
      ),
    )
    )
  
  
    
    ,
   
   Positioned(
     top: MediaQuery.of(context).size.height/3,
     left: MediaQuery.of(context).size.width/6.9,
      child: addPlayer(listOfPlayersWithCharacteristics[index])
      
        ),
                              
                            ],
                          ),
  )
                        ),
                      )),
);
                }
                
                ),

)
          :
          Container()
        ]
                                      ),
        )
                            
                            );
                            
                          
                            }
                            String get searchPlayerWithName
                            {
                              return 'http://192.168.10.26:8000/organize_matches/search_players/';
                            }
                        
                            Future searchPlayer(id)
                            async{
                              Loading.ShowLoadingDialog.showLoaderDialog(context);
                              String pathToSearchPlayer = searchPlayerWithName;
                              try{
                              var response = await http.post(searchPlayerWithName,
                              headers: <String,String>
                              {
                                'Content-Type':'application/json',
                                'Authorization': "Token "+UserCredentials.credentialsInstance.getTokenOfUser
                              }
                              ,
                              body: jsonEncode(
                                <String,dynamic>
                                {
                                  'user_id':UserCredentials.credentialsInstance.getIdOfUser,
                                  'id':id,
                                  'full_name':playerNameController.text.toString()
                                  }
                              )
                              
                        
                              );
                        
                          
                              if(response.statusCode == 200)
                              {
                                listOfPlayersWithCharacteristics = List<PlayerFoundData>();
                                  
                                  List<dynamic> json = jsonDecode(response.body);
                                  for(var item in json)
                                  {
                                    PlayerFoundData data = PlayerFoundData(item);
                                    listOfPlayersWithCharacteristics.add(data);
                                    }
                        
                        
                        
                        
                                setState(() {
                                  searched = true;
                                  Navigator.pop(context);
                                });
                              }
                              else if(response.statusCode == 401)
{
  NotAuthorizaed.showNotAuthorizedAlert(context);
}
}
catch(e)
{
  Navigator.pop(context);
  ErrorConnecting.ConnectingIssue(context);
}
                            }
                          Widget getCharacteristicsCardName(var firstName, var lastName)
                          {
                        return Card(
                          elevation: 2,
                          child: ListTile(
                            leading: Icon(Icons.person),
                            title: Text(firstName + ' '+ lastName),
                          ),
                        );
                          }
                        Widget getCharacteristicsCardData(var current,var currentText,IconData currentIcon)
                        {
                          return Card(
                            elevation: 25,
                            child: Container(
                              height: MediaQuery.of(context).size.height/15,
                              width: MediaQuery.of(context).size.width/1.3,
                              child: Padding(
                                padding: const EdgeInsets.only(left:15),
                                child: Row(
                                  children:<Widget>[
                                    
                                      Padding(
                                        padding: const EdgeInsets.only(left:15),
                                        child: Icon(currentIcon),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:25),
                                        child: Text(currentText),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:25),
                                        child: Text(current),
                                      )
                                  ]),
                              ),
                            )
                          );
                        }

String get mapForId
{
  return 'match_id';
}

String get mapForPlayer
{
  return 'recieving_player_id';
}

Future askToJoin(data)
async
{
  Loading.ShowLoadingDialog.showLoaderDialog(context);
debugPrint(id.toString());
String pathToAddRequestToUserMatches = pathTOAddRequest();
try{
var response =await http.post(pathToAddRequestToUserMatches
,
headers: <String,String>
{
'Content-Type':'application/json',
'Authorization':'Token ' + UserCredentials.credentialsInstance.getTokenOfUser
},
body: jsonEncode(<String,dynamic>
{
'user_id':UserCredentials.credentialsInstance.getIdOfUser
,
mapForId:id,
mapForPlayer:data.id

}
)
);

if(response.statusCode == 200)
{
  setState(() {
    data.sent = true;
    Navigator.pop(context);
  });
}
}
catch(e)
{
  Navigator.pop(context);
  ErrorConnecting.ConnectingIssue(context);
}

}

// Future askToJoin(int recieverId)
// {
// String pathToAddRequestsToUserTeam = 'http://192.168.10.26:8000/organize_matches/add_team_request_to_player/';
// var response = http.post(pathToAddRequestsToUserTeam,
// headers: <String,String>
// {
// 'Content-Type':'application/json',
// 'Authorization':'Token '+ UserCredentials.credentialsInstance.getTokenOfUser
// }
// ,
// body: jsonEncode(<String,dynamic>
// {
// 'recieving_player_id':recieverId,
// 'team_id':id,
// 'user_id':UserCredentials.credentialsInstance.getIdOfUser

// }

// )
// );
// }



 Widget customTileForAttr(String title,String titleAns,IconData iconData)
                
                {
                    return Container(
                      height: 75,
                      // color: Colors.red,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left:25),
                                            child: Row(
                          children: <Widget>[
                         Icon(iconData,
                         size: 30,
                         color: Colors.white,
                         ),
                            Padding(
                              padding: const EdgeInsets.only(left:25,top: 20),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    title,
                                    style: TextStyle(
              fontSize: 17 ,
              color: Colors.white
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:8.0,left:50),
                                    child: Text(titleAns,
                                    style: TextStyle(
              fontSize: 16 ,
              color: Colors.white),
                                  ))
                                ],
                              ),
                            )
                          ],

                      ),
                                          ),
                    );

                }

String whereToAdd()
{
  return Language.Language.whereToAddSearchPlayers;
}
String pathTOAddRequest()
{
  return 'http://192.168.10.26:8000/organize_matches/add_request_to_player_of_match_of_eleven/';
}

String get alreadyRequested
{
  return Language.Language.alreadyRequestedSearchPLayers;
}

String get alreadyPlaying
{
  return Language.Language.playing;
}



Widget addPlayer(data)
{
  return
  (data.available!=null)?
  dontAddPlayerCard(data.available):
  (data.alreadyRequested)?
    dontAddPlayerCard(alreadyRequested):
    (data.playing)?
     dontAddPlayerCard(alreadyPlaying):
    // (data.onBench)?
                                  // Text('on bench'):
                                // (data.onWaiting)?
                              // Text('on waiting list'):
  (data.sent)?
  dontAddPlayerCard(Language.Language.requestSent):
  
  // Container();
     addPlayerCard(data);
  
  }
  
  Widget addPlayerCard(data)
  {
  return GestureDetector(
        onTap: ()
        {
        // if(whatToCall == 'matches')
        // {
        askToJoin(data);
        }
                                        // }
                                        // else if(whatToCall =='teams')
                                        // {
                                          // askToJoinTeam(listOfPlayersWithCharacteristics[index].id);
                                        // }
                                      // }
                                                                                                                                                                                              ,
                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)
                                        ),
                                        child: Container(
                                            height: 50,
                                            width: MediaQuery.of(context).size.width/1.5,
                                        child: Center(child:
                                        // (data.alreadyRequested)?
                                        // Text('request_sent'):
                                        //   (data.playing)?
                                        //   Text('playing'):
                                        //   (data.onBench)?
                                        //   // Text('on bench'):
                                        //   // (data.onWaiting)?
                                        //   // Text('on waiting list'):
  
                                         Text(whereToAdd(),
                                        style: TextStyle(
                                          fontSize: 20
                                        )
                                        )
                                        // :Container())
                                        ),
                              ) 
                                   )   
                                     );
  }
  
    Widget dontAddPlayerCard(String s) 
    {
     return   Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Container(
                                          height: 50,
                                          width: MediaQuery.of(context).size.width/1.5,
                                      child: Center(child:
                                      // (data.alreadyRequested)?
                                      // Text('request_sent'):
                                      //   (data.playing)?
                                      //   Text('playing'):
                                      //   (data.onBench)?
                                      //   // Text('on bench'):
                                      //   // (data.onWaiting)?
                                      //   // Text('on waiting list'):

                                       Text(s,
                                      style: TextStyle(
                                        fontSize: 20
                                      )
                                      )
                                      // :Container())
                                      ),
                            ) 
                                 )   ;
    }
}