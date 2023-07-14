import 'package:flutter/material.dart';
import 'package:aplicacaomovel/service.dart';
class home_usuarioRegister extends StatefulWidget {
  const home_usuarioRegister({super.key});

  @override
  State<home_usuarioRegister> createState() => _home_usuarioRegisterState();
}


class _home_usuarioRegisterState extends State<home_usuarioRegister> {
  TextEditingController nomeController = TextEditingController();
   TextEditingController emailController = TextEditingController();
    TextEditingController senhaController = TextEditingController();

    //create the service class object
    Service service = Service();
     
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
     
       appBar: AppBar(
        title:Text('Cadastra-te no BikeShared'),
        centerTitle:true,
         backgroundColor: Color.fromARGB(255, 135, 3, 135),
       ),
      body: Container(
        padding:EdgeInsets.all(20),
        child: ListView(
          children: [
            
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                border:OutlineInputBorder(
      
                ),
                hintText: 'Digite o Nome',
                    hintStyle:TextStyle(color: Color.fromARGB(255, 135, 3, 135)),
              ),
            ),
           
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailController ,
              decoration: InputDecoration(
                border:OutlineInputBorder(
      
                ),
                hintText: 'Digite o Email',
                    hintStyle:TextStyle(color: Color.fromARGB(255, 135, 3, 135)),
              ),
            ),
         
            SizedBox(
              height: 20,
            ),
            TextField(
               obscureText: true,
              controller: senhaController,
              decoration: InputDecoration(
                border:OutlineInputBorder(
      
                ),
                hintText: 'Digite a Senha',
                hintStyle:TextStyle(color: Color.fromARGB(255, 135, 3, 135)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
           ElevatedButton(onPressed: (){           
            service.saveUser(nomeController.text, 
            emailController.text,
             senhaController.text, 
             10, 
             2);
           },
          
           child:Text('Registar',
         style:TextStyle(
          fontSize: 20,
         )
           ) ,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 135, 3, 135)
          ),
           )
           
          ],
      
         
          ),
      ),


    );
  }
}