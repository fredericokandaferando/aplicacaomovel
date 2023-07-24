import 'package:flutter/material.dart';


AppBar getHomeAppBar(){

return AppBar(
title:const Text("Bem-Vindo ao BikeShared"),
centerTitle:true,
backgroundColor: const Color.fromARGB(255, 131, 3, 131),
actions: [

  IconButton( onPressed: () {  },
  icon:const Icon(Icons.more_vert_rounded
  ) ,
 
  color: Colors.white,
  ),
   
],
);
}