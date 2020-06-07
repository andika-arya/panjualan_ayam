import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:penjualan_ayam/ui/berandaadmin.dart';
import 'package:penjualan_ayam/ui/berandauser.dart';
import 'package:http/http.dart' as http;
import 'dart:async';


void main() => runApp(MyApp());

String username='';
String photo='';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/BerandaAdmin': (BuildContext context)=> new BerandaAdmin(username: username, photo: photo),
        '/BerandaUser': (BuildContext context)=> new BerandaUser(username: username, photo: photo),
        '/MyHomePage': (BuildContext context)=> new MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController usr = new TextEditingController();
  TextEditingController psw = new TextEditingController();

  String msg='';

  // Future<List> _login() async {
  Future<String> _login() async {
    final response = await http.post("http://192.168.43.58/penjualanayam/login/login_api", body: {
      "username": usr.text,
      "password": psw.text,
    });

    var datauser = json.decode(response.body);

    // print(datauser);
    

    if(datauser.length==0){
      setState(() {
        msg = datauser['msg'];
      });
    } else {

      if(datauser['level']=="1"){
        // print("welcome admin");
        Navigator.pushReplacementNamed(context, '/BerandaAdmin');

      } else if(datauser['level']=="2"){
        // print("welcome member");
        Navigator.pushReplacementNamed(context, '/BerandaUser');
      }

      setState(() {
        username = datauser['nama'];
        photo = datauser['photo'];
      });
      
    // menyimpan data user ke session / SharedPreferences
    
    }

    // return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: new BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/appimages/bg_login.jpg'),
            fit: BoxFit.cover,
          )
        ),
        child: new ListView(
          children: <Widget>[
            new Container(
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.only(top: 30),
                  ),
                  new Image.asset(
                    'assets/appimages/login.png',
                    width: 150,
                  ),
                  new Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        new TextField(
                          controller: usr,
                          decoration: InputDecoration(
                            hintText: "Username",
                            labelText: "Username",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          ),
                        ),

                        new Padding(
                          padding: EdgeInsets.only(top: 20),
                        ),

                        new TextField(
                          obscureText: true,
                          controller: psw,
                          decoration: InputDecoration(
                            hintText: "Password",
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          ),
                        ),

                        new Padding(
                          padding: EdgeInsets.only(top: 20),
                        ),

                        new RaisedButton(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Icon(Icons.verified_user),
                              new Text(" Login")
                            ],
                          ),
                          color: Colors.blue,
                          onPressed: () {
                            _login();
                          },
                        ),
                        
                        new Padding(
                          padding: EdgeInsets.only(top: 20),
                        ),

                        Text(
                          msg,
                          style: new TextStyle(fontSize: 20.0,color: Colors.red),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
