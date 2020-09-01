import 'dart:convert';
import 'package:sportsbnb/ErrorConnecting.dart';
import 'package:sportsbnb/Loading.dart'as Loading;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sportsbnb/EnglishLanguage.dart' as Language;
import 'package:sportsbnb/NotAuthorizaed.dart';
import 'package:sportsbnb/UserCredentials.dart';
import 'package:sportsbnb/UserInformation.dart';
import 'package:http/http.dart' as http;


class SetCharacteristics extends StatefulWidget {
 UserInformation snap;
 SetCharacteristics(snap)
 {
this.snap = snap;
 }
  @override
  _SetCharacteristicsState createState() => _SetCharacteristicsState(snap);
}

class _SetCharacteristicsState extends State<SetCharacteristics> {
  UserInformation snap;
  _SetCharacteristicsState(snap)
  {
    this.snap = snap;
  }
bool goalKeeper = false;
int selectedFoot = 1;
String selectedPosition = 'midfielder';
List<String> positions = ['defender','midfielder','striker'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text('Set Characteristics'),
  backgroundColor: Theme.of(context).bottomAppBarColor,

),
body: ListView(
children: [
  textWidget(Language.Language.iPlayWith),
    Padding(
      padding: const EdgeInsets.only(top:15,left:35,right: 35,bottom: 15),
      child: customRadioButton(),
    ),
    textWidget(Language.Language.position),
  Padding(
    padding: const EdgeInsets.only(top:15,left:35,right:35,bottom: 15),
    child: dropDownForPositions(),
  ),
    Padding(
      padding: const EdgeInsets.only(top:30,left:35,right:35,bottom: 15),
      child: customCheckBox(),
    ),
    Padding(
      padding: const EdgeInsets.all(35),
      child: saveButton(),
    )
        
        ],
        ),
            );
          }
        
         Widget customRadioButton()
          {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
                ,
                
              ),
              elevation: 10,
              child: Column(
                children: [
      
                    RadioListTile(
                              title: Text(Language.Language.rightFoot),
                              value: 1,
                               groupValue: selectedFoot, 
                               onChanged: (value)
                          {
                              changeSelectedValue(value);
                          }  
                          ),
                
                
                
                
                   RadioListTile(
                              title: Text(Language.Language.leftFoot)
                              ,value: 2,
                               groupValue: selectedFoot,
                                onChanged:(value)
                            {
                            changeSelectedValue(value);
                                                  }
                                                  ),
                                      ],
                                    ),
                                  );
                                }
                            
                              void changeSelectedValue(value)
                               {
                                 setState(() {
                                   selectedFoot = value;
                                 });
                               }
      
       Widget customCheckBox()
        {
          return Card(
                  child: CheckboxListTile( 
                                   title: Text(Language.Language.goalKeeper),
                                   
                                   
                                   value: timeDilation !=1
                                   ,onChanged: (bool value)
                                 {
              
                                   setState(() {
                                     goalKeeper = value;
                                     timeDilation = value? 2:1;
                                   });
                                 }
                                 ),
          );
        }
     Widget  dropDownForPositions()
                    {
                             return DropdownButton(
                                      value: selectedPosition,
                                      icon: Icon(Icons.arrow_downward),
                                      dropdownColor: Colors.blue,
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(color: Colors.black,
                                      fontSize: 15
                                      ),
                                      underline: Container(
                                        height: 2,
                                        color: Theme.of(context).buttonColor,
                                      ),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          selectedPosition = newValue;
                                        });
                                      },
                                      items: positions
                                          .map((String currentValue) {
                                        return DropdownMenuItem(
                                          value: currentValue,
                                          child: Text(currentValue,
                                          style: TextStyle(
                                            // color: Theme.of(context).accentColor
                                          ),
                                          
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  }
    
     Widget saveButton()
      {
        return GestureDetector(
          onTap: ()
          {
            if(snap.playerCharacteristics == null)
            {
            saveCahracteristics();
                      }
                      else
                      {
                      updateCharacteristics();
                      }
                    }
                    ,
                          child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          color: Theme.of(context).buttonColor,
                          height: MediaQuery.of(context).size.height/20,
                          width: MediaQuery.of(context).size.width-30,
                child: Center(
                    child: Text(Language.Language.save,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white
                    ),
                    ),
            
                ),
                        ),
                    ),
                  );
                }
            
              Future saveCahracteristics() 
              async
              {
                Loading.ShowLoadingDialog.showLoaderDialog(context);
              String pathToSaveCharacteristics = 'http://192.168.10.26:8000/organize_matches/set_characteristics/';
             try{
              var response = await http.post(
                pathToSaveCharacteristics,
                headers: <String,String>
                {
                  'Content-Type':'application/json',
                  'Authorization':'Token '+UserCredentials.credentialsInstance.getTokenOfUser
                }
                ,
                body: jsonEncode(<String,dynamic>
                {
                  'user_id':UserCredentials.credentialsInstance.getIdOfUser,
                  'right_foot':(selectedFoot == 1)?true:false,
                  'left_foot':(selectedFoot == 2)?true:false,
                  'goal_keeper':goalKeeper,
                  'position':selectedPosition
                }
                )
              );
              if(response.statusCode == 200)
              {
                  Navigator.pop(context);
                 Navigator.pop(context,true);

              }
              else if(response.statusCode == 401)
{
  NotAuthorizaed.showNotAuthorizedAlert(context);
}
              else
              {
                Navigator.pop(context);
              }
}
catch(e)
{
  Navigator.pop(context);
  ErrorConnecting.ConnectingIssue(context);
}

              }
  
  
  
                Future updateCharacteristics() 
              async
              {
                Loading.ShowLoadingDialog.showLoaderDialog(context);
              String pathToSaveCharacteristics = 'http://192.168.10.26:8000/organize_matches/set_characteristics/';
           try{
              var response = await http.put(
                pathToSaveCharacteristics,
                headers: <String,String>
                {
                  'Content-Type':'application/json',
                  'Authorization':'Token '+ UserCredentials.credentialsInstance.getTokenOfUser
                }
                ,
                body: jsonEncode(<String,dynamic>
                {
                  'user_id':UserCredentials.credentialsInstance.getIdOfUser,
                  'right_foot':(selectedFoot == 1)?true:false,
                  'left_foot':(selectedFoot == 2)?true:false,
                  'goal_keeper':goalKeeper,
                  'position':selectedPosition
                }
                )
              );
              if(response.statusCode == 200)
              {
                  Navigator.pop(context);
                 Navigator.pop(context);
              }
              else
              {
                Navigator.pop(context);
              }
              }
catch(e)
{
  Navigator.pop(context);
  ErrorConnecting.ConnectingIssue(context);
}
              }
  
    Widget textWidget(String str) 
    {
      return Padding(
        padding: const EdgeInsets.only(top:15,left:35),
        child: Text(str,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        ),
      );

    }
}