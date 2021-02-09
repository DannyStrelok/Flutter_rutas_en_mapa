import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AccesoGpsScreen extends StatefulWidget {
  @override
  _AccesoGpsScreenState createState() => _AccesoGpsScreenState();
}

class _AccesoGpsScreenState extends State<AccesoGpsScreen> with WidgetsBindingObserver {

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
    print('**** STATE: $state *******');

    if(state == AppLifecycleState.resumed) {
      if(await Permission.location.isGranted) {
        Navigator.pushReplacementNamed(context, 'Loading');
      }
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Requiere permisos de GPS'),
          MaterialButton(
            child: Text('Pedir permisos', style: TextStyle(color: Colors.white),),
            color: Colors.black,
            shape: StadiumBorder(),
            elevation: 0,
            onPressed: () async {
              final status = await Permission.location.request();
              this.checkGpsPermissions(status);
            },
          )
        ],
      )),
    );
  }

  void checkGpsPermissions(PermissionStatus status) {

    switch(status) {
      case PermissionStatus.granted:
        Navigator.pushReplacementNamed(context, 'mapa');
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
    }

  }
}
