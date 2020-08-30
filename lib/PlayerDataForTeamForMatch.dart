import 'dart:convert';

class PlayerDataForTeamForMatch
{
  String available;
  bool onWaitingList = false;
  bool onBenchList = false;
  bool alreadyRequested = false;
  bool playing = false;
  String comment; //no use only defining for inheritance issue
  bool sent = false; // defining for controlling state
  int playerId;
  String playerName;
  var playerImage;
  String playerPhoneNumber;
  String playerEmailId;
  int playingId;
  int matchId ;
int teamId;
  PlayerDataForTeamForMatch(Map<String,dynamic> json)
  {
    this.available = json['available'];
    this.playing  = json['playing'];
    this.alreadyRequested = json['already_requested'];
    this.onBenchList = json['on_bench'];
    this.onWaitingList = json['on_waiting'];
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