

import 'package:carcheck/provider/address_provider.dart';
import 'package:carcheck/provider/auth_provider.dart';
import 'package:carcheck/provider/bid_provider.dart';
import 'package:carcheck/provider/fuel_provider.dart';
import 'package:carcheck/provider/garage_provider.dart';
import 'package:carcheck/provider/services_provider.dart';
import 'package:carcheck/provider/transaction_provider.dart';
import 'package:carcheck/provider/user_provider.dart';
import 'package:carcheck/provider/vehicle_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'provider/appointment_provider.dart';

GetIt locator = GetIt.asNewInstance();

Future<void> setupLocator() async {

  locator.registerLazySingleton(() => FuelProvider());
  locator.registerLazySingleton(() => GarageProvider());
  locator.registerLazySingleton(() => ServiceProvider());
  locator.registerLazySingleton(() => VehicleProvider());
  locator.registerLazySingleton(() => AddressProvider());
  locator.registerLazySingleton(() => BidProvider());
  locator.registerLazySingleton(() => TransactionProvider());
  locator.registerLazySingleton(() => UserProvider());
  locator.registerLazySingleton(() => AuthProvider());
  locator.registerLazySingleton(() => AppointmentProvider());
 /* locator.registerLazySingleton(() => BidProvider());
  locator.registerLazySingleton(() => OrgProvider());
  locator.registerLazySingleton(() => FleetProvider());
  locator.registerLazySingleton(() => PlanProvider());
  locator.registerLazySingleton(() => LocalizationProvider(sharedPreferences: locator()));
*/
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
}
