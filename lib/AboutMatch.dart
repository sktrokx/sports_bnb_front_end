import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sportsbnb/DeclinedRequests.dart';
import 'package:sportsbnb/EnglishLanguage.dart' as Language;
import 'package:sportsbnb/MatchOverViewData.dart';
import 'package:sportsbnb/OnBenchList.dart';
import 'package:sportsbnb/OnWaitingList.dart';
import 'package:sportsbnb/OrganizerMAtchDetails.dart';
import 'package:sportsbnb/PlayerMatchesFound.dart';
import 'package:sportsbnb/RectangularSliderTrackShape.dart';
import 'package:sportsbnb/SearchPlayers.dart';
import 'package:sportsbnb/TeamForMatch.dart';
import 'package:sportsbnb/UnConfirmedPlayers.dart';
import 'package:http/http.dart' as http;
import 'package:sportsbnb/UserCredentials.dart';


class AboutMatch extends StatefulWidget
{
int matchId;
int totalPlayers;
int matchType;

AboutMatch(matchId,totalPlayers,matchType)
{
  this.matchId = matchId;
  this.totalPlayers = totalPlayers;
  this.matchType = matchType;
}

  @override
  State<StatefulWidget> createState() {
 return AboutMatchState(matchId,totalPlayers,matchType);
  }

}

class AboutMatchState extends State<AboutMatch>
{


  MatchOverViewData matchData;
  int matchId;
  int totalPlayers;
  int matchType;
  AboutMatchState(matchId,totalPlayers,matchType)
  {
this.matchId = matchId;
this.totalPlayers = totalPlayers;
this.matchType = matchType;
  }
Future getAboutMatch;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
   
    getAboutMatch = matchOverView();

      }

    
      @override
      Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBar(
          title: Text(Language.Language.details),
        backgroundColor: Theme.of(context).bottomAppBarColor,
    
        ),
        body:
        FutureBuilder(
          // initialData: 0.0,
          future: getAboutMatch,
          builder: (context,snapshot)
        {
    if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.waiting)
    {
      return SpinKitSpinningCircle(
size: MediaQuery.of(context).size.height/20,
color: Theme.of(context).bottomAppBarColor,

      );
    }
  if(snapshot.connectionState == ConnectionState.done)
  {

    return ListView(
children: [
  customCardForMatchDetails(snapshot.data),
  // customButtonWithSlider(snapshot.data.numberOfConfirmedPlayers,snapshot.data.matchType,OrganizerMatchDetails(matchId, totalPlayers, matchType),context,Language.Language.confirmedPlayers),
  Padding(
    padding: const EdgeInsets.all(25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

    customButtonWithChartForConfirmed(snapshot.data.numberOfConfirmedPlayers,snapshot.data.matchType,(){
      toNavigate(context, OrganizerMatchDetails(matchId, totalPlayers, matchType));
    },context,Language.Language.confirmedPlayers,Language.Language.totalPlayers),
    customButtonWithChartForConfirmed(snapshot.data.numberOfPlayersAnswered, snapshot.data.numberOfPlayersInvited,()
    {

    }
    ,context,Language.Language.answeredPLayers,Language.Language.invited),
      
      ],
    ),
  ),



Padding(
    padding: const EdgeInsets.all(25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

    customButtonWithChartForConfirmed(snapshot.data.pendingPlayers,snapshot.data.numberOfPlayersInvited,(){
      toNavigate(context, UnConfirmedPlayers(matchId, totalPlayers, matchType));
    },context,Language.Language.pendingPlayers,Language.Language.invited),
    customButtonWithChartForConfirmed(snapshot.data.numberOfPlayersDeclined, snapshot.data.numberOfPlayersInvited,()
    {
toNavigate(context,DeclinedRequests(matchId, totalPlayers, matchType));

    }
    ,context,Language.Language.declined,Language.Language.invited),
      
      ],
    ),
  ),
 



Padding(
    padding: const EdgeInsets.all(25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

    customButtonWithChartForConfirmed(snapshot.data.numberOfPlayersOnWaitingList,snapshot.data.numberOfPlayersInvited,(){
      toNavigate(context, OnWaitingList(matchId, totalPlayers, matchType));
    },context,Language.Language.onWaiting,Language.Language.invited),
    customButtonWithChartForConfirmed(snapshot.data.numberOfPlayersOnBenchList, snapshot.data.benchListLimit,()
    {
toNavigate(context,OnBenchList(matchId, totalPlayers, matchType));
    }
    ,context,Language.Language.onBench,Language.Language.benchListLimit),
      
      ],
    ),
  ),
 




      // customButton(snapshot.data.pendingPlayers,UnConfirmedPlayers(matchId, totalPlayers, matchType), context, Language.Language.pendingPlayers),
                  // customButton(snapshot.data.numberOfPlayersDeclined,DeclinedRequests(matchId, totalPlayers, matchType), context, Language.Language.declinedPlayers),
  // customButtonWithSliderForAnswers(snapshot.data.numberOfPlayersAnswered, snapshot.data.numberOfPlayersInvited,Language.Language.answeredPLayers),
                  // customButton(snapshot.data.numberOfPlayersOnWaitingList,OnWaitingList(matchId, totalPlayers, matchType), context, Language.Language.onWaiting),
                  // customButtonForBenchList(snapshot.data.benchListExist,snapshot.data.numberOfPlayersOnBenchList,OnBenchList(matchId, totalPlayers, matchType), context, Language.Language.onBench),
                
  ],
      );
    }
          }
  
          )
  
          // ListView(
          //   children: [
          //         customButton(OrganizerMatchDetails(matchId, totalPlayers, matchType), context, Language.Language.confirmed),
                  // customButton(UnConfirmedPlayers(matchId, totalPlayers, matchType), context, Language.Language.unConfirmaedPlayers),
                  // customButton(DeclinedRequests(matchId, totalPlayers, matchType), context, Language.Language.declinedPlayers),
                  // customButton(OnWaitingList(matchId, totalPlayers, matchType), context, Language.Language.onWaiting),
      
          //   ],
          // ),
        );
        }
      
        Widget customButtonForBenchList(benchListExist,int count,whereToNavigate,context,str)
        {
          return Padding(
            padding: const EdgeInsets.all(25),
            child: GestureDetector(
              onTap: ()
              {
                if(benchListExist == true)
                {
                Navigator.push(context, MaterialPageRoute(builder: (context)
                {
                  return whereToNavigate;
                }
                ));
                }
                else if (benchListExist == false)
                {
  
                }
              },
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
              child: Container(
                height: MediaQuery.of(context).size.height/13,
                width: MediaQuery.of(context).size.width-30,
                color:(benchListExist == true)? Theme.of(context).buttonColor:
                Theme.of(context).bottomAppBarColor,
                child: Center(
                  child:(benchListExist == true)?Text('${str} ${count.toString()}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white
                    ),
                    
  
                
  
                                    
                  ):
                    Text(Language.Language.noBench,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white
                    ),
                    ),
  
  
                )
  
              ),
              ),
            ),
          )
          ;
        }
       Widget customButton(count,whereToNavigate,context,str)
        {
          return Padding(
            padding: const EdgeInsets.all(25),
            child: GestureDetector(
              onTap: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context)
                {
                  return whereToNavigate;
                }
                ));
              },
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
              child: Container(
                height: MediaQuery.of(context).size.height/13,
                width: MediaQuery.of(context).size.width-30,
                color: Theme.of(context).buttonColor,
                child: Center(
                  child: Text('${str} ${count.toString()}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white
                    ),
                    ),
  
                  )
                ),
              ),
              ),
            
          )
          ;
        }
        Future matchOverView() 
        async
        {
          String pathToGetMatchData = 'http://192.168.10.26:8000/organize_matches/about_match/$matchId';
          var response = await http.get(pathToGetMatchData
          ,
          headers: <String,String>
          {
            'Content-Type':'application/json',
            'Authorization':'Token ' + UserCredentials.credentialsInstance.getTokenOfUser
          }
          );
          if(response.statusCode == 200)
          {
            Map<String,dynamic> json  = jsonDecode(response.body);
            matchData = MatchOverViewData(json);
            return matchData;
          }
        }
      
  
           Widget customButtonWithSlider(int count,int total,wheteToNavigate,context,str)
        {
                    double divisionsToFill;
  
    double divisionsOfContainer;
    double heightForContainer;
    double widthForContainer;
          heightForContainer  = MediaQuery.of(context).size.height/13;
          widthForContainer  = MediaQuery.of(context).size.width-50;
          divisionsOfContainer = widthForContainer/total.toDouble();
          divisionsToFill = divisionsOfContainer*count;
  
          
        
  return Padding(
    padding: const EdgeInsets.only(top:25,bottom: 25,left:25),
    child:    Align(
        alignment: Alignment.centerLeft,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
                        child: GestureDetector(
                          onTap: () {
                         
       Navigator.push(context,MaterialPageRoute(builder: (context)
       {
         return wheteToNavigate;
       }
       ));
     },
      
                          
                                                child: Container(  ///first container containing bottom app bar colour
          color: Theme.of(context).bottomAppBarColor,
          height:  heightForContainer,
          width: widthForContainer,
          child:
  
   Stack(
       children: [
         
         AnimatedContainer(
         curve: Curves.fastOutSlowIn,
             height: MediaQuery.of(context).size.height/13,
             width: divisionsToFill,
             color:Theme.of(context).buttonColor, duration: Duration
             (
               milliseconds: 300
             ),
            
           ),
           Center(
             child: Text('$str ${count.toString()} / ${total.toString()}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22,
                                                color: Colors.white
                                              ),
                                              ),
                          
                                             ),
           
       ],
     ),
   ),
                        )      
                              
              ),
            )
                        
                                          
  );
                            }
                      
                       Widget customButtonWithSliderForAnswers(int count,int total, String answeredPLayers) 
                        {
                         
                    double divisionsToFill;
    double divisionsOfContainer;
    double heightForContainer;
    double widthForContainer;
          heightForContainer  = MediaQuery.of(context).size.height/13;
          widthForContainer  = MediaQuery.of(context).size.width-50;
        
            
          divisionsOfContainer = widthForContainer/total.toDouble();
          divisionsToFill = divisionsOfContainer*count;
        
  return Padding(
    padding: const EdgeInsets.only(top:25,bottom: 25,left:25),
    child:    Align(
        alignment: Alignment.centerLeft,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
                        child: Container(  ///first container containing bottom app bar colour
          color: Theme.of(context).bottomAppBarColor,
          height:  heightForContainer,
          width: widthForContainer,
          child:
  
   Stack(
     children: [
       AnimatedContainer(
           height: MediaQuery.of(context).size.height/13,
           width: divisionsToFill,
           color:Theme.of(context).buttonColor, duration: Duration
           (
             milliseconds: 300
           ),
          
         ),
         Center(
           child: Text('$answeredPLayers ${count.toString()} / ${total.toString()}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: Colors.white
                                          ),
                                          ),
                      
                                         ),
         
     ],
   )      
                              
              ),
            )
                        )  
                                          
  );
                        }
                      
                        Widget mySliderTackShape()
                         {
                           return ClipRRect(
                             borderRadius: BorderRadius.circular(15),
                           );
                         }
            
              oySliderTackShape() {}
  
     Widget customButtonWithChartForConfirmed(count,total, whereToNivate, BuildContext context, String discription,String from) 
     {
       Map<String,double> pyData = Map<String,double>();
       pyData.putIfAbsent(discription, () => count.toDouble());
       pyData.putIfAbsent(from, () => total.toDouble());
    return Card(
        elevation: 10,
            child: GestureDetector(
          onTap: ()
          {
           whereToNivate();
          }
          ,
            child: Align(
              alignment: Alignment.centerLeft,
                    child: Container(
                height: MediaQuery.of(context).size.height/4,
                width: MediaQuery.of(context).size.width/2.5,
                // color: Colors.red,
                child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text('${discription} ${count}/${total}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                    )
                    ),
                    Expanded(
                      flex:10,
                      child:PieChart(
                        dataMap: pyData,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32.0,
                    chartRadius: MediaQuery.of(context).size.width / 5,
                    showChartValuesInPercentage: false,
                    showChartValues: true,
                    showChartValuesOutside: false,
                    chartValueBackgroundColor: Colors.grey[200],
                    colorList: [
                      Theme.of(context).buttonColor,
                      Theme.of(context).bottomAppBarColor
                    ],
                    showLegends: true,
                    legendPosition: LegendPosition.bottom,
                    decimalPlaces: 1,
                    showChartValueLabel: true,
                    initialAngle: 0,
                    chartValueStyle: defaultChartValueStyle.copyWith(
                      color: Colors.blueGrey[900].withOpacity(0.9),
                    ),
                    chartType: ChartType.ring,
                      )
                      )
                ],
          ),
              ),
            ),
        ),
      
    );
     
     }
  
    Widget customCardForMatchDetails(data)
     {
       return Padding(
         padding: const EdgeInsets.only(top:25,bottom: 25,left: 15,right: 15),
         child: Card(
           elevation: 10,
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(15)
           ),
            
                      child: Container(
               height: MediaQuery.of(context).size.height/2.5,
      child: Column(
        children: [
          individualDetailsOfMatch(Language.Language.title,data.title,'',0),
          individualDetailsOfMatch(Language.Language.cityLable, data.city,'',0),
          individualDetailsOfMatch(Language.Language.addressLable,data.address,'',0),
          individualDetailsOfMatch(Language.Language.date, data.date,'',0),
          individualDetailsOfMatch(Language.Language.time,  data.time,'',0),
          individualDetailsOfMatch(Language.Language.reoccurence,  data.frequency.toString(),Language.Language.days,30),
          individualDetailsOfMatch(Language.Language.maxPlayers,  data.matchType.toString(),Language.Language.players,0),
          Align(
alignment: AlignmentDirectional.centerEnd,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(25)
,
                              topRight: Radius.circular(5)

              )),
              elevation: 10,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(25)
,
                              topRight: Radius.circular(5)

                            ),
                                                      child: GestureDetector(
onTap: ()
{
  showDialogForOptions();
  }
  ,
                                                                                                                child: Container(
                  height: MediaQuery.of(context).size.height/15,
                  width: MediaQuery.of(context).size.width/4,
                  color: Theme.of(context).buttonColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(Language.Language.player,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(Icons.add,
                          color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                                                        ),
                            ),
              ),
            )
  
                    ],
                  ),             
                         ),
                       ),
                  
                   );
                 }
            
             Widget individualDetailsOfMatch(String title, title2,extra,toAddInWidth)
              {
                return Padding(
                  padding: const EdgeInsets.only(top:15,left: 20),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/4.7 + toAddInWidth,
  
                        // color:Colors.red,
                        child: Text('${title}:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ),
                        ),
                      ),
  Text('${title2} ${extra}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                      ),
                      
                    ],
  
                  ),
                );
              }
              toNavigate(BuildContext context,whereToNavigate)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context)
                {
                  return whereToNavigate;
                }
                ));
              }
  
     showDialogForOptions() 
     {
         return showDialog(context: context,
                                        builder: (context)
                                        {
                                            return AlertDialog(
                                                title: Text(Language.Language.whereToMOve),
                                              //  content: Text(Language.Language.continueToLeave),
                                                actions: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(right:15),
                                                                        child: dontDelete(Language.Language.teams,context),
                                                                      ),
                                                    yesDelete(Language.Language.searchPlayers,matchId)
                                                                            
                                                                      ],
                                                                )
                                                                              ],
                                                                          );
                                                                      }
                                                      );
                                                    }
                      
                    
                      
     
Widget dontDelete(String res,context)
                                                      {
                                                        
                                                          return GestureDetector(
                                                            onTap: ()
                                                            
                                                            { 
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)
                                                          {
                                                            return TeamForMatch(matchId);
                                                          }  
                                                          ));             
                                                            }
                                                            ,
                                                            child: ClipRRect(
                                                              // shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10)
                                                              ,
                                                              // ),
                                                              child: Container(
                                                                color: Theme.of(context).buttonColor,
                                                                height: MediaQuery.of(context).size.height/18,
                                                                width: MediaQuery.of(context).size.width/6,
                                                                child: Center(child: Text(res,
                                                                style: TextStyle(
                                                                    color: Colors.white
                                                                ),
                                                                ))),
                                                            )
                                                            
                                                            );
                                                      }
                      
                                                        Widget yesDelete(String res,int matchIde)
                                                      {
                                                        
                                                          return GestureDetector(
                                                            onTap: ()
                                                            async
                                                            { 
                                                              goTo();
                                                            }
                                                            ,
                                                            child: ClipRRect(
                                                              // shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10)
                                                              ,
                                                              // ),
                                                              child: Container(
                                                                color: Theme.of(context).buttonColor,
                                                                height: MediaQuery.of(context).size.height/18,
                                                                width: MediaQuery.of(context).size.width/3,
                                                                child: Center(child: Text(res,
                                                                style: TextStyle(
                                                                    color: Colors.white
                                                                ),
                                                                ))),
                                                            )

                                                            );
                                                      }


                                                       goTo()
                      
                      {
                      
                                                    Navigator.push(context, MaterialPageRoute(builder: (context)
                      
                      {
                        return SearchPlayers(matchId);
                      }
    
                      ));
                      }
    
}