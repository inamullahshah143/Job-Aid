import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CandidateNearJobs extends StatefulWidget {
  CandidateNearJobs({super.key});

  @override
  State<CandidateNearJobs> createState() => _CandidateNearJobsState();
}

class _CandidateNearJobsState extends State<CandidateNearJobs> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition? _kGooglePlex;
  @override
  void initState() {
    _kGooglePlex = CameraPosition(
      target: LatLng(33.7367652, 72.817363),
      zoom: 10,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.terrain,
        initialCameraPosition: _kGooglePlex!,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
