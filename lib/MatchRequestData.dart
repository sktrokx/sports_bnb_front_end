import 'dart:convert';

class MatchRequestData 
{
  bool hasAccepted = false;
  bool hasDeclined = false;
  OrganizerData organizerData;
  MatchData matchData;
  int id;
  var organizerImage;
var maxPlayers;
MatchRequestData(Map<String,dynamic> json)
{
  this.id = json['id'];
  this.maxPlayers = json['max_players'];
  
  var currentImg = json['organizer_image'];
  if(currentImg != null)
  {
  this.organizerImage = base64.decode(currentImg);
  }
      this.matchData = MatchData(json['match_data']);
  
  
  
  this.organizerData = OrganizerData(json['organizer_information']);
  
}
}

class MatchData
{
  int matchId;
  String title;
  String city;
  String addressOfStadium;
  String date;
  String time;
  MatchData(Map<String,dynamic> json)
  {
    this.matchId = json['id'];
    this.title = json['title'];
    this.city = json['city'];
    this.addressOfStadium = json['address_of_stadium'];
  var dateAndTime = json['date_and_time'];
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