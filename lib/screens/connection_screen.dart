import 'package:flutter/material.dart';

class ConnectionScreen extends StatelessWidget {
  const ConnectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar,
      body: SingleChildScrollView(
        child: Column(),
      ),
    );
  }

  AppBar get _buildAppBar {
    return AppBar();
  }
}
