import 'package:flutter/material.dart';
import 'package:aplicacaomovel/register/home_usuario.dart';
import  'package:aplicacaomovel/serviceLogin.dart';
import 'package:aplicacaomovel/register/test.dart';
import 'package:aplicacaomovel/register/geolo_page.dart';
import 'package:aplicacaomovel/register/googlemap.dart';
void main() => runApp(
      const MaterialApp(debugShowCheckedModeBanner: false,
           //home: HomePage(),
            // home: MyApp(),
           //home:GoogleMapScreen(),
          home:logalizacao(),
          //home: home_usuarioRegister(),
      ),
    );
 TextEditingController emailControllerr = TextEditingController();
 TextEditingController passworControllerr = TextEditingController();
 Services servicelogin = Services();
 final _formKey = GlobalKey<FormState>();
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
   
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color.fromARGB(172, 151, 2, 171),
              Color.fromARGB(156, 135, 2, 129),
              Color.fromARGB(255, 124, 3, 190),
              Color.fromARGB(255, 166, 17, 230),
            ],
          ),
        ),
        child: SingleChildScrollView( // Adicionando o SingleChildScrollView para permitir a rolagem
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                
                  children: <Widget>[
                    Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "BikeShared",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 60),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(130, 5, 107, 0.988),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            )
                          ],
                        ),
                        
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(color: Colors.grey))),
                                child: TextFormField(
                                   controller: emailControllerr,
                                  decoration: const InputDecoration(
                                    hintText: "E-mail",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  validator:(email){
                                    if(email== null || email.isEmpty){
                                      return 'Digite seu e-mail';
                                    }
                                    return null;
                                  },
                                  
                                 
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(color: Colors.grey))),
                                child: TextFormField(
                                   controller: passworControllerr,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    hintText: "Senha",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  validator: (senha){
                                    if(senha==null || senha.isEmpty){
                                      return 'Digite a sua senha';
                                    }
                                    return null;
                                  },
                                ),
                                
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        "Esqueceu sua Senha?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height:30),
                      ElevatedButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()){

                             servicelogin.loginUser(emailControllerr.text,passworControllerr.text,context);   
                         


                          }
                          //Navigator.of(context).push(
                           // MaterialPageRoute(
                             // builder: (context) => home_pricipalpage(),
                            ///),
                         // );
                         
                           
                        },
                        style: ElevatedButton.styleFrom(minimumSize: const Size(350, 50),
                          backgroundColor: const Color.fromARGB(255, 135, 3, 135),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height:58),
                      const Text(
                        "Crie a sua conta no BikeShared",
                        style: TextStyle(color: Colors.grey),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const home_usuarioRegister(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom( minimumSize: const Size(350, 50), 
                          backgroundColor: const Color.fromARGB(255, 67, 67, 67),
                        ),
                        child: const Text(
                          "Cadastrar-se",
                          style: TextStyle(
                            color: Colors.white,
                            
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
