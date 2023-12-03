import 'package:aplicacaomovel/register/user.dart';
import 'package:flutter/material.dart';
import 'package:aplicacaomovel/register/home_usuario.dart';
import 'package:aplicacaomovel/main.dart';
import 'package:aplicacaomovel/register/googlemap.dart';
import 'package:aplicacaomovel/register/dadosUser.dart';
import 'package:aplicacaomovel/Estacao/telaListaEstacao.dart';
import 'package:aplicacaomovel/service.dart';
import 'package:aplicacaomovel/register/ListaUsuario.dart';
Drawer getHomeDrawer(BuildContext context, User user){
  
return Drawer(
 
  child: ListView(
    padding: EdgeInsets.zero,
    children:[
      const UserAccountsDrawerHeader(
        decoration: BoxDecoration(color:Color.fromARGB(255, 131, 3, 131)),
        accountName :Text('Frederico Kanda '),
        accountEmail: Text("frederico@gmail.com"),
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
          "Localizar Estação {}"
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
           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>home_usuarioRegister()),) ;
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
           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>home_usuarioRegister()),) ;
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
);

}
