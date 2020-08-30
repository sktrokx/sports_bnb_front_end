import 'dart:convert';

class PlayerFoundData
{
  String available;
  bool alreadyRequested  = false;
  bool playing = false;
  bool onWaiting = false;
  bool onBench  = false;
  bool sent = false;
  var profilePicture;
  dynamic characteristics;
  PlayerCharacteristicsFoundData playerCharracteristics;
  String firstName;
  String lastName;
  int id;
  String phoneNumber;
  String email;
  PlayerFoundData(Map<String,dynamic> json)
{
  // this.onWaiting  = json['on_waiting_list'];
  // this.onBench = json['on_bench_list'];
  this.available = json['available'];
  this.playing  = json['on_playing_list'];
  this.alreadyRequested = json['already_requested'];
  this.firstName = json['first_name'];
  this.lastName   = json['last_name'];
  this.id = json['id'];
this.phoneNumber = json['phone_number'];
this.email = json['email'];
this.characteristics = json['player_characteristics'];
if(this.characteristics != null)
{
this.playerCharracteristics = PlayerCharacteristicsFoundData(characteristics);
}
var currentImg = json['profile_picture'];

if(currentImg !=null)
{
  this.profilePicture = base64.decode(currentImg);
 } 
 }

}

class PlayerCharacteristicsFoundData
{

bool rightFoot = false;
bool leftFoot = false;
String position = ' - ';
bool goalKeeper = false;
int id;
int playerId;

PlayerCharacteristicsFoundData(Map<String,dynamic> json)

{
  this.rightFoot = json['right_foot'];
  this.leftFoot = json['left_foot'];
  this.position = json['position'];
  this.goalKeeper = json['goal_keeper'];
  this.id = json['id'];
  this.playerId = json['player_id'];

}
}