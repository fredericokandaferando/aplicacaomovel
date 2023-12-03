import 'dart:async';
import 'dart:convert';
import 'package:aplicacaomovel/valores/shered_preference.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home_widgets/home_pricipalpage.dart';
class Service{
Future<http.Response>saveUser(String name,String email,String address,int  ponto,int  id_acesso,BuildContext context) async{
 //header
  Map<String, String> headers = {"Content-Type": "application/json"}; 
  //body
  Map data={
   'address':'$address',
   'email':'$email',
   'id_acesso':'$id_acesso',
   'name': '$name',
   'ponto':'$ponto'
  };
 var uri = Uri.parse(MySharedPreferences.ip+"/estacao/Register");
//convert the above data into json
  var body=json.encode(data);
  var response = await http.post(uri, headers: headers, body:body);

  print(response.body);
if(response.statusCode==200){
  
   
  Navigator.push(context,
       MaterialPageRoute(
     builder: (context) => const Userlog(),
          ),
        );
}else if (response.statusCode==401){
   
    _showMyDialog(context);
    
    
}else{
  print('Erro durante o login');
}

  return response;
}
void _showMyDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(
          children: [
            Icon(Icons.add, color: Colors.red),
            SizedBox(width: 8),
            Text(''),
          ],
        ),
        content: Text('Usuario adicionado Com Sucesso!'),
        actions: [
         
          TextButton(
            onPressed: () {
              //
              // Ação quando o botão "OK" é pressionado             
                Navigator.pop(context);
                
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
}