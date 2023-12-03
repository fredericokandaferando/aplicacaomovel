import 'package:aplicacaomovel/Estacao/serviceDevolver.dart';
import 'package:flutter/material.dart';
import 'package:aplicacaomovel/Estacao/serviceEstacao.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../register/User.dart';
import '../valores/shered_preference.dart';

class ListaEstacaoDevolver extends StatefulWidget {
  const ListaEstacaoDevolver({Key? key}) : super(key: key);

  @override
  State<ListaEstacaoDevolver > createState() => _ListaEstacaoState();
}
 Future<User> fetchUser(String email) async {
    final response = await http.get(Uri.parse(MySharedPreferences.ip + '/estacao/user/$email'));
    print(response.body); // For debugging purposes, check the response body
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar informações do usuário');
    }
  }
  String email = MySharedPreferences.useremail;
class _ListaEstacaoState extends State<ListaEstacaoDevolver> {
  @override
  Widget build(BuildContext context) {
   
  
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
        backgroundColor: const Color.fromARGB(255, 131, 3, 131),
        title: const Text("Devolver Bike"),
      ),
      body: FutureBuilder<List<ServicesEstacao>>(
        future: fetchEstacao(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Erro: ${snapshot.error}');
          } else {
            List<ServicesEstacao> estacao = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowHeight: 40,
                horizontalMargin: 2,
                
                columns: [
                  DataColumn(
                    label: SizedBox(width: 100, child: Text('Estação')),
                    numeric: true,
                  ),
                  DataColumn(
                    label: SizedBox(width: 100, child: Text('Latitude')),
                    numeric: true,
                  ),
                  DataColumn(
                    label: SizedBox(width: 100, child: Text('Longitude')),
                    numeric: true,
                  ),
                  DataColumn(
                    label: SizedBox(width: 100, child: Text('Bike Dispoivel')),
                    numeric: true,
                  ),
                  DataColumn(
                    label: SizedBox(width: 100, child: Text('Prêmio Entrega')),
                    numeric: true,
                  ),
                ],
                rows: estacao.map((estacao) {
                  return DataRow(
                    onSelectChanged: (isSelected) {
                      if (isSelected != null && isSelected) {
                        _showEstacaoDialog(estacao); // Mostrar o diálogo ao selecionar uma estação.
                      }
                    },
                    cells: [
                      DataCell(SizedBox(width: 100, child: Text(estacao.estacao.toString()))),
                      DataCell(SizedBox(width: 100, child: Text(estacao.latitude.toString()))),
                      DataCell(SizedBox(width: 100, child: Text(estacao.longitude.toString()))),
                      DataCell(SizedBox(width: 100, child: Text(estacao.capacidate.toString()))),
                      DataCell(SizedBox(width: 100, child: Text(estacao.premioEmtrega==null ? '0':estacao.premioEmtrega.toString()))),
                    ],
                    
                  );
                  
                }).toList(),
              ),
            );
          }
        },
         
      ),

      
    );
    
  }
      }
    );
  }
  void _showEstacaoDialog(ServicesEstacao estacao) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Informações da Estação'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
               
               Text('Estação: ${estacao.estacao}'),
              Text('Latitude: ${estacao.latitude}'),
              Text('Longitude: ${estacao.longitude}'),
              Text('Bike Dispoivel: ${estacao.capacidate}'),
              Text(estacao.premioEmtrega ==null? 'Premio: Não tem premio':'Premio: ${estacao.premioEmtrega} pts'),
              // Adicione aqui mais informações da estação, se necessário.
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                  int ? idestacao=estacao.id;
            devolverBicicleta(email,idestacao!, context);
            
              },
              child: Text('Devolver'),
              

            ),
          ],
        );
      },
    );
  }
}
