import 'package:app_captusiat/core/utils/use_case.dart';
import 'package:app_captusiat/features/location/domain/usecases/get_location_updates_usecase.dart';
import 'package:app_captusiat/features/location/domain/usecases/get_location_usecase.dart';
import 'package:app_captusiat/features/location/domain/usecases/request_location_permission_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  final RequestLocationPermissionUseCase requestPermissionUseCase;
  final GetLocationUseCase getLocationUseCase;
  final GetLocationUpdatesUseCase getLocationUpdatesUseCase;

  var locationError = ''.obs;
  var currentLocation = ''.obs;

  LocationController({
    required this.requestPermissionUseCase,
    required this.getLocationUseCase,
    required this.getLocationUpdatesUseCase,
  });

  Future<void> requestLocationPermission() async {
    final permissionResult = await requestPermissionUseCase.call(NoParams());
    permissionResult.fold(
      (failure) => locationError('Location permission denied'),
      (success) => getLocation(),
    );
  }

  Future<void> getLocation() async {
    final locationResult = await getLocationUseCase.call(NoParams());
    locationResult.fold(
      (failure) => locationError('Error getting location'),
      (location) => currentLocation(
          'Lat: ${location.latitude}, Long: ${location.longitude}'),
    );
  }

  void listenToLocationUpdates() {
    getLocationUpdatesUseCase().listen(
      (eitherPositionOrFailure) {
        eitherPositionOrFailure.fold(
          (failure) {
            debugPrint('fallo');
            // errorMessage.value = 'Error getting location updates';
          },
          (location) {
            debugPrint('ok');
            // currentPosition.value = position;
            // errorMessage.value = '';
            debugPrint(
                'Lat: ${location.latitude}, Long: ${location.longitude}');
          },
        );
      },
    );
  }
}
