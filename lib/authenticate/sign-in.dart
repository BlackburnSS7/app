import 'file:///C:/Users/khaml/flutter_projects/first_app/lib/widgets/main-menu.dart';
import 'package:first_app/service/auth.dart';
import 'package:flutter/material.dart';



class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  int test=0;

  final AuthService _authService=AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],

      body:Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
        child: Center(
          child: RaisedButton(color: Colors.deepOrange,
            child: Text("Sign in Anonymous",style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold),),
            onPressed: () async {
              dynamic result =await _authService.signInAnon();
                  if(result==null){
                    print('error signing in');
                  }
                  else {
                    print("sign in");
                    print(result.uid);
                    Navigator.push(context, MaterialPageRoute(builder:(context)=>MainMenu()));
                  }
            },
          ),
        ),
      )
    );
  }
}
