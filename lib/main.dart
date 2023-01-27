import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model_theme.dart';

import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ModelTheme(),
      child: Consumer<ModelTheme>(
          builder: (context, ModelTheme themeNotifier, child) {
        return MaterialApp(
            home: Home(),
            theme: themeNotifier.isDark
                ? ThemeData.dark()
                : ThemeData(
                    brightness: Brightness.light,
                    primarySwatch: Colors.blueGrey,
                  ));
      }),
    );
  }
}
