import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsPage extends StatelessWidget {

  String title;
  String desc;
  String createdAt;
  DetailsPage({required this.title, required this.desc,required this.createdAt});
  
  
  @override
  Widget build(BuildContext context) {
    DateTime time=DateTime.fromMicrosecondsSinceEpoch(int.parse(createdAt));
    DateFormat df=DateFormat.yMMMEd();

    return Scaffold(

      appBar: AppBar(

        title: Text("Details"),),

      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Text(title,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text(df.format(time),style: TextStyle(color: Colors.blueGrey),),
            Divider(),
            SizedBox(height: 15,),
            SingleChildScrollView(child: Text(desc,style: TextStyle(fontSize: 16),)),

          ],

        ),
      ),

    );
  }
}
