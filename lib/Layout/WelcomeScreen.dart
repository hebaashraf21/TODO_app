import 'package:flutter/material.dart';
import 'package:todo_app/Layout/layout.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 60,),
          Expanded(
            flex: 2,
            child: Padding(padding: EdgeInsets.all(25),
            child: Container(
              child: Image(image: AssetImage('assets/TODO.png'))
              //child: CircleAvatar(radius: 170,backgroundImage: NetworkImage("https://drive.google.com/file/d/1Ian3soj0fv152f8XlsyPVXlGFa9bkdjr/view?usp=sharing"),),
            ),)
          ),
          SizedBox(height: 50,),
          Text("To-Do list",style: TextStyle(color: Color.fromARGB(255, 7, 26, 17),fontSize: 35,fontWeight: FontWeight.bold),),
          SizedBox(height: 50,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                
                FittedBox(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return layout();
                        },
                      ));
                    },
                    child: Container(
                      width: 200,
                      margin: EdgeInsets.only(bottom: 25),
                      padding:
                          EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.deepOrange,
                      ),
   
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          
                          Text(
                            "START",
                            style: Theme.of(context).textTheme.button?.copyWith(
                                  color: Color.fromARGB(255, 245, 244, 244),
                                ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}