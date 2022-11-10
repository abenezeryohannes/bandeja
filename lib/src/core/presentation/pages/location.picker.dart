import 'package:bandeja/src/core/data/authentication/dto/location.dto.dart';
import 'package:bandeja/src/core/presentation/widgets/app.snack.bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({Key? key}) : super(key: key);

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FlutterLocationPicker(
            initPosition: LatLong(29.3117, 47.4818),
            selectLocationButtonStyle: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            ),
            selectLocationButtonText: 'Set Exact Location',
            initZoom: 11,
            minZoomLevel: 5,
            maxZoomLevel: 16,
            trackMyPosition: true,
            onError: (e) => AppSnackBar.error(message: e.toString()),
            onPicked: (pickedData) {
              Get.back<LocationDto>(
                  result: LocationDto.empty(
                latitude: pickedData.latLong.latitude,
                longitude: pickedData.latLong.longitude,
                address: pickedData.address,
              ));
            }),
      ),
    );
  }
}
