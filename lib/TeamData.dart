import 'dart:convert';

class TeamData
{
  // List<PlayerData> listOfPlayers;
  int id;
  String title;
  List<dynamic> players;
  bool hasAccepted = false;
  bool hasDeclined =false;
    TeamData(Map<String,dynamic> json)
  {
    this.id = json['id'];
    this.title = json['title_of_team'];
    // this.players = json['team_players'];
    // if(this.players !=null)
    // {
//     for(var currentPlayer in this.players)
//     {
// //  listOfPlayers = List<PlayerData>();

//       // PlayerData currentPlayerData = PlayerData(currentPlayer);
//       // listOfPlayers.add(currentPlayerData);
//     }
    }
  }


// class PlayerData
// {
//   String firstName;
//   String lastName;
//   var userPicture;
//   String phoneNumber;
//   PlayerData(Map<String,dynamic>
//   json
//   )
//   {
//     this.firstName = json['first_name'];
//     this.lastName = json['lasr_name'];
    
//      var tempUserPicture = json['profile_picture'];
//     if(tempUserPicture !=null)
//     {
//       this.userPicture = base64.decode(tempUserPicture);
//     }
//     this.phoneNumber=json['phone_number'];
//   }

//   }

class TeamDataRequest
{
  bool hasAccepted = false;
  bool hasDeclined = false;
  int id;
  String organizerName;
  String title;
  int teamId;
  var organizerImage;

  TeamDataRequest(Map<String,dynamic> json)
  {
    this.id = json['id'];
    this.organizerName = json['team_organizer_name'];
    this.title = json['title'];
    this.teamId = json['team_id'];
    var currentImg = json['team_organizer_image'];

    if(currentImg!=null)
    {
      this.organizerImage = base64.decode(currentImg);
    }
  }
}