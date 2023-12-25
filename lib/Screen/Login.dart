

import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../Database/Database.dart';
import '../Model/usermodel.dart';
import 'Home.dart';
import 'Signup.dart';


class Login extends StatelessWidget {
  TextEditingController uname = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Center(
            child: Text(
              "Login Page",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: uname,
              decoration: const InputDecoration(
                  hintText: "Username", border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: pass,
              decoration: const InputDecoration(
                  hintText: "Password", border: OutlineInputBorder()),
            ),
          ),
          ElevatedButton(onPressed: () async {
            final userlist = await DBFunction.instance.getUser();
            findUser(userlist);
          }, child: const Text("Login")),
          TextButton(
              onPressed: () {
                Get.to(Registration());
              },
              child: const Text("Not a User?.. Register Here!!"))
        ],
      ),
    );
  }

  Future<void> findUser(List<User> userlist) async{
    final email    = uname.text.trim();
    final password = pass.text.trim();
    bool userFound = false;
    final validate = await validateLogin(email,password);

    if(validate == true){
      await Future.forEach(userlist, (user) {
        if(user.email == email  && user.password == password){
          userFound = true;
        }else{
          userFound = false;
        }
      });
      if(userFound == true){
        Get.offAll(()=> Homeee(email :email));
        Get.snackbar("Success", "Login Success",
            backgroundColor: Colors.green);
      }else{
        Get.snackbar("Error", "Incorrect email/Password",
            backgroundColor: Colors.red);
      }
    }
  }
  Future<bool> validateLogin(String email, String password) async {
    if(email != '' && password != ''){
      return true;
    }else{
      Get.snackbar("Error", "Fields cannot be empty",backgroundColor: Colors.red);
      return false;
    }

  }
}