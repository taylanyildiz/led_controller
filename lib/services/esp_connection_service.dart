import 'dart:convert';
import 'dart:io';

import 'package:udp/udp.dart';

class ESPConnectionService {
  ESPConnectionService._();

  static Future<void> bindUpd(String address, int port) async {
    final udpSocket = await UDP.bind(Endpoint.unicast(
      InternetAddress.anyIPv4,
      port: const Port(2023),
    ));

    await udpSocket.send(
      const Utf8Codec().encode("hey"),
      Endpoint.multicast(InternetAddress(address), port: const Port(4023)),
    );
  }
}
