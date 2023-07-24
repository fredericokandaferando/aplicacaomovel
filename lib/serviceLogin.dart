import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aplicacaomovel/home_widgets/home_pricipalpage.dart';
import 'package:flutter/material.dart';
class Services {
Future<http.Response>loginUser(String email,String address,BuildContext context) async{
  //header
  Map<String, String> headers = {"Content-Type": "application/json"}; 
  //body
  Map data={
   'address':address,
   'email':email,
  };
 var uri= Uri.parse("http://localhost:8084/login");

//convert the above data into json
  var body=json.encode(data);
  var response = await http.post(uri, headers: headers, body:body);

  print(response.body);
  
  
if(response.statusCode==200){
   Navigator.push(context,
       MaterialPageRoute(
     builder: (context) => const home_pricipalpage(),
          ),
        );
}
 

  return response;
}
}