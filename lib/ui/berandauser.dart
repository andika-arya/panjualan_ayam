import 'package:flutter/material.dart';

class BerandaUser extends StatelessWidget {

  BerandaUser({this.username, this.photo});
  final String username;
  final String photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome User"),
      ),

      body: Column(
        children: <Widget>[
          Text(
            'Hallo $username',
            style: TextStyle(fontSize: 20.0),
          ),

          RaisedButton(
            child: Text("Logout"),
            onPressed: (){
              Navigator.pushReplacementNamed(context, '/MyHomePage');
            },
          )
        ],
      ),
    );
  }
}