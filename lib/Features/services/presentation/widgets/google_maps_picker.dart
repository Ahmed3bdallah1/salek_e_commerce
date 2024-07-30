import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

import '../../../../core/functions/responsive.dart';
import '../../../../core/utils/const.dart';
import 'custom_button.dart';

class GoogleMapsLocation extends StatefulWidget {
  const GoogleMapsLocation({
    super.key,
    required this.location,
    this.isViewOnly = false,
    this.removePadding = false,
    this.onPlacePicked,
  });

  final ValueChanged<(LatLng, String?)>? onPlacePicked;

  final LatLng? location;
  final bool isViewOnly;
  final bool removePadding;

  @override
  State<GoogleMapsLocation> createState() => _GoogleMapsLocationState();
}

class _GoogleMapsLocationState extends State<GoogleMapsLocation> {
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    return Padding(
      padding: widget.removePadding
          ? EdgeInsets.zero
          : EdgeInsets.symmetric(horizontal: 11.w),
      child: SizedBox(
        height: 234.h,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              GoogleMap(
                onMapCreated: (controller) {
                  mapController = controller;
                },
                onLongPress: (latLng) {
                  if (widget.onPlacePicked != null) {
                    widget.onPlacePicked!((latLng, null));
                  }
                },
                gestureRecognizers: widget.isViewOnly
                    ? {}
                    : <Factory<OneSequenceGestureRecognizer>>{
                        Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer(),
                        ),
                      },
                myLocationButtonEnabled: false,
                zoomGesturesEnabled: true,
                markers: {
                  if (widget.location != null)
                    Marker(
                        markerId: MarkerId(
                            "${widget.location!.longitude} ${widget.location!.latitude}"),
                        position: widget.location!)
                },
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: widget.location ?? initialLatLong,
                  zoom: 14.4746,
                ),
              ),
              if (widget.onPlacePicked != null &&
                  widget.location == null &&
                  !widget.isViewOnly)
                Opacity(
                  opacity: 0.3,
                  child: Container(
                    color: Colors.white,
                    height: 234.h,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SvgPicture.asset(
                          "assets/عقارك-15.svg",
                          color: const Color(0xff656969),
                          height: 80,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomButton(
                          height: 35,
                          width: 180.w,
                          text: "Pick Location".tr,
                          onPressed: _pick,
                          color: const Color(0xff656969),
                        ),
                      ],
                    ),
                  ),
                ),
              if (widget.onPlacePicked != null &&
                  widget.location != null &&
                  !widget.isViewOnly)
                Opacity(
                  opacity: 0.5,
                  child: Align(
                    alignment: const AlignmentDirectional(0, 0.8),
                    child: CustomButton(
                      height: 35,
                      width: 180.w,
                      fontSize: 14,
                      text: "Edit Location".tr,
                      color: const Color(0xff656969),
                      onPressed: _pick,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  _pick() {
    Get.to(() => PlacePicker(
          key: UniqueKey(),
          hintText: 'Search a Place'.tr,
          useCurrentLocation: true,
          selectInitialPosition: true,
          apiKey: googleMapsApiKey,
          initialPosition: widget.location ?? initialLatLong,
          onPlacePicked: (a) {
            widget.onPlacePicked!((
              LatLng(a.geometry!.location.lat, a.geometry!.location.lng),
              a.formattedAddress
            ));
            mapController!.moveCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(
                        a.geometry!.location.lat, a.geometry!.location.lng),
                    zoom: 14.4746)));
            Get.back();
          },
        ));
  }
}
