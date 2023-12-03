import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:aplicacaomovel/register/user.dart';
import '../valores/shered_preference.dart';
class Logalizacao extends StatefulWidget {
  const Logalizacao({super.key});

  @override
  State<Logalizacao> createState() => _LogalizacaoState();
}
 Future<User> fetchUser(String email) async {
    final response = await http.get(Uri.parse(MySharedPreferences.ip+'/estacao/user/$email'));
    print(response.body); // For debugging purposes, check the response body
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar informações do usuário');
    }
  }
class _LogalizacaoState extends State<Logalizacao> {
  double? latitude;
  double? longitude;
  String? endereco;
  List<Map<String, dynamic>> trajetoria = [];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    pegarPosicao(); // Chamada inicial
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      pegarPosicao(); // Chama a função a cada 10 segundos
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancela o timer quando o widget é descartado
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String email = MySharedPreferences.useremail;
     return FutureBuilder<User>(
      future: fetchUser(email),
      
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          // If there's no data, handle it accordingly (optional)
          return Text('No data available');
        } else {
          User user = snapshot.data!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações do Usuario'),
         backgroundColor: const Color.fromARGB(255, 131, 3, 131),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

           Text('Nome: ${user.name}',style: TextStyle(fontSize: 24,color: Color.fromARGB(255, 135, 3, 135)),),
                    Text('Email:${user.email}',style: TextStyle(fontSize: 24,color: Color.fromARGB(255, 135, 3, 135)),),
                  Text(
                    'Ponto: ${user.ponto}pts',                  
                    style: TextStyle(fontSize: 24,color: Color.fromARGB(255, 135, 3, 135)),
                  ),
                  Text( user.istation_id==null ?'Nao tem Bike':'tem Bike',style: TextStyle(fontSize: 24,color: Color.fromARGB(255, 135, 3, 135)),),

          
          SizedBox(height: 20),
          Text(
            'Latitude:',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            latitude != null ? '$latitude' : 'Aguardando...',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            'Longitude:',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            longitude != null ? '$longitude' : 'Aguardando...',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            'Endereço:',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            endereco ?? 'Aguardando...',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            'Trajetória:',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: trajetoria.length,
              itemBuilder: (BuildContext context, int index) {
                final posicao = trajetoria[index];
                return ListTile(
                  title: Text('Latitude: ${posicao['latitude']}'),
                  subtitle: Text('Longitude: ${posicao['longitude']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
      }
     );
  }
  pegarPosicao() async {
    Position position = await Geolocator.getCurrentPosition();
    List<Placemark> locais = await placemarkFromCoordinates(position.latitude, position.longitude);

    if (locais != null) {
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
        endereco = locais[0].street ?? 'Endereço desconhecido';
        trajetoria.add({
          'latitude': position.latitude,
          'longitude': position.longitude,
        });
      });
    }
  }

}
