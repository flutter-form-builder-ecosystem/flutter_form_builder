import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationFieldDialog extends StatefulWidget {
  final CameraPosition initialCameraPosition;
  final IconData markerIcon;
  final double markerIconSize;
  final Color markerIconColor;
  final MapType mapType;
  final bool myLocationButtonEnabled;
  final bool myLocationEnabled;
  final bool zoomGesturesEnabled;
  final Set<Marker> markers;
  final void Function(LatLng) onTap;
  final EdgeInsets padding;
  final bool buildingsEnabled;
  final CameraTargetBounds cameraTargetBounds;
  final Set<Circle> circles;
  final bool compassEnabled;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;
  final bool indoorViewEnabled;
  final bool mapToolbarEnabled;
  final MinMaxZoomPreference minMaxZoomPreference;
  final void Function() onCameraIdle;
  final void Function() onCameraMoveStarted;
  final void Function(LatLng) onLongPress;
  final Set<Polygon> polygons;
  final Set<Polyline> polylines;
  final bool rotateGesturesEnabled;
  final bool scrollGesturesEnabled;
  final bool tiltGesturesEnabled;
  final bool trafficEnabled;

  const LocationFieldDialog({
    Key key,
    this.initialCameraPosition,
    this.mapType,
    this.markerIcon,
    this.markerIconSize,
    this.markerIconColor,
    this.myLocationButtonEnabled,
    this.myLocationEnabled,
    this.zoomGesturesEnabled,
    this.markers,
    this.onTap,
    this.padding,
    this.buildingsEnabled,
    this.cameraTargetBounds,
    this.circles,
    this.compassEnabled,
    this.gestureRecognizers,
    this.indoorViewEnabled,
    this.mapToolbarEnabled,
    this.minMaxZoomPreference,
    this.onCameraIdle,
    this.onCameraMoveStarted,
    this.onLongPress,
    this.polygons,
    this.polylines,
    this.rotateGesturesEnabled,
    this.scrollGesturesEnabled,
    this.tiltGesturesEnabled,
    this.trafficEnabled,
  }) : super(key: key);

  @override
  _LocationFieldDialogState createState() => _LocationFieldDialogState();
}

class _LocationFieldDialogState extends State<LocationFieldDialog> {
  final Completer<GoogleMapController> _controllerCompleter = Completer();
  CameraPosition _value;

  @override
  void initState() {
    _value = widget.initialCameraPosition;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          Navigator.of(context).pop(_value);
        },
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          var maxWidth = constraints.biggest.width;
          var maxHeight = constraints.biggest.height;

          return Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                height: maxHeight,
                width: maxWidth,
                child: GoogleMap(
                  initialCameraPosition: widget.initialCameraPosition ??
                      CameraPosition(
                        target: LatLng(37.42796133580664, -122.085749655962),
                        zoom: 14.4746,
                      ),
                  onMapCreated: (GoogleMapController controller) {
                    if (!_controllerCompleter.isCompleted) {
                      _controllerCompleter.complete(controller);
                    }
                  },
                  onCameraMove: (CameraPosition newPosition) {
                    _value = newPosition;
                  },
                  mapType: widget.mapType,
                  myLocationButtonEnabled: widget.myLocationButtonEnabled,
                  myLocationEnabled: widget.myLocationEnabled,
                  zoomGesturesEnabled: widget.zoomGesturesEnabled,
                  markers: widget.markers,
                  onTap: widget.onTap,
                  padding: widget.padding,
                  buildingsEnabled: widget.buildingsEnabled,
                  cameraTargetBounds: widget.cameraTargetBounds,
                  circles: widget.circles,
                  compassEnabled: widget.compassEnabled,
                  gestureRecognizers: widget.gestureRecognizers,
                  indoorViewEnabled: widget.indoorViewEnabled,
                  mapToolbarEnabled: widget.mapToolbarEnabled,
                  minMaxZoomPreference: widget.minMaxZoomPreference,
                  onCameraIdle: widget.onCameraIdle,
                  onCameraMoveStarted: widget.onCameraMoveStarted,
                  onLongPress: widget.onLongPress,
                  polygons: widget.polygons,
                  polylines: widget.polylines,
                  rotateGesturesEnabled: widget.rotateGesturesEnabled,
                  scrollGesturesEnabled: widget.scrollGesturesEnabled,
                  tiltGesturesEnabled: widget.tiltGesturesEnabled,
                  trafficEnabled: widget.trafficEnabled,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: Icon(
                        Icons.close,
                        color: Theme.of(context).textTheme.bodyText1.color,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(null);
                      },
                      mini: true,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: maxHeight / 2,
                right: (maxWidth - widget.markerIconSize) / 2,
                child: Container(
                  // key: Key(),
                  child: Icon(
                    widget.markerIcon,
                    size: widget.markerIconSize,
                    color: widget.markerIconColor,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
