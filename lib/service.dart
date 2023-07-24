
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;



class Service{

Future<http.Response>saveUser(String name,String email,String address,int  ponto,int  id_acesso) async{

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
 var uri= Uri.parse("http://localhost:8084/Register");

//convert the above data into json
  var body=json.encode(data);
  var response = await http.post(uri, headers: headers, body:body);

  print(response.body);


  return response;
}
}
