import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aplicacaomovel/home_widgets/home_pricipalpage.dart';
import 'package:flutter/material.dart';
import 'package:aplicacaomovel/main.dart';

import '../valores/shered_preference.dart';
class ServicesListaUsuario {

 late final  String? name;
 late final  String?  email;

 ServicesListaUsuario({required this.name, required this.email,});

  factory  ServicesListaUsuario.fromJson(Map<String, dynamic> json) {
    return  ServicesListaUsuario(
       name: json['name'],
      email: json['email'],
     
    );
  }
}
Future<List<ServicesListaUsuario>>fetchUsers() async{

  //body
final response = await http.get(Uri.parse(MySharedPreferences.ip+"/estacao/listaUsuarios"));
print(response.body);
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.map((user) => ServicesListaUsuario.fromJson(user)).toList();
  } else {
    throw Exception('Falha ao carregar os usuários');
  }
 
}
