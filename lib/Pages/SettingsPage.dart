import 'package:flutter/material.dart';

import 'package:gaminghub/Pages/GameHomePage.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: const Text('settings'),
      ),
    );
  }
}
