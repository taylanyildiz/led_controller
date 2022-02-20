import 'dart:convert';
import 'dart:io';
import 'package:udp/udp.dart';

class UDPConnectionService {
  UDPConnectionService._();

  static UDP? _socket;
  static late InternetAddress _address;
  static late Port _port;

  static String get _ip => InternetAddress.loopbackIPv4.toString();

  static Future<void> initializeSocket(String host, int port) async {
    _address = InternetAddress(host);
    _port = Port(port);
  }

  static Future<void> _bindUDP() async {
    final socket = await UDP.bind(Endpoint.unicast(
      InternetAddress.anyIPv4,
      port: const Port(4023),
    ));

    List<int> utfData = const Utf8Codec().encode("Connected $_ip");
    socket.send(utfData, Endpoint.unicast(_address, port: _port));
    _socket = socket;
  }

  static Future<void> sendUdpData(String data) async {
    List<int> utfData = const Utf8Codec().encode(data);
    await _socket?.send(utfData, Endpoint.unicast(_address, port: _port));
  }

  static bool get closed => _socket?.closed ?? true;

  static Future<void> close() async {
    List<int> utfData = const Utf8Codec().encode("Disconnected $_ip");
    await _socket?.send(utfData, Endpoint.unicast(_address, port: _port));
    _socket?.close();
  }

  static Future<void> connect() async => await _bindUDP();
}
