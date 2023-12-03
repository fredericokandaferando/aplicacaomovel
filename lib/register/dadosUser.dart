import 'dart:async';
import 'dart:convert';
import 'package:aplicacaomovel/valores/shered_preference.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aplicacaomovel/register/User.dart';
import 'package:aplicacaomovel/valores/shered_preference.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  Future<User> fetchUser(String email) async {
    final response = await http.get(Uri.parse(MySharedPreferences.ip+'/user/$email'));
    print(response.body); // For debugging purposes, check the response body
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar informações do usuário');
    }
  }

  @override
  Widget build(BuildContext context) {
    String email = MySharedPreferences.useremail;
   
    return FutureBuilder<User>(
      future: fetchUser(email),
      
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          // If there's no data, handle it accordingly (optional)
          return Text('No data available');
        } else {
          User user = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text('Informações do Usuario'),
              backgroundColor: const Color.fromARGB(255, 131, 3, 131),

            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Nome: ${user.name}',style: TextStyle(fontSize: 24,color: Color.fromARGB(255, 135, 3, 135)),),
                    Text('Email:${user.email}',style: TextStyle(fontSize: 24,color: Color.fromARGB(255, 135, 3, 135)),),
                  Text(
                    'Ponto: ${user.ponto}pts',                  
                    style: TextStyle(fontSize: 24,color: Color.fromARGB(255, 135, 3, 135)),
                  ),
                  Text('Bike: ${user.ponto}',style: TextStyle(fontSize: 24,color: Color.fromARGB(255, 135, 3, 135)),)

                ],
              ),
            ),
          );
        }
      },
    );
  }
}
