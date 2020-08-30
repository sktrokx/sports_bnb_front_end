import 'dart:convert';
import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:sportsbnb/AboutMatch.dart';
import 'package:sportsbnb/ErrorConnecting.dart';
import 'package:sportsbnb/Loading.dart' as Loading;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sportsbnb/DatabaseHelper.dart';
import 'package:sportsbnb/FoundMatchData.dart';
import 'package:sportsbnb/HomeBar.dart';
import 'package:sportsbnb/LoginData.dart';
import 'package:sportsbnb/NotAuthorizaed.dart';
import 'package:sportsbnb/OrganizerMAtchDetails.dart';
import 'package:sportsbnb/RegisterAMatch.dart';
import 'package:sportsbnb/SearchPlayers.dart';
import 'package:sportsbnb/TabScreenForMatchDetails.dart';
import 'package:sportsbnb/Teams.dart';
import 'package:sportsbnb/UserCredentials.dart';
import 'package:sportsbnb/EnglishLanguage.dart' as Language;

class Matches extends StatefulWidget
{

@override
State<StatefulWidget> createState() {

return MatchesState();
}

}


class MatchesState extends BaseMatches


{
List<FoundMatchData> listOfMatches;


@override
Future<List<FoundMatchData>> getMatchesOfOrganizer()
async
{
String pathToGetUserMatches =  'http://192.168.10.26:8000/organize_matches/show_organizer_their_matches_of_eleven/${UserCredentials.credentialsInstance.getIdOfUser}';
try{
var response = await http.get(pathToGetUserMatches
,
headers: <String,String>
{
'Content-Type':'application/json',
'Authorization':'Token '+ UserCredentials.credentialsInstance.getTokenOfUser
},



);
if(response.statusCode == 200)
{
listOfMatches = List<FoundMatchData>();

List<dynamic> json = jsonDecode(response.body);
for(var item in json)
{
FoundMatchData currentMatch =  FoundMatchData(item);
listOfMatches.add(currentMatch);
debugPrint(currentMatch.title + 'current match title');
}
return listOfMatches;
}
else if(response.statusCode == 401)
{
NotAuthorizaed.showNotAuthorizedAlert(context);
}
}
catch(e)
{
ErrorConnecting.ConnectingIssue(context);
}
}







// @override
// Future<List<FoundMatchData>> getMatchesOfThree()
// async
//   {
// Map<String,dynamic> reservedData = getQueryOfInstance();
//     String pathToGetUserMatches =  'http://192.168.10.26:8000/organize_matches/show_organizer_their_matches_of_three/${reservedData['user_id']}';

//         var response = await http.get(pathToGetUserMatches
//         ,
//         headers: <String,String>
//         {
//           'Content-Type':'application/json',
//           'Authorization':'Token '+ reservedData['Authorization']
//         },



//         );
//         if(response.statusCode == 200)
//         {
// listOfMatches = List<FoundMatchData>();

//           List<dynamic> json = jsonDecode(response.body);
//           for(var item in json)
//           {
//             FoundMatchData currentMatch =  FoundMatchData(item);
//             listOfMatches.add(currentMatch);
//             debugPrint(currentMatch.addressOfMatch + 'current match title');
//           }
//           return listOfMatches;
//         }
//     }







@override
String appbarTitle() {
return Language.Language.organizerMatches;
}


@override
String typeOfMatchLink()
{
return 'http://192.168.10.26:8000/organize_matches/add_request_to_player_of_match_of_eleven/';
}

}




abstract class BaseMatches<T extends StatefulWidget> extends State<T>
{




Widget getFloatingActionButton() 
{
return FloatingActionButton(
backgroundColor: Theme.of(context).buttonColor,
child: Icon(Icons.add,

)
,onPressed: ()
{
addMatchesOrTeams(context);
});

}

@override
Widget build(BuildContext context) {

return  Scaffold(
// backgroundColor: Theme.of(context).accentColor,
floatingActionButton: getFloatingActionButton(),
appBar:AppBar(
leading: Container(),
title: Text(appbarTitle()),
// title: (user_credentials.isOrganizer)?Text("Organized Matches"):
// Text('Playing matches')

backgroundColor: Theme.of(context).bottomAppBarColor,
),
body: FutureBuilder(
future: getMatchesOfOrganizer(),
builder: (context,snapshot)
{
if(snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.active)
{
return SpinKitChasingDots(
color: Theme.of(context).bottomAppBarColor,
size: 50,
);
}
else if(snapshot.connectionState == ConnectionState.done)
{
if(snapshot.data == null)
{
return Center(


child: Card(
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(30)
),
color:  Theme.of(context).primaryColor,
child: Container(
height: MediaQuery.of(context).size.height/15,
width: MediaQuery.of(context).size.width/1.5,

child: Padding(
padding: const EdgeInsets.only(left:20),
child: Row(
children: <Widget>[
Text(Language.Language.noMatches,
style: TextStyle(
fontSize: 18,
color: Colors.white)),

Padding(
padding: const EdgeInsets.only(left:125),
child: GestureDetector(
onTap: ()
{
addMatchesOrTeams(context);
} ,
child: Icon(Icons.add,
color: Colors.white,
),
),
)

],


),
),
),
),


);




}

debugPrint('done');
debugPrint(snapshot.data.length.toString());
return  managementOfGui(snapshot.data);
}
}
),






);



}


Widget managementOfGui(snapshotData)
{
return ListView(
children: [

Container(
height:MediaQuery.of(context).size.height/15 ,

// flex: 1,
child: 
Card(
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(15
)

),
elevation: 10,
child: Padding(
padding: const EdgeInsets.all(8),
child: GestureDetector(
onTap: ()
{
debugPrint('tappingg');
Navigator.push(context, MaterialPageRoute(builder: (context)
{
return Teams();
}

));
}
,
child: Container(
height: MediaQuery.of(context).size.height/15,
width: MediaQuery.of(context).size.width-20,
color: Theme.of(context).buttonColor,
child: Center(
child: Text(Language.Language.teams,
style: TextStyle(
fontSize: 18,
color: Colors.white
),
),
),
),
),
),

)
),
Container(
height: MediaQuery.of(context).size.height-200,
// flex: 20,
child: ListView.builder(
// scrollDirection: Axis.horizontal,
itemCount: snapshotData.length,
itemBuilder: (context,index)
{
return getMatchOfOrganizerGUI(snapshotData[index]);

}

),
),
],
);

}         

// getFloatingActionButton();

// Widget getMatchOfOrganizerGUI(dynamic snapshotData);


// addMatchesOrTeams(BuildContext context);


// Future<List<dynamic>>  getUserMatches();


// addPlayerChoice(BuildContext context, int matchId);

appbarTitle();






Future<List<dynamic>> getMatchesOfOrganizer();





addPlayerChoice(BuildContext context, int matchId)
{

showDialog(
context: context,
builder: (BuildContext context){
return AlertDialog(
title: Text(Language.Language.choose),
content: Text(Language.Language.selecetPlayerFrom),
actions: <Widget>[
Row(
children: <Widget>[
GestureDetector(
onTap: () {
// Teams();
},
child: Card(
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(2)

),
color: Colors.blue,
child: Container(
height :30,
width : 130,
child: Center(child: Text(Language.Language.addFromTeams)),

),
),
),




GestureDetector(
onTap: () {
Navigator.push(context, MaterialPageRoute(
builder: (context)
{

return SearchPlayers(matchId);

},
)
);
},
child: Card(
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(2)

),
color: Colors.blue,
child: Container(
height :30,
width : 130,
child: Center(child: Text(Language.Language.searchPlayers)),

),
)

)


],
),

],
);
}
);


}

String get detailsOrPlayer
{
return Language.Language.details;
}

@override
Widget getMatchOfOrganizerGUI(dynamic snapshotData) {
return  Padding(
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
top: MediaQuery.of(context).size.height/24,
left: MediaQuery.of(context).size.width/6,
child:Text(snapshotData.title,
style: TextStyle(
fontWeight: FontWeight.bold,
fontSize: 18
),
) 
),


Positioned(
top: MediaQuery.of(context).size.height/13,
left: MediaQuery.of(context).size.width/6,
child:getDateAndTime(snapshotData)

), 


Positioned(
top: MediaQuery.of(context).size.height/30,
left: MediaQuery.of(context).size.width/1.5,
child: ClipRRect(
borderRadius: BorderRadius.circular(50),
child: GestureDetector(
onTap: 
()
{
goToAbout(context,snapshotData);
}
,
child: Container(
height: MediaQuery.of(context).size.height/30,
width: MediaQuery.of(context).size.width/4.5,
color: Theme.of(context).buttonColor,
child: Center(
child: Text(detailsOrPlayer,
style: TextStyle(
color:Colors.white
),

),
),
),
),
)
//   Text(snapshotData.title,
// style: TextStyle(
//   fontWeight: FontWeight.bold,
//   fontSize: 18
// ),
// ) 
),



Positioned(
top: MediaQuery.of(context).size.height/24,
left: MediaQuery.of(context).size.width/50,
child:ClipRRect(
borderRadius: BorderRadius.circular(150),
child:
GestureDetector(
onTap: ()
{
deleteOrEditMatchOrTeam(snapshotData);
}
,
child: Container(
height: MediaQuery.of(context).size.height/24,
width: MediaQuery.of(context).size.width/11,
color: Theme.of(context).buttonColor,
child: Icon(Icons.edit,
color: Colors.white,
),
),
)
)
)

],
),
),
),
);
}


numberOfPlayers(snapshotData)
{
return ClipRRect(
borderRadius: BorderRadius.circular(15),
child: Container(
height: 100,
width: 100,
color:Colors.white,
child:
Padding(
padding: const EdgeInsets.only(top:15),
child: Column(
children: [
Padding(
padding: const EdgeInsets.only(top:8.0),
child: (snapshotData.playersOnBenchList == null)?
Text(Language.Language.onBench0,
style: TextStyle(
fontWeight: FontWeight.bold
),
):
Text('${Language.Language.onBench} ${snapshotData.playersOnBenchList}'
,
style: TextStyle(
fontWeight: FontWeight.bold
),
),
),

Padding(
padding: const EdgeInsets.only(top:8.0),
child: (snapshotData.playersOnBenchList == null)?
Text(Language.Language.onWaiting0
,
style: TextStyle(
fontWeight: FontWeight.bold
),
):

Text('${Language.Language.onWaiting} ${snapshotData.playersOnWaitingList}'

,
style: TextStyle(
fontWeight: FontWeight.bold
),
),
),

],
),
)
),
);
}

matchInformation(snapshotData)
{
return Padding(
padding: const EdgeInsets.all(15),
child: Column(

children: [
Text(snapshotData.cityOfMatch,
style: TextStyle(
fontSize: 20
),
),

Padding(
padding: const EdgeInsets.only(top:8.0),
child: Text(snapshotData.addressOfMatch,
style: TextStyle(
fontSize: 20
),
),
),
Text(snapshotData.dateAndTime.toString(),
style: TextStyle(
fontSize: 20
),
),


],
),
)
;
}



DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
@override
addMatchesOrTeams(BuildContext context)
{
Navigator.push(context, MaterialPageRoute(builder: (context)
{
return RegisterAMatch('','','',dateFormat.format(DateTime.now()).toString(),7,5,0,false,Language.Language.registerAMatch,3);
}
));

}


Future doDeleteIt(matchId)
async 
{


Loading.ShowLoadingDialog.showLoaderDialog(context);

String pathToDeleteMatch = 'http://192.168.10.26:8000/organize_matches/delete_match_of_eleven/${matchId}';
try{
var response = await http.delete(pathToDeleteMatch
,
headers: <String,String>
{
'Content-Type':'application/json',
'Authorization': 'Token ' + UserCredentials.credentialsInstance.getTokenOfUser
}



);
if(response.statusCode == 200)
{
Navigator.pop(context);
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
ErrorConnecting.ConnectingIssue(context);
}

}




deleteOrEditMatchOrTeam(snapshotData)
{
return showDialog(context: context,
builder: (context)
{
return AlertDialog(
title: Text(Language.Language.choose),
content: Text(Language.Language.chooseWhatYouWantToDo),
actions: <Widget>[
Row(
children: <Widget>[
editMatch(Language.Language.edit,context,snapshotData),
yesDelete(Language.Language.delete,snapshotData.id)

],
)
],
);
}
);
}

Widget editMatch(String res,BuildContext context,snapshotData)
{

return GestureDetector(
onTap: ()
async
{ 
editMatchData(context,snapshotData);
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
                      
                        
                      
                      
                      
                      
                      
                      
                      // Widget getPlayersOfMatch(dynamic snapshotData)
                      // {
                      //    return Container(
                      //                                           height: MediaQuery.of(context).size.height/4,
                      //                                           width: MediaQuery.of(context).size.width-30,
                      //                                           color: Colors.black.withOpacity(0.6),
                      //                                           child: ListView.builder(
                      //                                             itemCount: snapshotData.listOfPlayers.length,
                      //                                             itemBuilder: (context,i)
                      //                                           {
                      //                                             return Card(
                      //                                               shape: RoundedRectangleBorder(
                      //                                                 borderRadius: BorderRadius.circular(15)
                      //                                               ),
                      //                                              child: Container(
                      //                                                height: MediaQuery.of(context).size.height/12,
                      //                                                child: 
                      //                                                Row(
                      //                                                  children: <Widget>[
                      //                                                    Expanded(
                      //                                                      flex: 2,
                      //                                                         //                                   child: Card(
                      //                                                         // shape:RoundedRectangleBorder(
                      //                                                         //   borderRadius: BorderRadius.circular(150)
                      
                      //                                                         // ),
                      
                      //                                                   child:Container(
                                                                        
                                                                        
                      //                                                      child:ClipRRect(
                      //                                                        borderRadius: BorderRadius.circular(150),
                      
                      //                                                                                                             child: (snapshotData.listOfPlayers[i].profilePicture != null)?Image.memory(snapshotData.listOfPlayers[i].profilePicture,
                      //                                                        height: MediaQuery.of(context).size.height/14,
                      //                                                        width: 60,
                      //                                                        ):
                      //                                                        Container(
                      //                                                          height:MediaQuery.of(context).size.height/14,
                      //                                                          width:60
                      //                                                        ),
                      //                                                      )
                      //                                                      )
                      
                      //                                                      ),
                      //                                                   //  ),
                      //                                                    Expanded(
                      //                                                      flex: 6,
                      //                                                                                           child: Column(
                      //                                                                                             children: <Widget>[
                      //                                                                                               Text('${snapshotData.listOfPlayers[i].playerName}'
                      //                                                      ),
                      //                                                      Text(snapshotData.listOfPlayers[i].phoneNumber.toString())
                      //                                                     //  Text('snapshotData.listOfPlayers[i].phoneNumber.toString()')
                      
                      //                                                                                             ],
                      //                                                                                           ),
                      //                                                    ),
                      
                      //                                                  ],
                      //                                                )
                      //                                                ,
                      //                                              ),
                      //                                             );
                      //                                           }
                      //                                           ),
                                                              
                                                            
                      //                                   );
                                          
                      // }
                      
                      Widget inviteMorePlayersCard(dynamic snapshotData)
                      {
                        return  Positioned(
                          top: MediaQuery.of(context).size.height/2.3,
                          left: MediaQuery.of(context).size.width/5,
                                                        
                                                        child: Container(
                                                        
                                                          child:
                                                      Card(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(5)
                                                          ),
                                                          color: Theme.of(context).buttonColor,
                                                          child: InkWell(
                                                            onTap: ()
                                                            {
                                                              addPlayerChoice(context, snapshotData.matchId);
                                                            }
                                                            ,
                                                                                        child: Container(
                                                                  height: 35,
                                                                  width: 250,
                                                                child: Center(
                                                                  child: Text(Language.Language.inviteMorePlayersToMatch,
                                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white
                                                  ),
                                                                  
                                                                  )),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                        
                        );
                        
                                                    
                      }
                      
                      Widget getDateAndTime(snapshotData)
                        {
                          return Text('${Language.Language.date}: ${snapshotData.date}   ${Language.Language.time}: ${snapshotData.time}');
                        }
    
      void goToAbout(BuildContext context,snapshotData)
      {
          Navigator.push(context, MaterialPageRoute(builder: (context)
    {
      return AboutMatch(snapshotData.id,snapshotData.totalPlayers,snapshotData.matchType);
    }
    ));
      }

void editMatchData(BuildContext context,snapshotData) 
{
Navigator.push(context,MaterialPageRoute(builder: (context)
{ 
return RegisterAMatch(snapshotData.title,snapshotData.city,snapshotData.address,snapshotData.dateAndTime,snapshotData.frequency,snapshotData.matchType,snapshotData.id,snapshotData.benchListExist,Language.Language.update,snapshotData.benchListLimit);
}
));
}





}