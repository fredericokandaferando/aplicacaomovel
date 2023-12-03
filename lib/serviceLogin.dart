import 'dart:async';
import 'dart:convert';
import 'package:aplicacaomovel/valores/shered_preference.dart';
import 'package:http/http.dart' as http;
import 'package:aplicacaomovel/home_widgets/home_pricipalpage.dart';
import 'package:flutter/material.dart';
import 'package:aplicacaomovel/main.dart';
class Services {
  
Future<http.Response>loginUser(String email,String address,BuildContext context) async{
  //header
  Map<String, String> headers = {"Content-Type": "application/json"}; 
  //body
  Map data={
   'address':address,
   'email':email,
  };

var uri = Uri.parse( MySharedPreferences.ip+"/estacao/login");
  
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
            Icon(Icons.error, color: Colors.red),
            SizedBox(width: 8),
            Text('Aviso'),
          ],
        ),
        content: Text('Credencias ivalida'),
        actions: [
         
          TextButton(
            onPressed: () {
              //
              // Ação quando o botão "OK" é pressionado             
                Navigator.pop(context, MaterialPageRoute(
                 builder: (context) => const HomePage(),
          ),);
                
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

}