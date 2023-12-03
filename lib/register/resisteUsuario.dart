import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:aplicacaomovel/valores/config.dart';
import '../home_widgets/home_pricipalpage.dart';
import 'package:aplicacaomovel/main.dart';
class Services {
  Future<void> signIn(String email, String password, BuildContext context) async {
    String body = '''
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.bikeshared.com/">
   <soapenv:Header/>
   <soapenv:Body>
      <ser:login>
         <!--Optional:-->
         <email>$email</email>
         <!--Optional:-->
         <password>$password</password>
      </ser:login>
   </soapenv:Body>
</soapenv:Envelope>
''';

    final response = await http.post(
      Uri.parse(SOAPURL),
     headers: {
          'Content-Type': 'text/xml;charset=utf-8',
        },
      body: body,
    );
    print(response.body);

    if (response.statusCode == 200) {
      // Processar a resposta SOAP (geralmente XML)
      final responseBody = response.body;
      print(responseBody);
      parseSoapResponse(responseBody); // Implemente a função para processar a resposta XML
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Userlog(),
        ),
      );
    } else if (response.statusCode==401) {
      _showMyDialog(context);  
    }else{
         print('Erro durante o login');   
    }
    
  }

  void parseSoapResponse(String soapResponse) {
    final document = xml.XmlDocument.parse(soapResponse);

    print(document.toXmlString());
    // Use o objeto 'document' para navegar e extrair dados da resposta XML.
  }

  void _showMyDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(
          children: [
            Icon(Icons.error, color: Colors.red),
            SizedBox(width: 8),
            Text('Aviso'),
          ],
        ),
        content: Text('Credencias ivalida'),
        actions: [
         
          TextButton(
            onPressed: () {
              //
              // Ação quando o botão "OK" é pressionado             
                Navigator.pop(context, MaterialPageRoute(
                 builder: (context) => const HomePage(),
          ),);
                
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
  
}
}