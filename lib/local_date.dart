import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

const stringkey ="stringkey";
class localDate{
  static salvarString(String valor)async{
    SharedPreferences shared = await SharedPreferences.getInstance();

    shared.setString(stringkey, valor);
  }
  static salvarListaString(List<String>lista)async{
    SharedPreferences shared = await SharedPreferences.getInstance();
   await shared.setStringList(stringkey, lista);
    debugPrint(lista.toString());
  }
  static Future<String>getString() async{
     SharedPreferences shared = await SharedPreferences.getInstance();

     return shared.getString(stringkey)??'Vazio';
  }

  static Future<List>getStringList() async{
     SharedPreferences shared = await SharedPreferences.getInstance();
     
     return shared.getStringList(stringkey)??[];
  }

}