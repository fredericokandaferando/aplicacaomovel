import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aplicacaomovel/home_widgets/home_pricipalpage.dart';
import 'package:flutter/material.dart';
import 'package:aplicacaomovel/main.dart';

import '../valores/shered_preference.dart';
class ServicesEstacao {
 late final  int? id ;
 late final String? estacao;
 late final  double? latitude;
 late final  double? longitude;
 late final  int? capacidate;
 late final int?  premioEmtrega;

 ServicesEstacao({required this.estacao, required this.id,required this.latitude, required this.longitude, required this.capacidate,required this.premioEmtrega});

  factory ServicesEstacao.fromJson(Map<String, dynamic> json) {
    return ServicesEstacao(
      id: json['id'],
      estacao: json['estacao'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      capacidate: json['capacidate'],
      premioEmtrega:json['premioEmtrega']
    );
  }
}
Future<List<ServicesEstacao>>fetchEstacao() async{

  //body
final response = await http.get(Uri.parse(MySharedPreferences.ip+"/estacao/listaEstacao"));
print(response.body);
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.map((estacao) => ServicesEstacao.fromJson(estacao)).toList();
  } else {
    throw Exception('Falha ao carregar as estações');
  }
 
}
