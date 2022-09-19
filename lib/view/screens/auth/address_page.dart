import 'package:carcheck/dialog/animated_custom_dialog.dart';
import 'package:carcheck/dialog/my_dialog.dart';
import 'package:carcheck/locator.dart';
import 'package:carcheck/model/address_model.dart';
import 'package:carcheck/model/address_model.dart';
import 'package:carcheck/model/city_model.dart';
import 'package:carcheck/provider/address_provider.dart';
import 'package:carcheck/provider/auth_provider.dart';
import 'package:carcheck/util/color-resource.dart';
import 'package:carcheck/util/style.dart';
import 'package:carcheck/view/base_widgets/custom_appbar.dart';
import 'package:carcheck/view/base_widgets/custom_button.dart';
import 'package:carcheck/view/base_widgets/registration_text_field.dart';
import 'package:carcheck/view/screens/auth/address_page.dart';
import 'package:carcheck/view/screens/auth/vehicle_page.dart';
import 'package:carcheck/view/screens/customer/customer_dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../model/address_model.dart';

class AddressPage extends StatefulWidget {
  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController streetController = TextEditingController();
  TextEditingController subLocalityController = new TextEditingController();
  TextEditingController localityController = new TextEditingController();
  TextEditingController zipCodeController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();

  final authProvider = locator<AuthProvider>();
  final addressProvider = locator<AddressProvider>();
  final now = DateTime.now();
  String formatter = '';

  String location = 'Null, Press Button';
  String Address = 'searching current location.......';

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Placemark? place;

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    place = placemarks[0];
    Address =
        '${place!.street}, ${place!.subLocality}, ${place!.locality}, ${place!.subAdministrativeArea}, ${place!.postalCode}, ${place!.country}';
    setState(() {});
  }

  getCurrentLocation() async {
    Position position = await _getGeoLocationPosition();
    location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
    GetAddressFromLatLong(position);
  }

  setAddressValue(){
    streetController.text = addressProvider.addressObj!.street.toString();
    localityController.text = addressProvider.addressObj!.name.toString();
    subLocalityController.text = addressProvider.addressObj!.landmark.toString();
    nameController.text = addressProvider.addressObj!.name.toString();
    zipCodeController.text = addressProvider.addressObj!.zipCode.toString();
    cityController.text = addressProvider.city!.city.toString();
    stateController.text = addressProvider.city!.state.toString();
    countryController.text = addressProvider.city!.country.toString();
  }
  getData() async {
    await addressProvider.getAddressById(authProvider.userDetails!.id).then((value) async => {await addressProvider.getCityByCityId(value.cityId)});
  }
  @override
  void initState() {
    //getData();
    getCurrentLocation();
    authProvider.getUserDetails(authProvider.userDetails!.id);
    formatter = DateFormat('yMd').format(now);
    setAddressValue();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBarWidget(context, _scaffoldKey, "Address Details"),
      body: SingleChildScrollView(
        child: Consumer<AddressProvider>(
          builder: (context, model, child) => Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 50),
                child: InkWell(
                  child: Text(
                    "Use Current Location to fill All Address Details",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffea6935),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) => CupertinoAlertDialog(
                              title: Text(
                                'Are you sure want to use your current location to fill All Address Details?',
                                style: Style.heading,
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Yes', style: Style.okButton),
                                  onPressed: () {
                                    streetController.text =
                                        place!.street!.toString();
                                    localityController.text =
                                        place!.locality!.toString();
                                    subLocalityController.text =
                                        place!.subLocality!.toString();
                                    nameController.text =
                                        place!.name!.toString();
                                    zipCodeController.text =
                                        place!.postalCode!.toString();
                                    cityController.text = place!
                                        .subAdministrativeArea!
                                        .toString();
                                    stateController.text =
                                        place!.administrativeArea!.toString();
                                    countryController.text =
                                        place!.country!.toString();
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('No', style: Style.cancelButton),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ));
                  },
                ),
              ),
              RegistrationTextFeild(
                controller: streetController,
                hintText: "Street Name",
                textInputType: TextInputType.text,
                iconData: Icons.apartment,
              ),
              RegistrationTextFeild(
                controller: subLocalityController,
                hintText: "Sub Locality",
                textInputType: TextInputType.text,
                iconData: Icons.location_pin,
              ),
              RegistrationTextFeild(
                  controller: localityController,
                  hintText: "Locality",
                  textInputType: TextInputType.phone,
                  iconData: Icons.apartment),
              RegistrationTextFeild(
                  controller: cityController,
                  hintText: "City",
                  textInputType: TextInputType.emailAddress,
                  iconData: Icons.location_city),
              RegistrationTextFeild(
                controller: zipCodeController,
                hintText: "Zip Code",
                textInputType: TextInputType.text,
                iconData: Icons.location_pin,
              ),
              RegistrationTextFeild(
                  controller: stateController,
                  hintText: "State",
                  textInputType: TextInputType.phone,
                  iconData: Icons.location_city),
              RegistrationTextFeild(
                  controller: countryController,
                  hintText: "Country",
                  textInputType: TextInputType.emailAddress,
                  iconData: Icons.location_pin),
              CustomButton(
                  onTap: () async {
                      model.updateAddress(
                        active: true,
                        created: '28/07/2022',
                        created_by: 'Swati',
                        updated: '28/07/2022',
                        updated_by: 'Swati',
                        user_id: authProvider.userDetails!.id,
                        city_id: 1,
                        garrageAddress: false,
                        name: localityController.text,
                        landmark: localityController.text,
                        street: streetController.text,
                        zipcode: zipCodeController.text,
                      ).then((value) => {
                        print(value),
                        showAnimatedDialog(
                            context,
                            MyDialog(
                              icon: Icons.check,
                              title: 'Update Address',
                              description:
                              'Your address updated successfully',
                              isFailed: false,
                            ),
                            dismissible: false,
                            isFlip: false),

                      });

                  },
                  buttonText: 'Save'),

            ],
          ),
        ),
      ),
    );
  }

  bool _isObscure = true;

  Widget input(String hint, bool pass) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.white),
        child: TextFormField(
          obscureText: pass ? _isObscure : false,
          //obscuringCharacter: pass? '*' : '',
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.ubuntu(color: Colors.grey),
              contentPadding: EdgeInsets.only(top: 15, bottom: 15),
              prefixIcon: pass
                  ? Icon(
                      Icons.lock_outline,
                      color: Colors.grey,
                    )
                  : Icon(
                      Icons.person_outline,
                      color: Colors.grey,
                    ),
              suffixIcon: pass
                  ? IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        /*setState(() {
                          _isObscure = !_isObscure;
                        });*/
                      },
                    )
                  : null,
              border: UnderlineInputBorder(borderSide: BorderSide.none)),
        ),
      ),
    );
  }
}

class DrawClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.80);
    path.cubicTo(size.width / 4, size.height, 3 * size.width / 4,
        size.height / 2, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class DrawClip2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.80);
    path.cubicTo(size.width / 4, size.height, 3 * size.width / 4,
        size.height / 2, size.width, size.height * 0.9);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
