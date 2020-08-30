import 'dart:convert';
import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:sportsbnb/DatabaseHelper.dart';
import 'package:sportsbnb/ErrorConnecting.dart';
import 'package:sportsbnb/LoginData.dart';
import 'package:sportsbnb/Matches.dart';
import 'package:sportsbnb/NotAuthorizaed.dart';
import 'package:sportsbnb/SearchPlayers.dart';
import 'package:sportsbnb/SearchPlayersForTeam.dart';
import 'package:sportsbnb/TeamData.dart';
import 'package:sportsbnb/TeamPlayers.dart';
import 'package:sportsbnb/UserCredentials.dart';
import 'package:sportsbnb/EnglishLanguage.dart' as Language;

class Teams extends StatefulWidget
{

@override
State<StatefulWidget> createState() {
return TeamsState();
}
}

class TeamsState extends BaseMatches
{
String titleToGetFromUser;

List<TeamData> listOfTeams;


TextEditingController titleController = TextEditingController();



  

@override
Future<List<dynamic>>  getMatchesOfOrganizer()


async
{
             


String pathToGetTeams = 'http://192.168.10.26:8000/organize_matches/user_teams/';
try{
var response = await http.post(pathToGetTeams,
headers: <String,String>
{
  'Content-Type':'application/json',
  'Authorization':'Token ' + UserCredentials.credentialsInstance.getTokenOfUser,
  },
  body: jsonEncode(<String,dynamic>
  {
    'user_id':UserCredentials.credentialsInstance.getIdOfUser,
    
  }
  )
);

if(response.statusCode == 200)
{
  listOfTeams = List<TeamData>();

  List<dynamic> json = jsonDecode(response.body);
  for(var item in json)
  {
    TeamData currentTeam = TeamData(item);
    listOfTeams.add(currentTeam);
  }
  return listOfTeams;
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





Future addTeams(BuildContext context)

async {
  String pathToAddTeam = 'http://192.168.10.26:8000/organize_matches/add_team/';
  try{
  var response = await http.post(pathToAddTeam,
  headers: <String,String>
  {
    'Content-Type':'application/json',
    'Authorization':'Token ' + UserCredentials.credentialsInstance.getTokenOfUser
      },
  body: jsonEncode(<String,dynamic>
  {
    'user_id':UserCredentials.credentialsInstance.getIdOfUser,
  
  'title_of_team':titleController.text.toString().toLowerCase()
  }
  )
  );
  if(response.statusCode == 200)
  {
    showDialog(
      context: (context),
      builder:((context)
      
      {
        return AlertDialog(
          title: Text(Language.Language.response),
          content: Text(Language.Language.teamAdded),
        );
      }
      ));

      setState(() {
        
      });
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



@override
addMatchesOrTeams(BuildContext context)
{
addTeams(context);
}

@override

addPlayerChoice(BuildContext context, int teamId)
{
  
Navigator.push(context, MaterialPageRoute(builder: (context)
{
return SearchPlayersForTeam(teamId);
}
));
}

// @override
// Widget getMatchOfOrganizerGUI(dynamic snapshotData) {


// return Padding(
// padding: const EdgeInsets.all(8.0),
// child: ClipRRect(
// borderRadius: BorderRadius.circular(15),
//   child:      Card(
//     color: Colors.black.withOpacity(0.3),
//     shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(30)
    
//     ),
//     elevation: 10,
//       child: BackdropFilter(
//       filter: ImageFilter.blur(
//         sigmaX: 50,
//         sigmaY: 50
        
//       ),
      
//       child: Container(
//       height: MediaQuery.of(context).size.height/2.3,
//       child: Stack(
//       children:<Widget>[
      
//       GestureDetector(

//         onTap: ()
//         {
//           deleteMatchOrTeam(snapshotData.id);
//         }
//         ,
//         child: Icon(
//           Icons.cancel
//         ,
//         size: 30,
//         color: Theme.of(context).buttonColor,),
//       ),
      
      
//       Positioned(
//         left:MediaQuery.of(context).size.width/3.9,
//         child:   Card(
//         elevation: 20,
//         color:Theme.of(context).primaryColor,
//         child: Container(
//         height: 50,
//         width: 200,
        
//         child: Center(child: Text(snapshotData.title
//         ,
//         style: TextStyle(
//         fontSize: 25,color: Colors.white
//         ),
//         )))),
//       )
//       ,
       
//        Positioned(
//          top:70,
//           child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)
//                     ),
//       color: Theme.of(context).accentColor,
//       child:Container(
      
//       height: MediaQuery.of(context).size.height/3.5,
//       width: MediaQuery.of(context).size.width-31,
//       child: ListView.builder(
//       itemCount:( snapshotData.listOfPlayers != null)? snapshotData.listOfPlayers.length
//       :
//       0
//       ,
//       itemBuilder: (context,i) 
//       {
//       debugPrint(snapshotData.listOfPlayers.length.toString());
//       return Card(
      
//       child:        Container(
//           height: MediaQuery.of(context).size.height/14,
//       child: Row(
//       children: <Widget>[
//       Container(
//           height: MediaQuery.of(context).size.height/15, 
//           width: MediaQuery.of(context).size.height/15,
//       // child:
//       child:(snapshotData.listOfPlayers[i].userPicture!=null)?
//       Image.memory(snapshotData.listOfPlayers[i].userPicture,
//           height: MediaQuery.of(context).size.height/15,
//           width: MediaQuery.of(context).size.height/15,
      
//       )
//       :
//       Container(
//           height: MediaQuery.of(context).size.height/15,
//           width: MediaQuery.of(context).size.height/15,
      
      
//       )
//       ),
//       Padding(
//           padding: const EdgeInsets.only(left:25),
//           child:   Column(
//           children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(top:8.0),
//             child: Text('${snapshotData.listOfPlayers[i].firstName} ${snapshotData.listOfPlayers[i].lastName}'),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top:8.0),
//             child: Text(snapshotData.listOfPlayers[i].phoneNumber),
//           ),
          
//           ],
//           ),
//       )
//       ],
//       ),
//       ), 
//       );
//       },
//       ),
//       ),
      
//       ),
//        ),
      
//       Positioned(
//         bottom: 20,
//         left: MediaQuery.of(context).size.width/3.8,
//         child:   GestureDetector(
//         onTap: ()
//         {
        
//         addPlayerChoice(context,snapshotData.id);                                      
//                                                   },                                              child: Card(
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(5)
                                          
//                                         ),
//                                         color: Theme.of(context).buttonColor,
//                                         child: Container(
//                                               height: 30,
//                                               width: 150,                                                                      
//                                           child: Center(child: Text(Language.Language.addPlayer,
//                                           style: TextStyle(
//                                             color: Colors.white
//                                           ),
//                                           ),
                                          
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//       )
//                                   ]
//                                 ),
//                               ),
//                           ),
//   ),

//       ),
// );
                  
              
              
              
          
      



// }





getTitleOfTeam( BuildContext context)
{
  final formKey = GlobalKey<FormState>();
  showDialog(context: context,
  builder: (context)
  {
    return  AlertDialog(
          title: Text(Language.Language.enterTitle),
            actions: <Widget>[
              Form(
                key: formKey,
                child:
                Container(
                  height: 130,
                  width: 250,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
obscureText: false,

decoration: InputDecoration(
border:OutlineInputBorder(
//  borderSide: new BorderSide(color: Colors.deepOrange),
borderRadius: BorderRadius.circular(20)
),

labelText: Language.Language.titleLable,

),
controller: titleController,
validator: (value)
{
if(value.isEmpty)
{
return Language.Language.titleReturn;
}
},
),
SizedBox(
height:20
),
                        InkWell(
                          
                          onTap: ()
                          {
                            addMatchesOrTeams(context);
                          //  super.initState();
                            // Navigator.push(context, MaterialPageRoute(builder: (context)
                            // {
                            //     return Teams(user_credentials);
                            // }
                            // ));
                          }
                          
                          ,
                          splashColor: Colors.green.shade50,
                                                                          child: Card(
                            color: Theme.of(context).buttonColor,
                            child: Container(
                              height:30,
                              width: 200,
                                      child: Center(child: Text(Language.Language.add,
                                      style: TextStyle(
                                        color: Colors.white
                                      ),
                                      )),
                            )
                            ,
                          ),
                        )
                      ],
                    ),
                  ),
                ) 
                )
            ],
        
      
    );
  }
  );
}



@override
Widget getFloatingActionButton() 
{
return FloatingActionButton(
  backgroundColor: Theme.of(context).buttonColor,
  child: Icon(Icons.add),
onPressed: ()
{
getTitleOfTeam(context);
},
)  ;
}

  @override
 Future doDeleteIt(matchId)
  async
   {
  
  String pathToDeleteMatch = 'http://192.168.10.26:8000/organize_matches/delete_user_team/${matchId}';
 try{
  var response = await http.delete(pathToDeleteMatch,
  headers: <String,String>
  {
    'Content-Type':'application/json',
    'Authorization':'Token ' + UserCredentials.credentialsInstance.getTokenOfUser
  }

  );
  if(response.statusCode == 200)
  {
   Navigator.pop(context); 
setState(() {
  
});
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


deleteMatchOrTeam(matchId)
{
  return showDialog(context: context,
                  builder: (context)
                  {
                      return AlertDialog(
                          title: Text(Language.Language.confirmation),
                          content: Text(Language.Language.areYouSureYouWantToDelete),
                          actions: <Widget>[
                            Row(
                              children: <Widget>[
                              dontDelete('no',context),
                              yesDelete('yes',matchId)
                                                          
                                                            ],
                                                          )
                                                        ],
                                                    );
                                                }
                                );
                              }
                              
                                Widget dontDelete(String res,BuildContext context)
                                 {
                                   
                                    return GestureDetector(
                                      onTap: ()
                                      async
                                      { 
                                         doNotDelete();
                                      }
                                      ,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Container(
                                          height: 20,
                                          width: 100,
                                          child: Text(res)),
                                      )
                                      
                                      );
                                 }


  Widget yesDelete(String res,int matchIde)
                                 {
                                   
                                    return GestureDetector(
                                      onTap: ()
                                      async
                                      { 
                                        doDeleteIt(matchIde);

                                      }
                                      ,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Text(res),
                                      )
                                      
                                      );
                                 }


                                 doNotDelete()
{
  Navigator.pop(context);
}

  @override
 String appbarTitle() {
 return Language.Language.teams;
  }

  @override
  String typeOfMatchLink() {
  
  //add request to team endpoint
    }

 
@override
Widget managementOfGui(snapshotData)
{
return          Container(
                  height: MediaQuery.of(context).size.height-90,
                  // flex: 20,
                                  child: ListView.builder(
                    // scrollDirection: Axis.horizontal,
                      itemCount: snapshotData.length,
                      itemBuilder: (context,index)
                    {
                      return getMatchOfOrganizerGUI(snapshotData[index]);
                        
                    }
                    
                    )
                    );
                
              
            
          
          } 
@override
  Widget getDateAndTime(snapshotData) {
    // TODO: implement getDateAndTime
    return Container();
  }  

@override
  void goToAbout(BuildContext context, snapshotData) {
    // TODO: implement goToAbout
    Navigator.push(context, MaterialPageRoute(builder: (context)
    {
      return TeamPlayers(snapshotData.id,0,0);
    }
    ));
  }
  String get detailsOrPlayer
  {
    return Language.Language.players;
  }

          }

