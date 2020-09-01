import 'dart:convert';
import 'package:flutter/scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:sportsbnb/DatabaseHelper.dart';
import 'package:sportsbnb/ErrorConnecting.dart';
import 'package:sportsbnb/LoginData.dart';
import 'package:sportsbnb/NotAuthorizaed.dart';
import 'package:sportsbnb/UserCredentials.dart';
import 'package:sportsbnb/EnglishLanguage.dart' as Language;
class RegisterAMatch extends StatefulWidget
{
  int cost;
  int benchListLimit;
  bool benchList;
String title;
String city;
String address;
String date;
String time;
int frequency;
int matchType;
int id;
String titleOfButton;
String dateAndTime;
RegisterAMatch(title,city,address,dateAndTime,frequency,matchType,id,benchList,titleOfButton,benchListLimit,cost)
{
  this.cost  = cost;
  this.benchListLimit = benchListLimit;
  this.benchList = benchList; 
this.dateAndTime= dateAndTime;
this.title = title;
this.city = city;
this.address = address;
this.date = date;
this.time = time;
this.frequency = frequency;
this.matchType = matchType;
this.id = id;
this.titleOfButton = titleOfButton;
}
@override
State<StatefulWidget> createState() {
return RegisterAMatchState(title,city,address,dateAndTime,frequency,matchType,id,benchList,titleOfButton,benchListLimit,cost);
}

}

class RegisterAMatchState <T extends StatefulWidget> extends State<T>
{
  int cost;
  bool benchListAllowed = false;
  bool benchList;
String title;
String city;
String address;
int selectedFrequency;
int selectedPlayersOnBenchCount;
String selectedMatchType;
int id;
DateTime dateAndTime;
String titleOfButton;
// dateAndTime = DateTime();
RegisterAMatchState(title,city,address,String currentDateAndTime,frequency,matchType,id,benchList,titleOfButton,benchListLimit,cost)
{
  this.cost = cost;
  this.selectedPlayersOnBenchCount = benchListLimit;
  this.benchList = benchList;
this.title = title;
this.city = city;
this.address = address;
this.dateAndTime = DateTime.parse(currentDateAndTime);
this.selectedFrequency = frequency;
this.selectedMatchType = (matchType == 5)?Language.Language.fivePlayers:
(matchType == 7)?Language.Language.sevenPlayers:
Language.Language.elevenPlayers;
this.id = id;
this.titleOfButton = titleOfButton;
}
String responseFromNetwork;


List<int> playersOnBenchCount = [1,2,3,4,5,6,7];

List<int> frequencies = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30];

var dateFormat = DateFormat('yyyy-MM-dd HH:mm');


List<String> matchType = [Language.Language.fivePlayers,Language.Language.sevenPlayers,Language.Language.elevenPlayers];
// String selectedMatchType = Language.Language.fivePlayers;


TextEditingController titleController = TextEditingController();
TextEditingController cityController = TextEditingController();
TextEditingController costController = TextEditingController();
TextEditingController addressController = TextEditingController();

String titleLabel = Language.Language.titleLable;
String cityLabel = Language.Language.cityLable;
String addressLabel = Language.Language.addressLable;

String titleReturn = Language.Language.titleReturn;
String cityReturn = Language.Language.cityReturn;
String addressReturn = Language.Language.addressReturn;
final formKey = GlobalKey<FormState>();
double checkTilePos;
double centerOfDevice;
double dropdownPos;
double sizeOfTextField;
@override
void initState() {

super.initState();
titleController.text = title;
cityController.text = city;
addressController.text =  address;
costController.text = cost.toString();
}
@override
Widget build(BuildContext context) {
  sizeOfTextField = MediaQuery.of(context).size.width-10;
  dropdownPos = MediaQuery.of(context).size.width-30;
  checkTilePos = MediaQuery.of(context).size.width-30;
centerOfDevice = MediaQuery.of(context).size.width/2;
return  Scaffold(
// backgroundColor: Theme.of(context).accentColor,
appBar: AppBar(
leading: Container(),
backgroundColor: Theme.of(context).bottomAppBarColor,
title:Text(Language.Language.registerAMatch),
),

body: Form(
key: formKey,
child: ListView(
children:<Widget>[    
Container(
  height: MediaQuery.of(context).size.height,
  width: MediaQuery.of(context).size.width,
  child:   Stack(
  children: [
  Container(
  child: (responseFromNetwork == null)?
  Text('')
  :
  Text(responseFromNetwork)
  
  ),
  
  Positioned(
    // top: MediaQuery.of(context).size.height/12,
     left:centerOfDevice - sizeOfTextField/2,
     
    child: Container(
      height: MediaQuery.of(context).size.height/10,
      width: sizeOfTextField,
      child: customTextField(titleController,titleLabel,titleReturn))),
  
  Positioned(
    top: MediaQuery.of(context).size.height/12,
     left:centerOfDevice - sizeOfTextField/2,
     
    child: Container(
      height: MediaQuery.of(context).size.height/10,
      width: sizeOfTextField,
      child: customTextField(cityController,cityLabel,cityReturn))),
  
  Positioned(
    top: MediaQuery.of(context).size.height/6,
     left:centerOfDevice - sizeOfTextField/2,
     
    child: Container(
      height: MediaQuery.of(context).size.height/10,
      width: sizeOfTextField,
      
    
    child: customTextField(addressController,addressLabel,addressReturn))),


  Positioned(
    top: MediaQuery.of(context).size.height/4,
     left:centerOfDevice - sizeOfTextField/2,
     
    child: Container(
      height: MediaQuery.of(context).size.height/10,
      width: sizeOfTextField,
      
    
    child: customTextFieldForCost(costController,Language.Language.cost,Language.Language.enterCost))),

  Positioned(
    top: MediaQuery.of(context).size.height/2.7,
     left:centerOfDevice - dropdownPos/2,
     
      child: Text(Language.Language.selectMatchType
    ,
    style: TextStyle(
    fontSize: 18,
    color: Colors.black
    ),
    ),
  ),
  
  
   Positioned(
     top: MediaQuery.of(context).size.height/2.55,
     left:centerOfDevice - dropdownPos/2,
     
     child: Container(
      //  color:Colors.red,
       child: matchTypeDropDown())),
  
  
   Positioned(
     top: MediaQuery.of(context).size.height/2.2,
     left:centerOfDevice - dropdownPos/2,
        child: Text(Language.Language.selectFrequencyOfMatch
  ,
  style: TextStyle(
  fontSize: 18,
  color: Colors.black
  ),
  ),
   ),
  
  
  
   Positioned(
     top: MediaQuery.of(context).size.height/2.1,
     left: centerOfDevice - dropdownPos/2,
     child: frequencyDropDown()),
  
   Positioned(
     top: MediaQuery.of(context).size.height/1.8,
     left: centerOfDevice- checkTilePos/2,
     child: Container(
       height: MediaQuery.of(context).size.height/14,
       width: checkTilePos,
       child: allowBenchList())),
  
  AnimatedPositioned(
    
    child: Container(
    height: MediaQuery.of(context).size.height/14,
    width: MediaQuery.of(context).size.width-30,
  child: dropdownForBenchPlayersCount()),
  
     duration: Duration(milliseconds: 300),
     top: MediaQuery.of(context).size.height/1.6,
      left: (benchListAllowed == false)?MediaQuery.of(context).size.width :
 centerOfDevice - dropdownPos/2
     ),
  
     AnimatedPositioned(
       duration: Duration(milliseconds: 300),
       top:(benchListAllowed == false)? MediaQuery.of(context).size.height/1.6:
       MediaQuery.of(context).size.height/1.42,
       left: (centerOfDevice-centerOfDevice/2),
          child: Container(
                            height: MediaQuery.of(context).size.height/16,
                            width: centerOfDevice,
                            child:
                          dateAndTimeButton(context),
                            
                                                ),
     ),
                          
  
                
                            
                                
                            AnimatedPositioned(
                              duration: Duration(
                                milliseconds: 300
                              ),
                              top:(benchListAllowed == false)? MediaQuery.of(context).size.height/1.4:
                              MediaQuery.of(context).size.height/1.3,
                              // left: MediaQuery.of(context),
                                                      child: GestureDetector(
                                onTap:()
                                
                                { 
                                  debugPrint('yakii');
                                  if(id == 0)
                                  {
    
                                  postAMatch();
                                  }
                                  else if (id!=0)
                                  {
                                    updateMAtch();
                                  }
                                },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)
                                      
                                    ),
                                    color: Theme.of(context).buttonColor,
                                    child: Container(
                                      height:MediaQuery.of(context).size.height/13,
                                      width:MediaQuery.of(context).size.width-9,
                                      child:Center(child: Text(titleOfButton,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white
                                      ),
                                      )) ,
                                    ),
                                  ),
                                ),
                            ),
                            
    
    ],
    ),
  ),
                      ]
                      ),
                      ),
                      );
                  
                }
              
                Widget customTextField(TextEditingController controller, String label, String returnLabel)
                {
                  return 
                              Padding(
                                padding: const EdgeInsets.only(top:25,left:25,right:25),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  elevation: 20,
                                                  child: TextFormField(
                                      obscureText: false,
              
                                        decoration: InputDecoration(
                                        border:OutlineInputBorder(
                                          //  borderSide: new BorderSide(color: Colors.deepOrange),
                                            borderRadius: BorderRadius.circular(20)
                                            ),
                                          
                                            labelText: label,
              
                                        ),
                                      controller: controller,
                                      validator: (value)
                                      {
                                          if(value.isEmpty)
                                          {
                                            return Language.Language.enterConfirmPassword;
                                          }
                                      },
                                    ),
                                ),
                              );
                }

 Widget customTextFieldForCost(TextEditingController controller, String label, String returnLabel)
                {
                  return 
                              Padding(
                                padding: const EdgeInsets.only(top:25,left:25,right:25),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  elevation: 20,
                                                  child: TextFormField(
                                      obscureText: false,
              
                                        decoration: InputDecoration(
                                        border:OutlineInputBorder(
                                          //  borderSide: new BorderSide(color: Colors.deepOrange),
                                            borderRadius: BorderRadius.circular(20)
                                            ),
                                          
                                            labelText: label,
              
                                        ),
                                      controller: controller,
                                      
                                    ),
                                ),
                              );
                }



                Future postAMatch()
                async
                {
                  
                                  String correctingToken = "Token ";
                                    String pathToRegisterMatch = 'http://192.168.10.26:8000/organize_matches/add_match_of_eleven/';
                                    if(formKey.currentState.validate())
                                    {
                                      if(dateAndTime != null)
                                      {
                                      try{
                                    var response = await http.post(pathToRegisterMatch,
                                    headers:<String,String>
                                    {
                                        'Authorization':correctingToken + UserCredentials.credentialsInstance.getTokenOfUser,
                                        'Content-Type':'application/json',
                                    },
                                    body: jsonEncode(<String,dynamic>
                                    {
                              
                                      'title':titleController.text.toString(),
                                      'city':cityController.text.toString(),
                                      'address_of_stadium':addressController.text.toString(),
                                      'date_and_time':dateFormat.format(dateAndTime),
                                      'user_id':UserCredentials.credentialsInstance.getIdOfUser,
                                      'match_type':(selectedMatchType == matchType[0])?5:
                                      (selectedMatchType == matchType[1])?7:
                                      11,
                                      'frequency':selectedFrequency,
                                      'bench_list':benchList,
                                      'bench_list_limit':(benchList == true)?selectedPlayersOnBenchCount:0,
                                      'cost':costController.text.toString()
                                              }
                                    )
                                    );
                              
                                      if(response.statusCode == 201)
                                      {
                                        setState(() {
                                          
                                          responseFromNetwork = '';
                                        });
                                        Navigator.pop(context,true);
                                      
                                      }
                              
                                      else if(response.statusCode == 203)
                                      {
                                        setState(() {
                                          
                                        responseFromNetwork = 'Wrong Authorative information';
                                        });
                                      }
                              
                                      else if(response.statusCode == 400)
                                      {
                                        setState(() {
                                          
                                        responseFromNetwork = 'Bad Request';
                                        });
                                      }
                                      else if(response.statusCode == 401)
  {
  NotAuthorizaed.showNotAuthorizedAlert(context);
  }
                              
                                      else
                                      {
                                        setState(() {
                                          responseFromNetwork = Language.Language.internalServerError;
                                        });
                                      }
                                    }
  catch(e)
  {
  // Navigator.pop(context);
  ErrorConnecting.ConnectingIssue(context);
  }
                                      }
                                      else if (dateAndTime == null)
                                      {
                                            customDialog(context, Language.Language.please, Language.Language.selectDateAndTime);
                                      }
                                    }
                              
                              
                                }
  
  
  
                                    Future updateMAtch()
                async
                {
                  
                                  String correctingToken = "Token ";
                                    String pathToRegisterMatch = 'http://192.168.10.26:8000/organize_matches/add_match_of_eleven/';
                                    if(formKey.currentState.validate())
                                    {
                                      if(dateAndTime != null)
                                      {
                                      try{
                                    var response = await http.put(pathToRegisterMatch,
                                    headers:<String,String>
                                    {
                                        'Authorization':correctingToken + UserCredentials.credentialsInstance.getTokenOfUser,
                                        'Content-Type':'application/json',
                                    },
                                    body: jsonEncode(<String,dynamic>
                                    {
                                        'match_id':id,
                                      'title':titleController.text.toString(),
                                      'city':cityController.text.toString(),
                                      'address_of_stadium':addressController.text.toString(),
                                      'date_and_time':dateFormat.format(dateAndTime),
                                      'user_id':UserCredentials.credentialsInstance.getIdOfUser,
                                      'match_type':(selectedMatchType == matchType[0])?5:
                                      (selectedMatchType == matchType[1])?7:
                                      11,
                                      'frequency':selectedFrequency,
                                      'bench_list':benchList,
                                      'bench_list_limit':(benchListAllowed == true)?selectedPlayersOnBenchCount:0
                                      ,
                                      'cost':costController.text.toString()
                                            
                                              }
                                    )
                                    );
                              
                                      if(response.statusCode == 201)
                                      {
                                        setState(() {
                                          
                                          responseFromNetwork = '';
                                        });
                                        Navigator.pop(context,true);
                                     
                                      }
                              
                                      else if(response.statusCode == 203)
                                      {
                                        setState(() {
                                          
                                        responseFromNetwork = 'Wrong Authorative information';
                                        });
                                      }
                              
                                      else if(response.statusCode == 400)
                                      {
                                        setState(() {
                                          
                                        responseFromNetwork = 'Bad Request';
                                        });
                                      }
                                      else if(response.statusCode == 401)
  {
  NotAuthorizaed.showNotAuthorizedAlert(context);
  }
                              
                                      else
                                      {
                                        setState(() {
                                          responseFromNetwork = Language.Language.internalServerError;
                                        });
                                      }
                                    }
  catch(e)
  {
  // Navigator.pop(context);
  ErrorConnecting.ConnectingIssue(context);
  }
                                      }
                                      else if (dateAndTime == null)
                                      {
                                            customDialog(context, Language.Language.please, Language.Language.selectDateAndTime);
                                      }
                                    }
                              
                              
                                }
            
                              
                                
                  
                  
                  
                  
                  Widget dateAndTimeButton(BuildContext context)
                  {
                    return GestureDetector(
                        // onTap: getDateAndTime(context),
                        onTap: ()
                        {
                          getDateAndTime(context);
                        }
                        ,
                        child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        color: Theme.of(context).buttonColor,
                        child: Container(
                          height: 55,
                          width: 100,
                          // width: 100,
                          // child: Text('data'),
                          child:Center(
                            child: (dateAndTime == null)?
                            Text(Language.Language.selectDateAndTimeForMAtch,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),
                            ):
                            // Text('yakii')
                            Text(dateFormat.format(dateAndTime),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),
                            )
                  ,
                            ),
                          )       ),
                      );
                    
                  }
                  
                  
                    getDateAndTime(BuildContext context)
                                  async
                                  {
                                  final selectedDate =  await _selectDate(context);
                                  if(selectedDate !=null)
                                  {
                                    final selectedTime = await _selectTime(context);
                                    if(selectedTime != null)
                                      {
                                        setState(() {
                                          
                                            
                                          dateAndTime = DateTime(selectedDate.year,selectedDate.month,selectedDate.day,
                                          selectedTime.hour,selectedTime.minute);
                                        });
                                      }
                                  }
                                  else if(selectedDate == null)
                                  {
                                    return;
                                  }
                                  }
                  Future _selectDate(BuildContext context)
                  async
                  {
                  return await showDatePicker(context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().add(Duration(seconds: 10)),
                      lastDate: DateTime(2100));
                  
                  }
                  
                  
                  
                  Future _selectTime(BuildContext context)
                  async
                  {
                  return await showTimePicker(context: context,
                    initialTime: TimeOfDay(hour: TimeOfDay.now().hour,
                    minute: TimeOfDay.now().minute));
                    
                  }
  
  Widget  matchTypeDropDown()
    {
      return DropdownButton(
  value: selectedMatchType,
  icon: Icon(Icons.arrow_downward),
  dropdownColor: Colors.blue,
  iconSize: 24,
  elevation: 16,
  style: TextStyle(color: Colors.black),
  underline: Container(
  height: 2,
  color: Theme.of(context).buttonColor,
  ),
  onChanged: (String newValue) {
  setState(() {
  selectedMatchType = newValue;
  });
  },
  items: matchType
  .map((String currentValue) {
  return DropdownMenuItem<String>(
  value: currentValue,
  child: Text(currentValue,
  style: TextStyle(
    fontSize: 18
  // color: Theme.of(context).accentColor
  ),
  
  ),
  );
  }).toList(),
  );
  }
  
  Widget  frequencyDropDown()
    {
      return DropdownButton(
  value: selectedFrequency,
  icon: Icon(Icons.arrow_downward),
  dropdownColor: Colors.blue,
  iconSize: 24,
  elevation: 16,
  style: TextStyle(color: Colors.black),
  underline: Container(
  height: 2,
  color: Theme.of(context).buttonColor,
  ),
  onChanged: (int newValue) {
  setState(() {
  selectedFrequency = newValue;
  });
  },
  items: frequencies
  .map((int currentValue) {
  return DropdownMenuItem(
  value: currentValue,
  child: Text('${currentValue.toString() } days',
  style: TextStyle(
    fontSize: 18
  // color: Theme.of(context).accentColor
  ),
  
  ),
  );
  }).toList(),
  );
  }                
  
  
  
  
  customDialog(BuildContext context,String title,String content)
  {
  showDialog(context: (context),
  builder: (context)
  {
  return AlertDialog(
  title: Text(title),
  content: Text(content),
  );
  });
  }
  
  Widget allowBenchList() 
  {
  return Card(
  color: Theme.of(context).buttonColor,
  child: CheckboxListTile(
    checkColor: Colors.white,
  title: Text(Language.Language.bench,
  style: TextStyle(
  fontSize: 18,
  color: Colors.white
  ),
  ),
  // value:timeDilation !=1,
  value: benchList,
  onChanged: (bool newValue)
  {
  setState(() {
  
  benchList = newValue;
  benchListAllowed = newValue;
  // timeDilation = newValue? 2:1;
  });
  }
  ),
  );
  }
  
    Widget dropdownForBenchPlayersCount()
     {
     return DropdownButton(
  value: selectedPlayersOnBenchCount,
  icon: Icon(Icons.arrow_downward),
  dropdownColor: Colors.blue,
  iconSize: 24,
  elevation: 16,
  style: TextStyle(color: Colors.black),
  underline: Container(
  height: 2,
  color: Theme.of(context).buttonColor,
  ),
  onChanged: (int newValue) {
  setState(() {
  selectedPlayersOnBenchCount = newValue;
  });
  },
  items: playersOnBenchCount
  .map((int currentValue) {
  return DropdownMenuItem(
  value: currentValue,
  child: Text('${currentValue.toString()}  ${Language.Language.players}',
  style: TextStyle(
    fontSize: 18
  // color: Theme.of(context).accentColor
  ),
  
  ),
  );
  }).toList(),
  );
  }                
}
