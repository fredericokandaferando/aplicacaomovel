import 'package:flutter/material.dart';
import 'package:aplicacaomovel/service.dart';

import '../valores/shered_preference.dart';
class home_usuarioRegister extends StatefulWidget {
  const home_usuarioRegister({super.key});

  @override
  State<home_usuarioRegister> createState() => _home_usuarioRegisterState();
}


class _home_usuarioRegisterState extends State<home_usuarioRegister> {
  TextEditingController nomeController = TextEditingController();
   TextEditingController emailController = TextEditingController();
    TextEditingController senhaController = TextEditingController();
 final _formKey = GlobalKey<FormState>();
    //create the service class object
    Service service = Service();
     
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
     
       appBar: AppBar(
        title:const Text('Cadastra-te no BikeShared'),
        centerTitle:true,
         backgroundColor: const Color.fromARGB(255, 135, 3, 135),
       ),
      body: Container(
        padding:const EdgeInsets.all(20),
        child:Form(

          key: _formKey,

      
        child: ListView(
          children: [
            
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: nomeController,
              decoration: const InputDecoration(
                border:OutlineInputBorder(
      
                ),
                hintText: 'Nome',
                    hintStyle:TextStyle(color: Color.fromARGB(255, 135, 3, 135)),
              ),
              validator:(nome){
                if(nome==null || nome.isEmpty){
                  return 'Digite o Nome';
                }
                return null;

              }
            ),
           
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: emailController ,
              decoration: const InputDecoration(
                border:OutlineInputBorder(
      
                ),
                hintText: 'Email',
                    hintStyle:TextStyle(color: Color.fromARGB(255, 135, 3, 135)),
              ),
              validator: (email){
                if(email==null || email.isEmpty){
                  return 'Digite o Email';
                }
                return null;
              },
            ),
         
            const SizedBox(
              height: 20,
            ),
            TextFormField(
               obscureText: true,
              controller: senhaController,
              decoration: const InputDecoration(
                border:OutlineInputBorder(
      
                ),
                hintText: 'Senha',
                hintStyle:TextStyle(color: Color.fromARGB(255, 135, 3, 135)),
              ),
              validator: (senha){
                if(senha == null || senha.isEmpty){
                  return'Digite a Senha';
                }
                else if(senha.length<5){
                  return'Digite uma senha mais forte';

                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
           ElevatedButton(onPressed: (){ 
            if(_formKey.currentState!.validate()){
          
            service.saveUser(nomeController.text, 
            emailController.text,
             senhaController.text, 
             10, 
             2,context);
            MySharedPreferences.useremail =emailController.text;
           }
           },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 135, 3, 135)
          ),
          
           child:const Text('Registar',
         style:TextStyle(
          fontSize: 20,
         )
           ) ,
           )
           
          ],
      
         
          ),
      ),

      )
    );
  }
}