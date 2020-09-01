import 'dart:convert';

import 'package:intl/intl.dart';

class PlayersMatchesFound
{
  int id;
  bool hasAccepted = false;
  bool hasDeclined = false;
  OrganizerData organizerData;
MatchData matchData;
  int playerId;
  int matchId;
  int maxPlayers;
  int totalPlayers;
  
PlayersMatchesFound(Map<String,dynamic> json)
{
  
  this.id = json['id'];
  this.totalPlayers = json['total_players'];
  this.playerId = json['user_id'];
  this.matchId = json['match_id'];
  this.maxPlayers = json['max_players'];
  this.matchData = MatchData(json['match_data']);
  this.organizerData = OrganizerData(json['organizer_information']);
}
}

class MatchData
{
  int cost;
  String addressOfStadium;
  String date;
  String time;
  String title;
  String city;
  

MatchData(Map<String,dynamic> json)
{
  this.cost = json['cost'];
  this.addressOfStadium = json['address_of_stadium'];
  this.title = json['title'];
  this.city = json['city'];
 String dateAndTime = json['date_and_time'];
         this.date = dateAndTime.substring(0,10);
       this.time = dateAndTime.substring(11,16);
 }


}
class OrganizerData
{
  String name;
  var organizerImage;
  OrganizerData(Map<String,dynamic> json)
  {
    this.name = json['organizer_name'];
    var currentImg = json['organizer_image'];
    if(currentImg!= null)
    {

      organizerImage = base64.decode(currentImg);
    }
  }
}