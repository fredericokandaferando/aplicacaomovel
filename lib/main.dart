import 'package:flutter/material.dart';
import 'package:aplicacaomovel/home_widgets/home_pricipalpage.dart';
import 'package:aplicacaomovel/register/home_usuario.dart';
void main()=>runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
       //home: home_usuarioRegister(),
       //home: home_pricipalpage(),
    home:HomePage(),
  
    ),
);
 
 class HomePage extends StatelessWidget{
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       body: Container(
        padding:  EdgeInsets.symmetric(vertical: 30),
        width: double.infinity,
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color.fromARGB(172, 151, 2, 171),
              Color.fromARGB(156, 135, 2, 129),
              Color.fromARGB(255, 124, 3, 190),
              Color.fromARGB(255, 166, 17, 230) 
               
            ] 
          )
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget> [
            SizedBox(height: 60 ,),
            Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                       
                      Text("Login",style: TextStyle(color: Colors.white,fontSize: 40 ),),
                      SizedBox(height: 10,),
                      Text("BikeShared",style: TextStyle(color: Colors.white,fontSize: 20 ),),
                ],
              ),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: Container(
                decoration:  BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60))

                ),
                child: Padding(
                  padding:EdgeInsets.all(20),
                  child: Column(
                    children:<Widget>[
                      SizedBox(height:60 ,),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [BoxShadow(
                          color: Color.fromRGBO(130, 5, 107, 0.988),
                          blurRadius: 20,
                          offset: Offset(0,10)
                        )]
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(2),
                              decoration:BoxDecoration(
                                border: Border(bottom:BorderSide(color: Colors.grey) )
                              ) ,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Email ou Telmovel",
                                  hintStyle:TextStyle(color: Colors.grey),
                                  border: InputBorder.none
                                ),
                              ),

                            ),
                               Container(
                              padding: EdgeInsets.all(2),
                              decoration:BoxDecoration(
                                border: Border(bottom:BorderSide(color: Colors.grey) )
                              ) ,
                              child: TextField(
                                 obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Senha",
                                  hintStyle:TextStyle(color: Colors.grey),
                                  border: InputBorder.none
                                ),
                              ),

                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 40,),
                      Text("Esqueceu sua Senha ?",style: TextStyle(color: Colors.grey),),
                      SizedBox(height: 40,),
                      ElevatedButton(onPressed: () {

                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> home_pricipalpage(),),) ;                      
                      },
                       
                      child:Center(
                      child: Text("Login",style: TextStyle(color: Colors.white, fontWeight:FontWeight.bold ),),

                      ),
                       style: ElevatedButton.styleFrom(
                        
                       backgroundColor: Color.fromARGB(255, 135, 3, 135)
                    ),
                      ),
                          SizedBox(height: 50,),
                          Text("crie a tua conta no Bishared",style: TextStyle(color: Colors.grey),),
                     
                                   
                          ElevatedButton(onPressed: () {   

                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>home_usuarioRegister()),) ;
                      },                           
                                                 child:Center(
                      child: Text("Cadastra-se",style: TextStyle(color: Colors.white, fontWeight:FontWeight.bold ),),
                      ),
                       style: ElevatedButton.styleFrom(
                        
                       backgroundColor: Color.fromARGB(255, 67, 67, 67)
                       )
                          ),
                          
                        ],
                      )
                                         
                  ), 
                  ),
                ),
          
           
              
              
        
          ],
        ),

       ),


    ) ;
  }

 }