import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class logalizacao extends StatefulWidget {
  const logalizacao({super.key});

  @override
  State<logalizacao> createState() => _logalizacaoState();
}

class _logalizacaoState extends State<logalizacao> {

  double? latitude;
  double? longitude;
  String? endereco;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body:Column(
          crossAxisAlignment:CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          latitude !=null ? Text('Latitude:$latitude',textAlign: 
          TextAlign.center,):Text('Latitude '),
          longitude !=null ? Text('Longitude:$longitude',textAlign: TextAlign.center):Text('Longitude'),
          endereco !=null ? Text('Endereço:$endereco',textAlign: TextAlign.center):Text('Endereço'),
     
          TextButton( child: Text('Pegar Posição'),onPressed: (){


            pegarPosicao();
           },),

          
        ],
      ),



    );
  }

  pegarPosicao() async{

    Position position= await Geolocator.getCurrentPosition();
    print(position);
    setState(() {
      latitude= position.latitude;
      longitude=position.longitude;
    });
  List<Placemark> locais =await placemarkFromCoordinates(position.latitude,position.longitude);

  if(locais!=null){
     endereco= (locais[0].toJson().toString());

  }

  }
}
