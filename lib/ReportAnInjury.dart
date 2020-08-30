import 'dart:convert';
import 'package:sportsbnb/ErrorConnecting.dart';
import 'package:sportsbnb/Loading.dart' as Loading;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:sportsbnb/DatabaseHelper.dart';
import 'package:sportsbnb/LoginData.dart';
import 'package:http/http.dart' as http;
import 'package:sportsbnb/NotAuthorizaed.dart';
import 'package:sportsbnb/UserCredentials.dart';
import 'package:sportsbnb/EnglishLanguage.dart'as Language;

class ReportAnInjury extends StatefulWidget
{
  
  @override
  State<StatefulWidget> createState() {
 return ReportAnInjuryState();
  }
  
}

class ReportAnInjuryState extends State<ReportAnInjury>
{
  List<String> reasons = [Language.Language.holidays,Language.Language.sick,Language.Language.injred
  ,Language.Language.buinessTravel
  ,Language.Language.other];
  String selectedReason = Language.Language.holidays;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateTime toDate;
  DateTime fromDate;
  final _formKey = GlobalKey<FormState>();
TextEditingController titleController = TextEditingController();
  bool report = false;


  DatabaseHelper instance;




  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(Language.Language.reportAnUnavalibility),

      ),
      body: getStack(),
    );
 
  }
 Widget getStack()
 {
  return Stack(
    children: <Widget>[


      Positioned(
        top:55,
        left: MediaQuery.of(context).size.width/10,
              child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            topRight: Radius.circular(100)
            
          ),
          child: Container(
color: Theme.of(context).primaryColor,
// decoration: BoxDecoration(
  
//   // gradient: LinearGradient(
//   //   begin: Alignment.bottomLeft,
//   //   colors: [Colors.brown,Colors.brown.shade200])

// ),
height: 80,
width: 379,

          ),
        ),
      ),
      Positioned
      (
        top: 50,
        left: MediaQuery.of(context).size.width/7.5,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15)
                  ,
                  topLeft: Radius.circular(15)
                  ),
                  

                ),
                child: Container(
                  height: 75,
                  width: 300,
                  child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: <Widget>[
                    Text(Language.Language.unavailable,
                    style: TextStyle(
                      fontSize: 25
                    ),
                    ),
            theCustomSwitch(),


          ],),
                ),
        ),
      ),
// (report == true)?
AnimatedPositioned(child: ClipRRect(
  borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(15),
    bottomRight: Radius.circular(15)
  ),
  child:   Container(
    height: 270,
    width: 365,
    color: Theme.of(context).primaryColor,
  // decoration: BoxDecoration(
  //   gradient: LinearGradient(colors: 
  //   [Colors.brown,Colors.brown.shade200])
  // ),
  ),
)
,
  top:(report)?130:-270,
        left: MediaQuery.of(context).size.width/7.5,
          

 duration: Duration(milliseconds: 300))
,

  // (report == true)?
  AnimatedPositioned(
    
    child: customColumn(context), duration: Duration(milliseconds: 300),
    top: (report)?MediaQuery.of(context).size.height/7: -MediaQuery.of(context).size.height,
        left: MediaQuery.of(context).size.width/7.5,

    )
    ],
  );
 }


 Widget theCustomSwitch()
 {
   return ClipRRect(
     borderRadius: BorderRadius.only(
       topLeft: Radius.circular(30),
       bottomRight: Radius.circular(30)
     ),
     child: Container(
       height: 20,
       width: 45,
       child: CupertinoSwitch(value: report
       , onChanged: (bool value)
       {
         setState(() {
          report = value;
           
         });
       },
    
       activeColor: Theme.of(context).primaryColor,
    trackColor: Colors.black,
    
       ),
     ),
   );
 } 


 Widget customColumn(BuildContext context)
 {

    return Form(
      key: _formKey,
      
          child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10)

        ),
        height: MediaQuery.of(context).size.height/3,
        width: MediaQuery.of(context).size.width/1.4,
        // color: Colors.red,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10)

            )
          ),
                child: Column(
            children: <Widget>[
               
                CustomRow(Language.Language.unavaibalbeFrom, 'from',Language.Language.tapToSetDate),

                CustomRow(Language.Language.unavailableTo, 'to',Language.Language.tapToSetDate),


                customTextFormField(),

                customButton()
            ],
          ),
        ),
      ),
    );
 }


 Widget CustomRow(String title,String toShow,String extra)
 {
   return Card(
        child: InkWell(
       onTap:()
       {
         if(toShow =='to' )
         {
           toDateDatePicker();
         }
         else if(toShow == 'from')
         {
           fromDateDatePicker();
         }
       }
       ,
          child: Container(
            height: 50,
            
            child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width/6,
                  // color: Colors.red,
                                  child: Text(title,
                  style: TextStyle(fontSize: 18) 
                  
                  ,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:40),
                child: (toShow == 'to')?(toDate == null)? Text(extra):
                Text(dateFormat.format(toDate),
                 style: TextStyle(fontSize: 15) 
                ):
                (toShow == 'from')?(fromDate == null)?Text(extra):
                Text(dateFormat.format(fromDate)):
                Container()                
                
              )
 
            ],
       ),
          ),
     ),
   );
 }

 Widget customTextFormField()
 {
return  Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Card(

      child: Container(
      height: MediaQuery.of(context).size.height/15,
      child:   DropdownButton(
        value: selectedReason,
        items: reasons.map((String val)
        {
            return DropdownMenuItem(
              value: val,
              child: Text(
                val,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color:Colors.black
                ),
              ));
        }
        ).toList(),
         onChanged:(String newValue)
         {
           setState(() {
             selectedReason  = newValue;
           });
           if(selectedReason == reasons[4])
           {
          selectOther();
           }
         }
         )
      // TextFormField(
      // obscureText: false,
      
      // decoration: InputDecoration(
      // border:OutlineInputBorder(
      // //  borderSide: new BorderSide(color: Colors.deepOrange),
      // borderRadius: BorderRadius.circular(20)
      // ),
      
      // labelText: Language.Language.reason,
      
      // ),
      // controller: titleController,
      // validator: (value)
      // {
      // if(value.isEmpty)
      // {
      // return Language.Language.enterReason;
      // }
      // },
      // ),
    ),
  ),
);
 }

Widget customButton()
 {
   return Padding(
     padding: const EdgeInsets.only(top:15,left: 150),
     child: GestureDetector(
       onTap: ()
       {
         postUnavailability(context);
       }
       ,
            child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          color: Theme.of(context).bottomAppBarColor,
          child:Container(
            height: 30,
            width: 75,
            child: Center(child: Text(Language.Language.save,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17
            ),
            ),
            ),
          ),
       ),
     ),
   );
   }

  Future fromDateDatePicker()
                async
                {
                var unavailableDateFrom = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate:DateTime(2100));
                if(unavailableDateFrom!= null)
                {
                setState(() {
                  // fromDate = DateTime(unavailableDateFrom.year,unavailableDateFrom.month,unavailableDateFrom.day,DateTime.now().hour,DateTime.now().minute);
                  fromDate = DateTime(unavailableDateFrom.year,unavailableDateFrom.month,unavailableDateFrom.day);


                });
                }}





              Future toDateDatePicker() 
                async
                {
                var unavailableDateTo = await showDatePicker(context: context, initialDate: DateTime(fromDate.year,fromDate.month,fromDate.day+1), firstDate: DateTime.now(), lastDate:DateTime(2100));
                if(unavailableDateTo!=null)
                {
                setState(() {
                  // toDate =  DateTime(unavailableDateTo.year,unavailableDateTo.month,unavailableDateTo.day,DateTime.now().hour,DateTime.now().minute);
                  toDate =  DateTime(unavailableDateTo.year,unavailableDateTo.month,unavailableDateTo.day);
                    
                    debugPrint(toDate.toString());
                });
                }
                }

Future postUnavailability(BuildContext context)

async
{
  String pathToPostAnInjury = 'http://192.168.10.26:8000/period_of_unavail/post_unavailability/';
  if(_formKey.currentState.validate())
  {
  Loading.ShowLoadingDialog.showLoaderDialog(context);
    if(toDate != null && fromDate !=null)
    {
      try{
       var response =await http.post(pathToPostAnInjury,
       headers: <String,String>
       {
         'Content-Type':'application/json',
         'Authorization':'Token '+UserCredentials.credentialsInstance.getTokenOfUser       },
       body: jsonEncode(<String,dynamic> 
       {
        'to_date':dateFormat.format(toDate),
        'from_date':dateFormat.format(fromDate),
        // 'to_date':toDate,
        // 'from_date':fromDate,
        
        
        'user_id':UserCredentials.credentialsInstance.getIdOfUser  ,
        'reason':selectedReason
        }
       )
       );
     
       if(response.statusCode == 200)
       {
         Navigator.pop(context);
         statusOk(Language.Language.response,Language.Language.unavailabilityReported,context);

       }
       else if(response.statusCode == 401)
{
  NotAuthorizaed.showNotAuthorizedAlert(context);
}
       else if(response.statusCode !=200 && response.statusCode != 401)
       {
         Navigator.pop(context);
         statusOk(Language.Language.response,Language.Language.someErrorOccured,context);
       }
}
catch(e)
{
  Navigator.pop(context);
  ErrorConnecting.ConnectingIssue(context);
}    
    }
    

  }


}


   statusOk(String title,String reponse,BuildContext context)
  {
 showDialog(context: (context),
             builder: (context)
             {
                return AlertDialog(
                    title: Text((title)),
                    content: Text(reponse),
                );
             });
  }

selectOther()
{
  showDialog(context: context,
        builder:(context)
        {
      return AlertDialog(
      title: Text(Language.Language.reason),
      actions: <Widget>[
      Form(
      // key: formKey,
      child:
      Container(
      height: MediaQuery.of(context).size.height/6,
      width: 250,
      child: Center(
      child: Column(
      children: <Widget>[
          // getTextForm(this.firstNameController,Language.Language.firstName),
          // SizedBox(height:10),
          // getTextForm(this.lastNameController,Language.Language.lastName),
          // SizedBox(height:10),
      
          getTextForm(this.titleController,Language.Language.reason),
          SizedBox(height:10),
      
      getSubmitButton()
          // getTextForm(this.emailController,Language.Language.email),
          // SizedBox(height:10),
      
      
      ]
      )
      )
      )
      )
      ]
      );
        }
        );

}
 Widget getSubmitButton()
          
          {
            return InkWell(
        
        onTap: ()
       async
        {
          setState(() {
            reasons.add(titleController.text.toLowerCase());
            selectedReason  = titleController.text.toString();

          });
          Navigator.pop(context);
          
            }
        
        ,
        splashColor: Colors.green.shade50,
                                                        child: Card(
          color: Theme.of(context).buttonColor,
          child: Container(
            height:30,
            width: 200,
                    child: Center(child: Text(Language.Language.save,
                    style: TextStyle(
                      color: Colors.white
                    ),
                    )),
          )
          ,
        ),
      );
          
          }
           Widget getTextForm(TextEditingController customController , String s)
          {
              return TextFormField(
      obscureText: false,
      
      decoration: InputDecoration(
      border:OutlineInputBorder(
      //  borderSide: new BorderSide(color: Colors.deepOrange),
      borderRadius: BorderRadius.circular(20)
      ),
      
      labelText: s,
      
      ),
      
      controller: customController,
      validator: (value)
      {
      if(value.isEmpty)
      {
      return Language.Language.reequired;
      }
      },
      );
      
      
          }

}


