import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //obtener el controlador de Googlemapa para acceder al mapa
  Completer<GoogleMapController> _googleMapController = Completer();
  final Set<Marker> markers = new Set(); //marcadores para google map
  static const LatLng showLocation = const LatLng(5.546012, -73.355419);
  CameraPosition? _cameraPosition;
  late LatLng _defautlatLng;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    _defautlatLng = const LatLng(11, 11);
    _cameraPosition = CameraPosition(
      target: _defautlatLng,
      zoom: 17.5,
    );

    //el mapa se redirigirá a mi ubicación actual cuando se cargue
    _gotoUserCurrentPosition();
  }

  //
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google maps"),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: _buildBody(),
      bottomNavigationBar: Container(
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: const Center(child: Text("¿Donde se encuentran los técnicos?")),
      ),
    );
  }

  Widget _buildBody() {
    final Set<Marker> _markers = Set();
    return Stack(
      children: [
        _getMap(),
      ],
    );
  }

  Widget _getMap() {
    return GoogleMap(
      mapToolbarEnabled: false,
      zoomControlsEnabled: false,
      myLocationEnabled: true,
      initialCameraPosition:
          _cameraPosition!, //inicializar la posición de la cámara para el mapa
      mapType: MapType.normal,
      markers: getmarkers(),
      onCameraIdle: () {
        //esta función se activará cuando el usuario deje de arrastrar en el mapa
      },
      onCameraMove: (CameraPosition) {
        //esta función se activará cuando el usuario siga arrastrando en el mapa
      },
      onMapCreated: (GoogleMapController controller) {
        //esta función se activará cuando el mapa esté completamente cargado
        if (!_googleMapController.isCompleted) {
          //configure el controlador en el mapa de Google cuando esté completamente cargado
          _googleMapController.complete(controller);
        }
      },
    );
  }

  Set<Marker> getmarkers() {
    //marcadores para colocar en el mapa
    setState(
      () {
        markers.add(
          Marker(
            //añadir primer marcador
            markerId: MarkerId(showLocation.toString()),
            position: const LatLng(
                4.710409417449941, -74.10931534901471), //posición del marcador
            infoWindow: const InfoWindow(
              //informacion del pin
              title: 'Carolina Alvarez ',
              snippet: '+57 3213454644',
            ),
            icon: BitmapDescriptor.defaultMarker, //Icono del marcador
          ),
        );

        markers.add(
          Marker(
            //añadir segundo marcador
            markerId: MarkerId(showLocation.toString()),
            position: const LatLng(
                4.749294167236992, -74.09528374777022), //posición del marcador
            infoWindow: const InfoWindow(
              //informacion del pin
              title: 'Andrea Suarez ',
              snippet: '+57 3133457844',
            ),
            icon: BitmapDescriptor.defaultMarker, //Icon for Marker
          ),
        );

        markers.add(
          Marker(
            //añadir segundo marcador
            markerId: MarkerId(showLocation.toString()),
            position: const LatLng(
                4.582423186999423, -74.1567126738977), //posición del marcador
            infoWindow: const InfoWindow(
              //informacion del pin
              title: 'Leandro Paredes',
              snippet: '+57 3135677564',
            ),
            icon: BitmapDescriptor.defaultMarker, //Icon for Marker
          ),
        );

        markers.add(
          Marker(
            //añadir segundo marcador
            markerId: MarkerId(showLocation.toString()),
            position: const LatLng(
                4.692079995931123, -74.08722826565366), //posición del marcador
            infoWindow: const InfoWindow(
              //informacion del pin
              title: 'Ezequiel Palacios',
              snippet: '+57 3134278345',
            ),
            icon: BitmapDescriptor.defaultMarker, //Icon for Marker
          ),
        );

        markers.add(
          Marker(
            //añadir segundo marcador
            markerId: MarkerId(showLocation.toString()),
            position: const LatLng(
                4.579965953814034, -74.1583485628921), //posición del marcador
            infoWindow: const InfoWindow(
              //informacion del pin
              title: 'Juan Foyth',
              snippet: '+57 3170941745',
            ),
            icon: BitmapDescriptor.defaultMarker, //Icon for Marker
          ),
        );

        markers.add(
          Marker(
            //añadir segundo marcador
            markerId: MarkerId(showLocation.toString()),
            position: const LatLng(
                4.694857695036852, -74.08624164962531), //posición del marcador
            infoWindow: const InfoWindow(
              //informacion del pin
              title: 'Andres Martinez',
              snippet: '+57 3149205418',
            ),
            icon: BitmapDescriptor.defaultMarker, //Icon for Marker
          ),
        );

        markers.add(
          Marker(
            //añadir segundo marcador
            markerId: MarkerId(showLocation.toString()),
            position: const LatLng(
                4.598067849841167, -74.15283353428006), //posición del marcador
            infoWindow: const InfoWindow(
              //informacion del pin
              title: 'Jamil de Paul',
              snippet: '+57 3207731976',
            ),
            icon: BitmapDescriptor.defaultMarker, //Icon for Marker
          ),
        );

        markers.add(
          Marker(
            //añadir segundo marcador
            markerId: MarkerId(showLocation.toString()),
            position: const LatLng(
                4.616737775904994, -74.15340503613476), //posición del marcador
            infoWindow: const InfoWindow(
              //informacion del pin
              title: 'Samy Batistuta',
              snippet: '+57 3133850972',
            ),
            icon: BitmapDescriptor.defaultMarker, //Icon for Marker
          ),
        );
      },
    );

    return markers;
  }

  //obtener la ubicación actual del usuario, y configurar el mapa y la cámara a esa ubicación
  Future _gotoUserCurrentPosition() async {
    Position currentPosition = await _determineUserCurrentPosition();
    _gotoSpecificPosition(
      LatLng(
        currentPosition.latitude,
        currentPosition.longitude,
      ),
    );
  }

  //ir a una posición específica por lat y lng
  Future _gotoSpecificPosition(LatLng position) async {
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: position,
          zoom: 15,
        ),
      ),
    );
  }

  Future _determineUserCurrentPosition() async {
    LocationPermission locationPermission;
    bool isLocationServiceEnable = await Geolocator.isLocationServiceEnabled();
    //verificar si el usuario habilita el servicio para el permiso de ubicación
    if (!isLocationServiceEnable) {
      print("el usuario no habilita el permiso de ubicación");
    }

    locationPermission = await Geolocator.checkPermission();

    //verifique si el usuario negó la ubicación y vuelva a intentar solicitar permiso
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        print("usuario denegado permiso de ubicación");
      }
    }

    //verificar si el usuario negó el permiso para siempre
    if (locationPermission == LocationPermission.deniedForever) {
      print("usuario negó el permiso para siempre");
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }
}
