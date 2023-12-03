import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:aplicacaomovel/register/user.dart';
import 'package:aplicacaomovel/register/trajectoria.dart';
import 'package:aplicacaomovel/home_widgets/home_appbar.dart';
import 'package:aplicacaomovel/register/home_usuario.dart';
import 'package:aplicacaomovel/main.dart';
import 'package:aplicacaomovel/register/googlemap.dart';
import 'package:aplicacaomovel/register/dadosUser.dart';
import 'package:aplicacaomovel/Estacao/telaListaEstacao.dart';

import 'package:aplicacaomovel/register/ListaUsuario.dart';
import 'package:aplicacaomovel/register/geolo_page.dart';
import '../valores/shered_preference.dart';
class Userlog extends StatefulWidget {
  const Userlog ({super.key});

  @override
  State<Userlog > createState() => UserlogState();
}
class UserlogState extends State<Userlog> {
  Future<User> fetchUser(String email) async {
    final response = await http.get(Uri.parse(MySharedPreferences.ip+'/estacao/user/$email'));
    print(response.body); // For debugging purposes, check the response body
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar informações do usuário');
    }
  }
  Widget build(BuildContext context){
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
   appBar: getHomeAppBar(),
   //floatingActionButton: getHomeFab(),
   body: Container(),
     drawer: Drawer(
     child: Column(
    
    children:[
       UserAccountsDrawerHeader(
        decoration: BoxDecoration(color:Color.fromARGB(255, 131, 3, 131)),
        accountName :Text('${user.name} '),
        accountEmail: Text('${user.email}'),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(
            "BS",
            style: TextStyle(color:Color.fromARGB(255, 131, 3, 131),fontSize: 40),
            
          ),
          
        ),
      ) ,
      
      ListTile(
        leading: const Icon(Icons.search,color:Color.fromARGB(255, 131, 3, 131)
        ),
        title: const Text(
          "Localizar Estação"
        ),
        
        onTap: (){
          // ignore: prefer_const_constructors
           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GoogleMapScreen()),) ;
        },
      )  , 
       
      ListTile(
        leading: const Icon(Icons.search,color:Color.fromARGB(255, 131, 3, 131)
        ),
        title: const Text(
          "Listar Estações"
        ),
        
        onTap: (){
          // ignore: prefer_const_constructors
           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ListaEstacao()),) ;
        },
      )  ,   
      
       ListTile(
        leading: const Icon(Icons.bike_scooter_rounded,color:Color.fromARGB(255, 131, 3, 131)
        ),
        title: const Text(
          "Levantar Bicicleta"
        ),
          onTap: (){
          // ignore: prefer_const_constructors
   
        },
       ),
        ListTile(
        leading: const Icon(Icons.bike_scooter_rounded,color:Color.fromARGB(255, 131, 3, 131)
        ),
        title: const Text(
          "Devolver Bicicleta"
        ),
          onTap: (){
          // ignore: prefer_const_constructors
           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>home_usuarioRegister()),) ;
        },
       ),
        ListTile(
        leading: const Icon(Icons.info,color:Color.fromARGB(255, 131, 3, 131)
        ),
        title: const Text(
          "Informações do Usuario"
        ),
          onTap: (){
          // ignore: prefer_const_constructors
           Navigator.of(context).push(MaterialPageRoute(builder: (context)=> UserInfoPage()),) ;
        },
       ),
          ListTile(
        leading: const Icon(Icons.list,color:Color.fromARGB(255, 131, 3, 131)
        ),
        title: const Text(
          "Lista Usuario"
        ),
          onTap: (){
          // ignore: prefer_const_constructors
           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ListaUsuario()),) ;
        },
       ),

        ListTile(
        leading: const Icon(Icons.settings,color:Color.fromARGB(255, 131, 3, 131)
        ),
        title: const Text(
          "Definições"
        ),
          onTap: (){
          // ignore: prefer_const_constructors
           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>home_usuarioRegister()),) ;
        },
        ),

        ListTile(
        leading: const Icon(Icons.info,color:Color.fromARGB(255, 131, 3, 131)
        ),
        title: const Text(
          "Info"
        ),
          onTap: (){
          // ignore: prefer_const_constructors
           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Logalizacao()),) ;
        },
       ),
       
        ListTile(
        leading: const Icon(Icons.arrow_back_sharp,color:Color.fromARGB(255, 131, 3, 131)
        ),
        title: const Text(
          "Sair"
        ),
          onTap: (){
          // ignore: prefer_const_constructors
           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()),) ;
        },
       )
    ],


  ),
     )
  );
}
}
    );
  }
}