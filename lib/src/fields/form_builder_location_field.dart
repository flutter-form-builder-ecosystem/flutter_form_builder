import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/src/widgets/location_field_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FormBuilderLocationField extends FormBuilderField<CameraPosition> {
  final IconData markerIcon;
  final double markerIconSize;
  final Color markerIconColor;
  final MapType mapType;
  final double height;
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
    this.markerIcon = Icons.person_pin_circle,
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
    this.markers,
    this.onTap,
    this.circles,
    this.gestureRecognizers,
    this.onCameraIdle,
    this.onCameraMoveStarted,
    this.onLongPress,
    this.polygons,
    this.polylines,
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
          initialCameraPosition: value,
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
