import 'dart:convert';

class UserInformation
{
  bool available;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  var userPicture;
  PlayerCharacteristics playerCharacteristics;
  UserInformation(Map<String,dynamic> json)
  {
    this.available = json['is_available'];
    this.firstName = json['first_name'];
    this.lastName = json['last_name'];
    this.email = json['email'];
    this.phoneNumber = json['phone_number'];
    var currentImg = json['user_image'];
    if(currentImg != null)
    {
      this.userPicture = base64.decode(currentImg);
    }
  dynamic currentCharacteristics;
    
    currentCharacteristics = json['player_characteristics'];
    if(currentCharacteristics!=null)
    {
      playerCharacteristics = PlayerCharacteristics(currentCharacteristics);
    }
  }
}
class PlayerCharacteristics
{
  bool leftFoot;
  bool rightFoot;
  bool isGoalKeeper;
  String position;
  PlayerCharacteristics (Map<String,dynamic> json)
{
  this.leftFoot = json['left_foot'];
  this.rightFoot = json['right_foot'];
  this.isGoalKeeper = json['goal_keeper'];
  this.position = json['position'];
}

}