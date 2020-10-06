import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/widgets/location_field_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FormBuilderLocationField extends FormBuilderField<CameraPosition> {
  /// Callback method for when the map is ready to be used.
  ///
  /// Used to receive a [GoogleMapController] for this [GoogleMap].
  final MapCreatedCallback onMapCreated;

  /// The initial position of the map's camera.
  final CameraPosition initialCameraPosition;

  /// True if the map should show a compass when rotated.
  final bool compassEnabled;

  /// True if the map should show a toolbar when you interact with the map. Android only.
  final bool mapToolbarEnabled;

  /// Geographical bounding box for the camera target.
  final CameraTargetBounds cameraTargetBounds;

  /// Type of map tiles to be rendered.
  final MapType mapType;

  /// Preferred bounds for the camera zoom level.
  ///
  /// Actual bounds depend on map data and device.
  final MinMaxZoomPreference minMaxZoomPreference;

  /// True if the map view should respond to rotate gestures.
  final bool rotateGesturesEnabled;

  /// True if the map view should respond to scroll gestures.
  final bool scrollGesturesEnabled;

  /// True if the map view should show zoom controls. This includes two buttons
  /// to zoom in and zoom out. The default value is to show zoom controls.
  ///
  /// This is only supported on Android. And this field is silently ignored on iOS.
  final bool zoomControlsEnabled;

  /// True if the map view should respond to zoom gestures.
  final bool zoomGesturesEnabled;

  /// True if the map view should be in lite mode. Android only.
  ///
  /// See https://developers.google.com/maps/documentation/android-sdk/lite#overview_of_lite_mode for more details.
  final bool liteModeEnabled;

  /// True if the map view should respond to tilt gestures.
  final bool tiltGesturesEnabled;

  /// Padding to be set on map. See https://developers.google.com/maps/documentation/android-sdk/map#map_padding for more details.
  final EdgeInsets padding;

  /// Markers to be placed on the map.
  final Set<Marker> markers;

  /// Polygons to be placed on the map.
  final Set<Polygon> polygons;

  /// Polylines to be placed on the map.
  final Set<Polyline> polylines;

  /// Circles to be placed on the map.
  final Set<Circle> circles;

  /// Called when the camera starts moving.
  ///
  /// This can be initiated by the following:
  /// 1. Non-gesture animation initiated in response to user actions.
  ///    For example: zoom buttons, my location button, or marker clicks.
  /// 2. Programmatically initiated animation.
  /// 3. Camera motion initiated in response to user gestures on the map.
  ///    For example: pan, tilt, pinch to zoom, or rotate.
  final VoidCallback onCameraMoveStarted;

  /// Called repeatedly as the camera continues to move after an
  /// onCameraMoveStarted call.
  ///
  /// This may be called as often as once every frame and should
  /// not perform expensive operations.
  final CameraPositionCallback onCameraMove;

  /// Called when camera movement has ended, there are no pending
  /// animations and the user has stopped interacting with the map.
  final VoidCallback onCameraIdle;

  /// Called every time a [GoogleMap] is tapped.
  final ArgumentCallback<LatLng> onTap;

  /// Called every time a [GoogleMap] is long pressed.
  final ArgumentCallback<LatLng> onLongPress;

  /// True if a "My Location" layer should be shown on the map.
  ///
  /// This layer includes a location indicator at the current device location,
  /// as well as a My Location button.
  /// * The indicator is a small blue dot if the device is stationary, or a
  /// chevron if the device is moving.
  /// * The My Location button animates to focus on the user's current location
  /// if the user's location is currently known.
  ///
  /// Enabling this feature requires adding location permissions to both native
  /// platforms of your app.
  /// * On Android add either
  /// `<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />`
  /// or `<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />`
  /// to your `AndroidManifest.xml` file. `ACCESS_COARSE_LOCATION` returns a
  /// location with an accuracy approximately equivalent to a city block, while
  /// `ACCESS_FINE_LOCATION` returns as precise a location as possible, although
  /// it consumes more battery power. You will also need to request these
  /// permissions during run-time. If they are not granted, the My Location
  /// feature will fail silently.
  /// * On iOS add a `NSLocationWhenInUseUsageDescription` key to your
  /// `Info.plist` file. This will automatically prompt the user for permissions
  /// when the map tries to turn on the My Location layer.
  final bool myLocationEnabled;

  /// Enables or disables the my-location button.
  ///
  /// The my-location button causes the camera to move such that the user's
  /// location is in the center of the map. If the button is enabled, it is
  /// only shown when the my-location layer is enabled.
  ///
  /// By default, the my-location button is enabled (and hence shown when the
  /// my-location layer is enabled).
  ///
  /// See also:
  ///   * [myLocationEnabled] parameter.
  final bool myLocationButtonEnabled;

  /// Enables or disables the indoor view from the map
  final bool indoorViewEnabled;

  /// Enables or disables the traffic layer of the map
  final bool trafficEnabled;

  /// Enables or disables showing 3D buildings where available
  final bool buildingsEnabled;

  /// Which gestures should be consumed by the map.
  ///
  /// It is possible for other gesture recognizers to be competing with the map on pointer
  /// events, e.g if the map is inside a [ListView] the [ListView] will want to handle
  /// vertical drags. The map will claim gestures that are recognized by any of the
  /// recognizers on this list.
  ///
  /// When this set is empty or null, the map will only handle pointer events for gestures that
  /// were not claimed by any other gesture recognizer.
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;

  //TODO: Add documentation
  final IconData markerIcon;
  final double markerIconSize;
  final Color markerIconColor;
  final double height;
  final bool allowClear;
  final Widget clearIcon;

  // final TextEditingController textEditingController;

  FormBuilderLocationField({
    Key key,
    //From Super
    @required String name,
    FormFieldValidator validator,
    CameraPosition initialValue,
    bool readOnly = false,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<CameraPosition> onChanged,
    ValueTransformer valueTransformer,
    bool enabled = true,
    FormFieldSetter onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    VoidCallback onReset,
    FocusNode focusNode,
    this.allowClear = true,
    this.clearIcon = const Icon(Icons.close),
    this.markerIcon = Icons.person_pin_circle_sharp,
    this.markerIconSize = 30,
    this.markerIconColor = Colors.black,
    this.height = 300,
    this.compassEnabled = true,
    this.mapToolbarEnabled = true,
    this.cameraTargetBounds = CameraTargetBounds.unbounded,
    this.mapType = MapType.normal,
    this.minMaxZoomPreference = MinMaxZoomPreference.unbounded,
    this.rotateGesturesEnabled = true,
    this.scrollGesturesEnabled = true,
    this.zoomGesturesEnabled = true,
    this.tiltGesturesEnabled = true,
    this.myLocationEnabled = false,
    this.myLocationButtonEnabled = true,
    this.padding = const EdgeInsets.all(0),
    this.indoorViewEnabled = false,
    this.trafficEnabled = false,
    this.buildingsEnabled = true,
    this.zoomControlsEnabled = true,
    this.liteModeEnabled = false,
    this.markers,
    this.onTap,
    this.circles,
    this.gestureRecognizers,
    this.onCameraIdle,
    this.onCameraMoveStarted,
    this.onLongPress,
    this.polygons,
    this.polylines,
    this.onMapCreated,
    this.initialCameraPosition,
    this.onCameraMove,
  }) : super(
          key: key,
          initialValue: initialValue,
          name: name,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          readOnly: readOnly,
          autovalidateMode: autovalidateMode,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          builder: (FormFieldState field) {
            final _FormBuilderLocationFieldState state = field;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    decoration: decoration.copyWith(
                      errorText: decoration?.errorText ?? field.errorText,
                      enabled: !state.readOnly,
                    ),
                    enabled: !state.readOnly,
                    readOnly: true,
                    controller: state.effectiveController,
                    focusNode: state.effectiveFocusNode,
                    // style: style,
                    // autofocus: autofocus,
                  ),
                ),
                if (allowClear && !state.readOnly && state.value != null)
                  InkWell(
                    child: clearIcon,
                    onTap: () {
                      state.didChange(null);
                      FocusScope.of(state.context).requestFocus(FocusNode());
                    },
                  ),
              ],
            );
          },
        );

  @override
  _FormBuilderLocationFieldState createState() =>
      _FormBuilderLocationFieldState();
}

class _FormBuilderLocationFieldState
    extends FormBuilderFieldState<CameraPosition> {
  @override
  FormBuilderLocationField get widget =>
      super.widget as FormBuilderLocationField;
  TextEditingController _controller;

  TextEditingController get effectiveController =>
      /*widget.textEditingController ??*/ _controller;

  String get valueString => value?.target?.toString() ?? '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    effectiveController.text = valueString;
    effectiveFocusNode.addListener(_handleFocus);
  }

  Future<void> _handleFocus() async {
    if (effectiveFocusNode.hasFocus && !readOnly) {
      await Future.microtask(
          () => FocusScope.of(context).requestFocus(FocusNode()));
      var newValue = await showDialog<CameraPosition>(
        context: context,
        builder: (context) => LocationFieldDialog(
          initialCameraPosition: value ?? widget.initialCameraPosition,
          onTap: widget.onTap,
          buildingsEnabled: widget.buildingsEnabled,
          padding: widget.padding,
          cameraTargetBounds: widget.cameraTargetBounds,
          circles: widget.circles,
          compassEnabled: widget.compassEnabled,
          gestureRecognizers: widget.gestureRecognizers,
          indoorViewEnabled: widget.indoorViewEnabled,
          mapToolbarEnabled: widget.mapToolbarEnabled,
          mapType: widget.mapType,
          markerIcon: widget.markerIcon,
          markerIconColor: widget.markerIconColor,
          markerIconSize: widget.markerIconSize,
          markers: widget.markers,
          minMaxZoomPreference: widget.minMaxZoomPreference,
          myLocationButtonEnabled: widget.myLocationButtonEnabled,
          myLocationEnabled: widget.myLocationEnabled,
          onCameraIdle: widget.onCameraIdle,
          onCameraMoveStarted: widget.onCameraMoveStarted,
          onLongPress: widget.onLongPress,
          polygons: widget.polygons,
          polylines: widget.polylines,
          rotateGesturesEnabled: widget.rotateGesturesEnabled,
          scrollGesturesEnabled: widget.scrollGesturesEnabled,
          tiltGesturesEnabled: widget.tiltGesturesEnabled,
          trafficEnabled: widget.trafficEnabled,
          zoomGesturesEnabled: widget.zoomGesturesEnabled,
          liteModeEnabled: widget.liteModeEnabled,
          zoomControlsEnabled: widget.zoomControlsEnabled,
          onCameraMove: widget.onCameraMove,
          onMapCreated: widget.onMapCreated,
        ),
      );
      if (newValue != null) {
        didChange(newValue);
      }
    }
  }

  @override
  void didChange(CameraPosition value) {
    super.didChange(value);
    effectiveController.text = valueString ?? '';
  }
}
