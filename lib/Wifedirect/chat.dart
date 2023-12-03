// ignore_for_file: prefer_const_constructors, avoid_print, use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously
// "AIzaSyA5M8cEKQhzyASmT9I776InU_b7fCYH4lk&callback",

import 'dart:io';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'messagem.dart';
import 'dart:async';
import 'package:flutter_p2p_connection/flutter_p2p_connection.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  List<Message> messages = [];

  final TextEditingController _textController = TextEditingController();

  final _flutterP2pConnectionPlugin = FlutterP2pConnection();

  bool isConnected = false; // Estado inicial da conexão
  bool isConnected1 = false; // Estado inicial da conexão
  bool isConnected2 = false; // Estado inicial da conexão

  List<DiscoveredPeers> peers = [];

  WifiP2PInfo? wifiP2PInfo;

  // ignore: unused_field
  StreamSubscription<WifiP2PInfo>? _streamWifiInfo;

  // ignore: unused_field
  StreamSubscription<List<DiscoveredPeers>>? _streamPeers;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeP2PConnection();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _flutterP2pConnectionPlugin.unregister();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _flutterP2pConnectionPlugin.unregister();
    } else if (state == AppLifecycleState.resumed) {
      _flutterP2pConnectionPlugin.register();
    }
  }

  void _initializeP2PConnection() async {
    bool initialized = await _flutterP2pConnectionPlugin
        .initialize(); //Para inicializar a conexão P2P; // Inicializar a conexão P2P aqui

    await _flutterP2pConnectionPlugin.register(); //Também regist-se já...

   
    print(await _flutterP2pConnectionPlugin.askLocationPermission()); //Aqui sempre qeue opção de chat iniciar solicita a permissão

    if (initialized) {
      _streamWifiInfo =
          _flutterP2pConnectionPlugin.streamWifiP2PInfo().listen((event) {
        setState(() {
          wifiP2PInfo = event;
        });
      });

      //Em seguida, são registrados callbacks para lidar com a recepção de mensagens nos convidadados
      _streamPeers = _flutterP2pConnectionPlugin.streamPeers().listen((event) {
        setState(() {
          peers = event;
        });
      });
    } else {
      // Trate a falha de inicialização da conexão
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro de inicialização'),
            content: Text('Falha ao inicializar a conexão P2P.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  ///ESTRUTURA DOS PARTICIPANTES AO WIFI DIRECT NA OPÇÃO ENVIO E RECEPÇÃP DE MENSAGENS

//No anfitrião
  Future startSocket() async {
    if (wifiP2PInfo != null) {
      await _flutterP2pConnectionPlugin.startSocket(
        groupOwnerAddress: wifiP2PInfo!.groupOwnerAddress,
        downloadPath: "/storage/emulated/0/Download/",
        maxConcurrentDownloads: 2,
        deleteOnError: true,
        onConnect: (name, address) {
          snack("$name conectado ao soquete com endereço: $address");
        },
        transferUpdate: (transfer) {
          if (transfer.completed) {
            ///snack("${transfer.failed ? "falhei em ${transfer.receiving ? "receber" : "enviar"}" : transfer.receiving ? "recebido" : "sent"}: ${transfer.filename}");
          }

          //print("ID: ${transfer.id}, FILENAME: ${transfer.filename}, PATH: ${transfer.path}, COUNT: ${transfer.count}, TOTAL: ${transfer.total}, COMPLETED: ${transfer.completed}, FAILED: ${transfer.failed}, RECEIVING: ${transfer.receiving}");
        },
        receiveString: (req) async {
          ///snack(req);
          setState(() {
            //A mensagem que o anfitrião ou criador de grupo recebe é colocado através do canal de comunicação(sOCKET) na lista aqui, e exido na sua tela
            //messages.add('Recebido: $req');
            messages.add(Message(text: req, isSentByMe: false,));
          });
        },
      );

      ///snack("conexão aberta: $started");
    }
  }

//No cliente
  Future connectToSocket() async {
    if (wifiP2PInfo != null) {
      await _flutterP2pConnectionPlugin.connectToSocket(
        groupOwnerAddress: wifiP2PInfo!.groupOwnerAddress,
        downloadPath: "/storage/emulated/0/Download/",
        maxConcurrentDownloads: 3,
        deleteOnError: true,
        onConnect: (address) {
          //snack("conectedo com: $address");
        },
        transferUpdate: (transfer) {
          if (transfer.count == 0) transfer.cancelToken?.cancel();
          if (transfer.completed) {
            //snack("${transfer.failed ? "falha ao ${transfer.receiving ? "receber" : "enviar"}" : transfer.receiving ? "recibido" : "enviar"}: ${transfer.filename}");
          }

          //print("ID: ${transfer.id}, NOME DO FICHEIRO: ${transfer.filename}, PASTA: ${transfer.path}, CONTA: ${transfer.count}, TOTAL: ${transfer.total}, COMPLETADO: ${transfer.completed}, FALHADO: ${transfer.failed}, RECEBENDO: ${transfer.receiving}");
        },

        //Aqui será exibido a mensagem enviado ao cliente
        receiveString: (req) async {
          ///snack(req);
          setState(() {
            //A mensagem que o cliente recebe é colocado a lista de mensagens apartir do canal socket aqui
            //messages.add('Recebido: $req');
            messages.add(Message(text: req, isSentByMe: false,));
          });
        },
      );

      ///print("status da conexão: $conect");
    }
  }

  //Terminar a connexão
  Future closeSocketConnection() async {
    _flutterP2pConnectionPlugin.closeSocket();
  }

  ///FIM DA ESTRUTUTA

  void snack(String msg) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: Text(
          msg,
        ),
      ),
    );
  }

  //Para enviar ficheiro
  Future sendFile(bool phone) async {
    String? filePath = await FilesystemPicker.open(
      context: context,
      rootDirectory: Directory(phone ? "/storage/emulated/0/" : "/storage/"),
      fsType: FilesystemType.file,
      fileTileSelectMode: FileTileSelectMode.wholeTile,
      showGoUp: true,
      folderIconColor: Colors.grey,
    );
    if (filePath == null) return;
    List<TransferUpdate>? updates =
        await _flutterP2pConnectionPlugin.sendFiletoSocket(
      [filePath],
    );
    print(updates);
  }

  ///Fim senFile

  /////Enviar mensagem e mostrar na tela atual
  void sendMessage(String message) async {
    _flutterP2pConnectionPlugin.sendStringToSocket(message); // Envia a mensagem para todos os dispositivos conectados
    /*setState(() {
      messages.add('Eu: $message');
    });*/
    setState(() {
      messages.add(Message(text: message, isSentByMe: true));
    });
    _textController.clear();
  }

//VERIFICAR O STATUS DO GRUPO SE CRIADO OU NÃO

  void conectar(int k) {
    // Simulando uma ação de conexão ocorrendo com sucesso
    if (k == 1) {
      setState(() {
        isConnected = true; // Conectado
      });
    } else if (k == 2) {
      setState(() {
        isConnected1 = true; // Conectado
      });
    } else {
      setState(() {
        isConnected2 = true; // Conectado
      });
    }
  }

  void desconectar(int k) {
    // Simulando uma ação de desconexão ocorrendo com sucesso
    if (k == 1) {
      setState(() {
        isConnected = false; // Desconectado
      });
    } else if (k == 2) {
      setState(() {
        isConnected1 = false; // Desconectado
      });
    } else {
      setState(() {
        isConnected2 = false; // Desconectado
      });
    }
  }

//FIM VERFICAR STATUS

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 131, 3, 131),
        flexibleSpace: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Tooltip(
                message: 'Criar grupo',
                child: IconButton(
                  icon: Icon(
                    isConnected ? Icons.group_add : Icons.group_remove,
                    color: isConnected ? Colors.green : Colors.white,
                  ),
                  onPressed: () async {
                    // Ao pressionar o ícone, chama o método apropriado
                    if (isConnected) {
                      desconectar(1);
                      await _flutterP2pConnectionPlugin
                          .removeGroup(); //Remove ou desconectar grupo
                    } else {
                      conectar(1);
                      await _flutterP2pConnectionPlugin
                          .createGroup(); //Cria um grupo e aguardar conexões
                    }
                  },
                ),
              ),
              Tooltip(
                message: 'Iniciar conexão',
                child: IconButton(
                  icon: Icon(
                    isConnected1 ? Icons.check : Icons.close,
                    color: isConnected1 ? Colors.green : Colors.white,
                  ),
                  onPressed: () async {
                    if (isConnected1) {
                      desconectar(2);
                      await closeSocketConnection(); //Desconectar - se, não recebendo novamente mensagens
                    } else {
                      conectar(2);
                      startSocket(); //Conecta-se e volta a receber mensagens do grupo
                    }
                  },
                ),
              ),
              Tooltip(
                message: 'Conecta-se',
                child: IconButton(
                  icon: Icon(
                    isConnected2
                        ? Icons.connect_without_contact_rounded
                        : Icons.connect_without_contact_rounded,
                    color: isConnected2 ? Colors.green : Colors.white,
                  ),
                  onPressed: () async {
                    if (isConnected2) {
                      desconectar(3);
                      await closeSocketConnection(); //Desconectar - se, não volta receber novamente mensagens
                    } else {
                      if (isConnected && isConnected1) {
                        isConnected2 = false;
                      } else {
                        conectar(3);
                        await connectToSocket(); //Conecta-se ao grupo para receber mensagens;
                      }
                    }
                  },
                ),
              ),
              Tooltip(
                message: 'pesquisar',
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white, // Cor do ícone
                  ),
                  onPressed: () async {
                    await _flutterP2pConnectionPlugin.discover(); //Pesquisar dispositivos próximos
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        
        children: [
            const SizedBox(height: 10),
            SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: peers.length,
              itemBuilder: (context, index) => Center(
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Center(
                        child: AlertDialog(
                          content: SizedBox(
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("nome: ${peers[index].deviceName}"),
                                Text("endereço: ${peers[index].deviceAddress}"),
                                Text(
                                    "proprietário do grupo: ${peers[index].isGroupOwner}"),
                                Text("estados: ${peers[index].status}"),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop();

                                print(await _flutterP2pConnectionPlugin
                                    .askLocationPermission());
                                await _flutterP2pConnectionPlugin
                                    .connect(peers[index].deviceAddress);
                                //nack("conectedo: $connected");
                              },
                              child: const Text("conectar"),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        peers[index]
                            .deviceName
                            .toString()
                            .characters
                            .first
                            .toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          //TERMINO DA CONTAIR DOS PEERS

          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                Message message = messages[index];
                return message.isSentByMe ? _buildSentMessage(message.text): _buildReceivedMessage(message.text);
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildSentMessage(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: BubbleSpecialThree(
        text: text,
      color: Color.fromARGB(255, 135, 3, 135),
        tail: true,
        textStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget _buildReceivedMessage(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: BubbleSpecialThree(
        text: text,
        color: Colors.green,
        tail: true,
        isSender: false,
        textStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _textController,
        onSubmitted: (text) {
          setState(() {
            messages.add(Message(text: text, isSentByMe: true));
          });
        },
        decoration: InputDecoration(
          hintText: 'Mensagem',
          hintStyle:TextStyle(color: Color.fromARGB(255, 135, 3, 135)),
          suffixIcon: IconButton(
            onPressed: () async => sendMessage(_textController.text),
            icon: Icon(Icons.send, color: Color.fromARGB(255, 135, 3, 135)),
            
          ),
        ),
      ),
    );
  }
}
