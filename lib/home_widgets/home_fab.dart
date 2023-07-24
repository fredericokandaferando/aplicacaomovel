
import 'package:flutter/material.dart';

FloatingActionButton getHomeFab(){

  return FloatingActionButton(onPressed:() {},
   backgroundColor:const Color.fromARGB(255, 131, 3, 131),
  
  child: const Text(
    "+",
         style:TextStyle(fontSize:20),
  )
  );

}