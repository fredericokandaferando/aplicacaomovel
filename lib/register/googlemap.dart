import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:aplicacaomovel/register/home_usuario.dart';
import 'package:aplicacaomovel/register/service_goolemap.dart';
class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);
  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController mapController;
  double latitude = -8.942703827556109;
  double longitude = 13.280810795516565;
  Set<Marker> markers = {}; // Conjunto de marcadores vazio inicialmente

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Função para adicionar marcador no mapa
  void addMarker(double lat, double lng, int title) {
    final marker = Marker(
      markerId: MarkerId("${lat}_${lng}"),
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(title: 'Estação', snippet: 'Lat: $lat, Lng: $lng'),
       onTap: () {
        // Navega para a página "Bina" quando a janela de informações do marcador for tocada
       /* Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>home_usuarioRegister()), // Substitua BinaPage() pela classe da página "Bina"
        );*/
      },
    );

    setState(() {
      markers.add(marker);
    });
  }

  // Função para buscar os dados da API e adicionar marcadores
  void fetchDataFromAPI() async {
    try {
      List<Map<String, dynamic>> apiData = await ApiService.fetchLocationsFromAPI();

      for (var data in apiData) {
        double lat = data['latitude'];
        double lng = data['longitude'];
        int title = data['capacidate']; // Substitua 'title' pelo nome do campo na sua API que contém o título desejado
        addMarker(lat, lng, title);  
      }
    } catch (e) {
      // Trate possíveis erros aqui
      print('Erro: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI(); // Chama a função para buscar os dados da API e adicionar marcadores
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 131, 3, 131),
        title: const Text("Google Map"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 11.0,
        ),
        onMapCreated: onMapCreated,
        markers: markers, // Define o conjunto de marcadores no mapa
      ),
    );
  }
}
