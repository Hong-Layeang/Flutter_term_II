import 'package:provider/provider.dart';

import 'data/repositories/locations/location_repository.dart';
import 'data/repositories/locations/location_repository_mock.dart';
import 'data/repositories/ride_preferences/ride_preference_repository.dart';
import 'data/repositories/ride_preferences/ride_preference_repository_mock.dart';
import 'data/repositories/rides/ride_repository.dart';
import 'data/repositories/rides/ride_repository_mock.dart';
import 'main_common.dart';
import 'ui/states/ride_preferences_state.dart';

List<InheritedProvider> get devProviders {
  final ridePreferenceRepository = RidePreferenceRepositoryMock.instance;

  return [
    Provider<RidePreferenceRepository>.value(value: ridePreferenceRepository),
    Provider<RideRepository>.value(value: RideRepositoryMock.instance),
    Provider<LocationRepository>.value(value: LocationRepositoryMock.instance),
    ChangeNotifierProvider<RidePreferencesState>(
      create: (_) => RidePreferencesState(repository: ridePreferenceRepository),
    ),
  ];
}

void main() {
  mainCommon(devProviders);
}
