import 'dart:convert';


class FoundMatchDetails
{
  String available;
  String comment;
  int playerId;
  String playerName;
  var playerImage;
  String playerPhoneNumber;
  String playerEmailId;
  int playingId;
  int matchId ;
int teamId;
  FoundMatchDetails(Map<String,dynamic> json)
  {
    this.available = json['available'];
    this.comment = json['comment'];
    this.playerId = json['user_id'];
    this.playerName  =json['player_name'];
    var currentImage = json['player_image'];
    this.teamId = json['team_id'];
    if(currentImage !=null)
    {
      this.playerImage = base64.decode(currentImage);

    }
    this.playerPhoneNumber = json['player_phone_number'];
this.playerEmailId = json['player_email_id'];
this.matchId = json['match_id'];
this.playingId = json['id'];
  }
}