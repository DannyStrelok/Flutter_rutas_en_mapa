import 'package:flutter/material.dart';
import 'package:flutter_routes_map/screens/acceso_gps_screen.dart';
import 'package:flutter_routes_map/screens/loading_screen.dart';
import 'package:flutter_routes_map/screens/mapa_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: LoadingScreen(),
      routes: {
        'mapa': (_) => MapaScreen(),
        'Loading': (_) => LoadingScreen(),
        'acceso_gps': (_) => AccesoGpsScreen(),
      },
    );
  }
}
