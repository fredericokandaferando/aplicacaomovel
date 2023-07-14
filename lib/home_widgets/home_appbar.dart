import 'package:flutter/material.dart';


AppBar getHomeAppBar(){

return AppBar(
title:Text("Bem-Vindo ao BikeShared"),
centerTitle:true,
backgroundColor: Color.fromARGB(255, 131, 3, 131),
actions: [

  IconButton( onPressed: () {  },
  icon:Icon(Icons.more_vert_rounded
  ) ,
 
  color: Colors.white,
  ),
   
],
);
}