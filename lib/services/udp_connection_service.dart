import 'dart:convert';
import 'dart:io';

import 'package:udp/udp.dart';

class UDPConnectionService {
  UDPConnectionService._();

  static UDP? _socket;
  static late InternetAddress _address;
  static late Port _port;

  static initializeSocket(String host, int port) {
    _address = InternetAddress(host);
    _port = Port(port);
    _bindUDP();
  }

  static Future<void> _bindUDP() async {
    final socket = await UDP.bind(Endpoint.unicast(
      InternetAddress.loopbackIPv4,
      port: const Port(4023),
    ));
    _socket = socket;
  }

  static Future<void> sendUdpData(String data) async {
    List<int> utfData = const Utf8Codec().encode(data);
    _socket?.send(utfData, Endpoint.unicast(_address, port: _port));
  }
}
