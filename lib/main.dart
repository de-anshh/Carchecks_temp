import 'package:carcheck/locator.dart';
import 'package:carcheck/provider/address_provider.dart';
import 'package:carcheck/provider/auth_provider.dart';
import 'package:carcheck/provider/bid_provider.dart';
import 'package:carcheck/provider/fuel_provider.dart';
import 'package:carcheck/provider/garage_provider.dart';
import 'package:carcheck/provider/services_provider.dart';
import 'package:carcheck/provider/transaction_provider.dart';
import 'package:carcheck/provider/user_provider.dart';
import 'package:carcheck/provider/vehicle_provider.dart';
import 'package:carcheck/view/screens/auth/login_page.dart';
import 'package:carcheck/view/screens/customer/map_screen.dart';
import 'provider/appointment_provider.dart';
import 'view/screens/auth/join_us_screen.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  runApp(OverlaySupport.global(
      child: MultiProvider(
        providers: [

          ChangeNotifierProvider(create: (_) => locator<FuelProvider>()),
          ChangeNotifierProvider(create: (_) => locator<GarageProvider>()),
          ChangeNotifierProvider(create: (_) => locator<ServiceProvider>()),
          ChangeNotifierProvider(create: (_) => locator<VehicleProvider>()),
          ChangeNotifierProvider(create: (_) => locator<AddressProvider>()),
          ChangeNotifierProvider(create: (_) => locator<BidProvider>()),
          ChangeNotifierProvider(create: (_) => locator<TransactionProvider>()),
          ChangeNotifierProvider(create: (_) => locator<UserProvider>()),
          ChangeNotifierProvider(create: (_) => locator<AuthProvider>()),
          ChangeNotifierProvider(create: (_) => locator<AppointmentProvider>()),
        ],
        child: MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Checks',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

