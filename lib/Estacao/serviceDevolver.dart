
import 'package:aplicacaomovel/Estacao/telaDevolverBina.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import '../valores/shered_preference.dart';

Future<void> devolverBicicleta(String userEmail, int stationId,BuildContext context) async {
  final String url = MySharedPreferences.ip + "/estacao/$userEmail/bikedevolver/$stationId";

  final response = await http.post(Uri.parse(url));
  print(response.body);
if (response.body =="Bicicleta Devolvida com sucesso!") {
       exibirMensagem( "Bicicleta Devolvida com sucesso!",context);
    } else if (response.body=="Usuário não encontrado.") {
       exibirMensagem( "Usuário não encontrado.",context);
    } else if (response.body=="Você não  possui uma bicicleta levantada.") {
       exibirMensagem("Você não  possui uma bicicleta levantada.",context);
    } else if (response.body=="Você já possui uma bicicleta levantada.") {
       exibirMensagem( "Você já possui uma bicicleta levantada.",context);
    } else if (response.body=="Estação não encontrada.") {
      exibirMensagem("Estação não encontrada.",context);
    } else if (response.body=="Não há bicicletas disponíveis nesta estação.") {
      exibirMensagem("Não há bicicletas disponíveis nesta estação.",context);
    }else{
      print("erro ao levantar bicicleta");
    }
}

void exibirMensagem(String mensagem, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Mensagem'),
        content: Text(mensagem),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ListaEstacaoDevolver()));
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
