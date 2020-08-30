import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sportsbnb/ErrorConnecting.dart';


class CharacteristicsSignUp extends StatefulWidget
{
  int userId;
  String Authorization;
  CharacteristicsSignUp(int userId,String Authorization)
  {
this.userId = userId;
this.Authorization = Authorization;
  }
  @override
  State<StatefulWidget> createState() {
 return CharacteristicsSignUpState(userId,Authorization);
  }

}


class CharacteristicsSignUpState extends State<CharacteristicsSignUp>
{
  String Authorization;
  File _image;
  String selectedPosition;
  List<String> positions = ['midfielder','striker','defender'];
String positionStart = 'midfielder';
  bool goalKeeper;
  int userId;
  CharacteristicsSignUpState(int userId,String Authorization)
  {
    this.userId = userId;
  this.Authorization = Authorization;
  }
  int selectedValue;
  @override
  void initState() {
    
    super.initState();
    selectedValue = 1;
  }



  @override
  Widget build(BuildContext context) {
 
 
 return Scaffold(
   appBar: AppBar(
     title: Text('Charactiristics'),
   backgroundColor: Colors.brown,
   ),
   body: getCharacteristics(context));



  }
  
Widget  getCharacteristics(BuildContext context)
{
  return  ListView(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top:80),
        child: Container(
          height: MediaQuery.of(context).size.height/4,
          width:MediaQuery.of(context).size.width,
          child: Stack(
              children: <Widget>[




               Positioned(
                 top: 40,
                 left: 30,
                          child: Card(
child: Container(
          height: MediaQuery.of(context).size.height/6,
            width:MediaQuery.of(context).size.width/1.2,
 
        child:   Padding(
          padding: const EdgeInsets.only(top:15,left:8),
          child: Column(
          children:<Widget>
          [
              RadioListTile(
                        title: Text('Left Foot'),
                        value: 1,
                         groupValue: selectedValue, 
                         onChanged: (value)
                    {
                        changeSelectedValue(value);
                    }  
                    ),
          
          
          
          
             RadioListTile(
                        title: Text('right foot'),
                        value: 2,
                         groupValue: selectedValue,
                          onChanged:(value)
                      {
                      changeSelectedValue(value);
                      }
                      ),
          ]
                    ),
        ),
),


),
               ),

Positioned(
        top:160,
        left: 50,
        child:   Card(
          child: Container(
            height: 50,
            width:300,
            child:CheckboxListTile( 
                             title: Text("goal keeper?"),
                             
                             
                             value: timeDilation !=1
                             ,onChanged: (bool value)
                           {
        
                             setState(() {
                               goalKeeper = value;
                               timeDilation = value? 2:1;
                             });
                           }
                           ),
          ),
        ),
),



                  Card(
                      child : Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: Text('I Play with my',
                    style: TextStyle(
                      fontSize: 25
                    ),
                    )),      
                      )
                  ),
               
              ],
                








                  
              
            
          ),
        ),
      ),




Padding(
  padding: const EdgeInsets.only(top:20),
  child:   Container(
    width: 20,
    height: 70,
    child:   DropdownButton(
          value: positionStart,
          items: positions.map((value)
          {
    return  DropdownMenuItem(
          child: Center(
            child: Text(value,
            style: TextStyle(
              fontSize: 20
            ),),
          ),
    value: value
          );
          }
          ).toList(),
           onChanged:(val)
           {
              setState(() {
                positionStart = val;
    
              });
           
           }
           
           ),
  ),
),



Padding(
  padding: const EdgeInsets.all(25),
  child:   Card(
   child: 
    Container(
      height: MediaQuery.of(context).size.height/4,
      width: MediaQuery.of(context).size.width/1.5,
      child:
      
      (_image == null)?
      Stack(
        children: <Widget>[

          
          Positioned(
            top:30,
            left: 65,
                      child: Icon(Icons.cloud_upload,
            size: 80,),
          ),

          Positioned(
            top:80,
            left:100,
                      child: InkWell(
                        onTap: ()
                        {
                          getImage();
                        },
                                              child: Card(
              child: Container(
                height: 40,
                width: 150,
                child: Center(child: Text('Upload photo')),
              ),
            ),
                      ),
          )
        ],
      ):
      Image.file(_image) 
      
    )
  ),
),

 Padding(
                 padding: const EdgeInsets.only(top:25),
                 child: GestureDetector(
                                  child: Card(
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(2)
                         
                     ),
                     color: Colors.brown,
                     child: Container(
                         height: MediaQuery.of(context).size.height/18,
                         width: MediaQuery.of(context).size.width/4,
                         child: Center(child: Text("Sign Up",
                         style: TextStyle(
                           fontSize: 20,
                           color: Colors.white
                         ),
                         )),
                     ),
                   ),
                   onTap :() 
                   {
                     registerUser(context);
                   },
                 ),
               ),
    ],
  );
  
}

changeSelectedValue(int value)
{
  setState(() {
    
    selectedValue = value;
  });
}


Future  getImage()
async
{
 final ImagePicker picker = ImagePicker();

  var currentImage = await picker.getImage(source: ImageSource.gallery); 
  if(currentImage != null)
  {
  setState(() {
 
    _image = File(currentImage.path);
  });
  }

}
 
Future registerUser(BuildContext context)
async
{
  String pathToPostCharacteristics = 'http://192.168.10.26:8000/registration/set_profile_picture/';
  String pathToPostImage = 'http://192.168.10.26:8000/organise_matches/set_characteristics/';
  bool rightFoot;
  bool leftFoot;

  if(selectedValue == 1)
  {
    leftFoot = true;
    rightFoot = false;
  }
  else
  {
    leftFoot = false;
    rightFoot = true;
  }
try{
  var response = http.MultipartRequest('POST',Uri.parse(pathToPostImage));
  response.files.add(await http.MultipartFile.fromPath
  ('profile_picture',_image.path)
  );
  response.fields['user_id'] = userId.toString();
  
  var result = await response.send();

  if(result.statusCode == 200)
  {
    var simpleResponse = await http.post(pathToPostCharacteristics,
    headers: <String,String>
    {
      'Content-Type':'application/json',
      'Authorization':'Token ' +  Authorization 
      
    },
body: jsonEncode(<String,dynamic>
{
  'position':selectedPosition,
  'goal_keeper':goalKeeper,
  'right_foot':rightFoot,
  'left_foot':leftFoot,
  'user_id':userId,
  'Authorization':Authorization
}
)
    );
  if(simpleResponse.statusCode == 200)
  {
      Navigator.of(context).pushNamedAndRemoveUntil(('/'), (route) => false);
  }
  else if(simpleResponse.statusCode !=200)
  {
    return showDialog(context: context
    ,
    builder: ((context)
    {
      return AlertDialog(
          title: Text('response'),
          content: Text('could not upload characteristics but account created'),
          actions: <Widget>[
             GestureDetector(
                    onTap: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(('/'), (route) => false);

                    },
                                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)

                      ),
                      color: Colors.blue,
                      child: Container(
                        height :30,
                        width : 130,
                        child: Center(child: Text('OK')),

                      ),
                    ),
                  ),
          ],

      );
    }
    )
    );
  }
 if(result.statusCode != 200)
  {
 return showDialog(context: context
    ,
    builder: ((context)
    {
      return AlertDialog(
          title: Text('response'),
          content: Text('could not upload characteristics but account created'),
          

      );
    }
    )
    );
  }


  }
}
catch(e)
{
  ErrorConnecting.ConnectingIssue(context);
}

}

}