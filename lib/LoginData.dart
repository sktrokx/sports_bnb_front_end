import 'dart:convert';
import 'dart:io';

import 'dart:typed_data';


class LoginData{
  
  String email;
  int user_id;
  String Authorization;
  String phoneNumber;
  Uint8List profilePicture;
  String firstName;
  String lastName;
  bool isOrganizer;
  bool available;
  PLayerChareacteristics playerCharacteristics;
LoginData(Map<String,dynamic> json)
{
  this.available = json['is_available'];
this.email = json['email'];
this.user_id = json['user_id'];
this.Authorization = json['Authorization'];
this.phoneNumber = json['phone_number'];
var currentImg = json['profile_picture'];
if(currentImg != null)
{
  profilePicture = base64.decode(currentImg);
}
Map<String,dynamic> tempChar = json['player_characteristics'];
if(tempChar != null)
{
  playerCharacteristics = PLayerChareacteristics(tempChar);
}
this.firstName = json['first_name'];
this.lastName = json['last_name'];
this.isOrganizer = json['is_organizer'];
}
}
class PLayerChareacteristics
{
  bool rightFoot;
  bool leftFoot;
  String position;
  bool goalKeeper;
  PLayerChareacteristics(Map<String,dynamic> json)
  {
    this.rightFoot =  json['right_foot'];
    this.leftFoot = json['left_foot'];
    this.position = json['position'];
    this.goalKeeper = json['goal_keeper'];
  }
  }

 