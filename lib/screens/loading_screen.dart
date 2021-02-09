import 'package:flutter/material.dart';
import 'package:flutter_routes_map/helpers/helpers.dart';
import 'package:flutter_routes_map/screens/acceso_gps_screen.dart';
import 'package:flutter_routes_map/screens/mapa_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with WidgetsBindingObserver {

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if(state == AppLifecycleState.resumed) {
      this.checkGpsAndLocation(context);
    }
    super.didChangeAppLifecycleState(state);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsAndLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if( snapshot.hasData ) {
            return Center(
              child: Text(snapshot.data),
            );
          }
          return CircularProgressIndicator();
        }
      ),
    );
  }

  Future checkGpsAndLocation(BuildContext context) async {

    //TODO: ver si tengo permisos de gps

    final haveGpsPermission = await Permission.location.isGranted;

    //TODO: ¿GPS activo?
    final isGpsActive = await Geolocator.isLocationServiceEnabled();

    if(haveGpsPermission && isGpsActive) {
      Navigator.pushReplacement(context, navegarMapaFadeIn(context, MapaScreen()));
      return '';
    } else if(!haveGpsPermission) {
      Navigator.pushReplacement(context, navegarMapaFadeIn(context, AccesoGpsScreen()));
      return 'Necesita Permisos de GPS';
    } else if(!isGpsActive) {
      return 'Activa el GPS';
    }

  }
}
