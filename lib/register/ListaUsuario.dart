import 'package:aplicacaomovel/register/serviceLista.dart';
import 'package:flutter/material.dart';
import 'package:aplicacaomovel/register/wifidirect.dart';
import 'package:aplicacaomovel/Wifedirect/chat.dart';
class ListaUsuario extends StatefulWidget {
  const ListaUsuario ({Key? key}) : super(key: key);

  @override
  State<ListaUsuario> createState() => _ListaUsuarioState();
}

class _ListaUsuarioState extends State<ListaUsuario> {
  void _onRowTapped(DataRow dataRow) {
    // Aqui você pode acessar os dados da linha específica e realizar alguma ação.
    // Por exemplo, exibir um diálogo com os detalhes da linha selecionada.
    Text nome = dataRow.cells[0].child as Text; // Obtendo o nome
    Text sobrenome = dataRow.cells[1].child as Text; // Obtendo o sobrenome

    // Agora você pode fazer o que quiser com esses dados.
    print('Nome: $nome, Sobrenome: $sobrenome');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 131, 3, 131),
        title: const Text("Lista de Usuarios"),
      ),
      body: FutureBuilder<List<ServicesListaUsuario>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Erro: ${snapshot.error}');
          } else {
            List<ServicesListaUsuario> users = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
         
                headingRowHeight: 40, // Ajuste a altura do cabeçalho
                horizontalMargin:2, // Ajuste o espaçamento entre as colunas de dados
                columns: [
                  DataColumn(
                    label: SizedBox(width: 100, child: Text('Nome',style: TextStyle(color: Color.fromARGB(255, 135, 3, 135)),)),

                  ),
                  DataColumn(
                    label: SizedBox(width: 100, child: Text('Email',style: TextStyle(color: Color.fromARGB(255, 135, 3, 135)))),
                    numeric: true,
                  ),
                   DataColumn(
                    label: SizedBox(width: 100, child: Text('Ações',style: TextStyle(color: Color.fromARGB(255, 135, 3, 135)))),
                    numeric: false,
                  ),
                  
                 
                ],
                rows: users.map((user) {
                  return DataRow(cells: [
                    DataCell(SizedBox(width: 100,height: 500, child: Text(user.name.toString()))),
                    DataCell(SizedBox(width: 100,height: 500, child: Text(user.email.toString()))),
                    DataCell(Wrap(
                      children: [
                        IconButton(
                          icon: new Icon(Icons.messenger),
                          color: Color.fromARGB(255, 3, 134, 173),
                          onPressed: () {
                             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatScreen()),) ;
                             
                          }, 
                        )   ,           
                         IconButton(
                          icon: new Icon(Icons.point_of_sale),
                          onPressed: () {
                             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyApp()),) ;
                             
                          }, 
                        )   ,           
                         
                         
                      ],
                    )
                    )
                  ]);
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
  
}
