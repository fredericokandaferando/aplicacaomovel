import 'package:flutter/material.dart';
import 'package:aplicacaomovel/register/home_usuario.dart';
import 'package:aplicacaomovel/main.dart';
Drawer getHomeDrawer(BuildContext context){
return Drawer(
 
  child: ListView(
    padding: EdgeInsets.zero,
    children:[
      const UserAccountsDrawerHeader(
        decoration: BoxDecoration(color:Color.fromARGB(255, 131, 3, 131)),
        accountName :Text("Frederico Kanda"),
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
          "Localizar Estação"
        ),
        
        onTap: (){
          // ignore: prefer_const_constructors
           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>home_usuarioRegister()),) ;
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
        leading: const Icon(Icons.balance,color:Color.fromARGB(255, 131, 3, 131)
        ),
        title: const Text(
          "Consultar Saldo"
        ),
          onTap: (){
          // ignore: prefer_const_constructors
           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>home_usuarioRegister()),) ;
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