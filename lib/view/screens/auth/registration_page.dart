import 'dart:io';
import 'dart:typed_data';

import 'package:carcheck/dialog/animated_custom_dialog.dart';
import 'package:carcheck/dialog/my_dialog.dart';
import 'package:carcheck/locator.dart';
import 'package:carcheck/provider/address_provider.dart';
import 'package:carcheck/provider/auth_provider.dart';
import 'package:carcheck/provider/garage_provider.dart';
import 'package:carcheck/util/color-resource.dart';
import 'package:carcheck/util/constants.dart';
import 'package:carcheck/view/base_widgets/custom_button.dart';
import 'package:carcheck/view/base_widgets/registration_text_field.dart';
import 'package:carcheck/view/screens/auth/login_page.dart';
import 'package:carcheck/view/screens/customer/customer_dashboard.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'join_us_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  bool isCustomer,isgarageOwner;
  RegistrationScreen(this.isCustomer,this.isgarageOwner, {Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController garageInfoController = TextEditingController();
  TextEditingController openHrsController = TextEditingController();
  TextEditingController closeHrsController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController garageNameController = TextEditingController();
  TextEditingController garageAddressController = TextEditingController();
  TextEditingController garageMobileNoController = TextEditingController();
  TextEditingController garageEmailIdController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController longController = TextEditingController();
  TextEditingController garagePhotoController = TextEditingController();

  String location ='Null, Press Button';
  String Address = 'searching current location.......';

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  Placemark? place;
  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    place = placemarks[0];
    Address = '${place!.street}, ${place!.subLocality}, ${place!.locality}, ${place!.subAdministrativeArea}, ${place!.postalCode}, ${place!.country}';
    setState(()  {
    });
  }

  getCurrentLocation() async {
    Position position = await _getGeoLocationPosition();
    location ='Lat: ${position.latitude} , Long: ${position.longitude}';
    GetAddressFromLatLong(position);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  final _formKey = GlobalKey<FormState>();
  final now = DateTime.now();
  String formatter = '';
  AddressProvider addressProvider = locator<AddressProvider>();
  GarageProvider garageProvider = locator<GarageProvider>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    formatter = DateFormat('yMd').format(now);
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, model, child) => Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: DrawClip2(),
                  child: Container(
                    width: size.width,
                    height: size.height * 0.3,
                    decoration: BoxDecoration(
                        // color: ColorResources.BUTTON_COLOR
                        gradient: LinearGradient(
                            colors: [Color(0xffa58fd2), Color(0xffddc3fc)],
                            begin: Alignment.bottomCenter,
                            end: Alignment.bottomRight)),
                  ),
                ),
                ClipPath(
                  clipper: DrawClip(),
                  child: Container(
                    width: size.width,
                    height: size.height * 0.3,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      ColorResources.PRIMARY_COLOR,
                      Color(0xff91c5fc)
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                  ),
                ),
                Positioned(
                  top: 50,
                  child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: model.image==''?
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[100],
                          /*image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/images/1.jpg')*/
                        ),
                        child: Icon(Icons.account_circle_outlined),
                      ):
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[100],
                          image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(model.image)
                        ),
                      )
                  ),
                  )
                ),
                Positioned(
                  top: 125,
                  child: Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: InkWell(
                        onTap: (){
                          pickFile(model);
                        },
                        child: Container(
                            width: 30.0,
                            height: 30.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[500],
                            ),
                            child: Icon(Icons.add)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RegistrationTextFeild(
                      controller: fnameController,
                      hintText: "First Name",
                      textInputType: TextInputType.text,
                      iconData: Icons.person,
                    ),
                    RegistrationTextFeild(
                      controller: lnameController,
                      hintText: "Last Name",
                      textInputType: TextInputType.text,
                      iconData: Icons.person,
                    ),
                    RegistrationTextFeild(
                        controller: mobileController,
                        hintText: "Mobile Number",
                        textInputType: TextInputType.phone,
                        iconData: Icons.phone_android),
                    RegistrationTextFeild(
                        controller: emailController,
                        hintText: "Email Id",
                        textInputType: TextInputType.emailAddress,
                        iconData: Icons.email),
                    RegistrationTextFeild(
                        controller: passwordController,
                        hintText: "Password",
                        textInputType: TextInputType.visiblePassword,
                        iconData: Icons.lock),
                    widget.isgarageOwner?RegistrationTextFeild(
                        controller: garageNameController,
                        hintText: "Garage Name",
                        textInputType: TextInputType.visiblePassword,
                        iconData: Icons.lock):SizedBox.shrink(),
                    widget.isgarageOwner?RegistrationTextFeild(
                        controller: garageInfoController,
                        hintText: "Garage Info",
                        textInputType: TextInputType.visiblePassword,
                        iconData: Icons.lock):SizedBox.shrink(),
                    widget.isgarageOwner?RegistrationTextFeild(
                        controller: websiteController,
                        hintText: "Website",
                        textInputType: TextInputType.visiblePassword,
                        iconData: Icons.lock):SizedBox.shrink(),
                    widget.isgarageOwner?RegistrationTextFeild(
                        controller: garageMobileNoController,
                        hintText: "Garage Mobile Number",
                        textInputType: TextInputType.visiblePassword,
                        iconData: Icons.lock):SizedBox.shrink(),
                    widget.isgarageOwner?RegistrationTextFeild(
                        controller: garageEmailIdController,
                        hintText: "Garage Email Id",
                        textInputType: TextInputType.visiblePassword,
                        iconData: Icons.lock):SizedBox.shrink(),
                    widget.isgarageOwner?RegistrationTextFeild(
                        controller: garageAddressController,
                        hintText: "Garage Address",
                        textInputType: TextInputType.visiblePassword,
                        iconData: Icons.lock):SizedBox.shrink(),
                    widget.isgarageOwner?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: RegistrationTextFeild(
                              controller: openHrsController,
                              hintText: "Opening Time",
                              textInputType: TextInputType.visiblePassword,
                              iconData: Icons.lock),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: RegistrationTextFeild(
                              controller: closeHrsController,
                              hintText: "Closing Time",
                              textInputType: TextInputType.visiblePassword,
                              iconData: Icons.lock),
                        )
                      ],
                    ):SizedBox.shrink(),
                    widget.isgarageOwner?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: RegistrationTextFeild(
                              controller: latController,
                              hintText: "Latitude",
                              textInputType: TextInputType.visiblePassword,
                              iconData: Icons.lock),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: RegistrationTextFeild(
                              controller: longController,
                              hintText: "Longitude",
                              textInputType: TextInputType.visiblePassword,
                              iconData: Icons.lock),
                        )
                      ],
                    ):SizedBox.shrink(),
                    widget.isgarageOwner?Container(
                      margin:EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                        onTap: (){
                          pickFile(model);
                        },
                          controller: garagePhotoController,
                          readOnly: true,
                          decoration: InputDecoration(
                              labelText: "Garage Photo",
                              hintText: "click here to add garage photo",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              border: const OutlineInputBorder())),
                    ):SizedBox.shrink(),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      child: CustomButton(
                        buttonText: 'Register',
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => LoginPage()));
                          widget.isCustomer?model
                              .saveUser(
                              active: true,
                              created: formatter,
                              created_by: fnameController.text,
                              device_id: '',
                              emailid: emailController.text,
                              first_name: fnameController.text,
                              last_name: lnameController.text,
                              mobilenumber: mobileController.text,
                              garrage_Owner: false,
                              image_url: '',
                              operating_system: 'Android',
                              payment_mode: true,
                              verified: true,
                              updated: formatter,
                              updated_by: fnameController.text,
                              password: passwordController.text,
                              )
                              .then((value) => {
                            print(value),

                            addressProvider.saveAddress(
                              active: true,
                              created: formatter,
                              created_by: fnameController.text,
                              updated_by: formatter,
                              updated: fnameController.text,
                              landmark: place!.locality,
                              name: place!.subLocality,
                              street: place!.street,
                              zipcode: place!.postalCode,
                              garrageAddress: false,
                              user_id: value,
                              city_id: 1,
                            ).then((value) => {
                          print(value),
                          showAnimatedDialog(
                          context,
                          MyDialog(
                          icon: Icons.check,
                          title: 'Registration',
                          description:
                          'Successfully registered',
                          isFailed: false,
                          ),
                          dismissible: false,
                          isFlip: false),
                          Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                          builder: (builder) => LoginPage()))
                          })
                          }):model
                              .saveUser(
                              active: true,
                              created: formatter,
                              created_by: fnameController.text,
                              device_id: '',
                              emailid: emailController.text,
                              first_name: fnameController.text,
                              last_name: lnameController.text,
                              mobilenumber: mobileController.text,
                              garrage_Owner: true,
                              image_url: '',
                              operating_system: '',
                              payment_mode: true,
                              verified: true,
                              updated: formatter,
                              updated_by: fnameController.text,
                              password: passwordController.text,
                             )
                              .then((value) => {
                            print(value),

                            garageProvider.addGarage(
                              isActive: true,
                              created: formatter,
                              created_by: fnameController.text,
                              updated_by: formatter,
                              updated: fnameController.text,
                              lat: latController.text,
                              long: longController.text,
                              isPopular: true,
                              isVerified: false,
                              rating: 5,
                              name: garageNameController.text,
                              photo: garagePhotoController.text,
                              image_url: garagePhotoController.text,
                              openingTime: openHrsController.text,
                              closingTime: closeHrsController.text,
                              emailId: garageInfoController.text,
                              mobile: int.parse(garageMobileNoController.text),
                              noOfratings: 100,
                              verificationId: '',
                              password: passwordController.text,
                              website: websiteController.text,
                              description: garageInfoController.text,
                              userId: value,
                              addressId: 1,
                            ).then((value) => {
                              print(value),
                              showAnimatedDialog(
                                  context,
                                  MyDialog(
                                    icon: Icons.check,
                                    title: 'Registration',
                                    description:
                                    'Successfully registered',
                                    isFailed: false,
                                  ),
                                  dismissible: false,
                                  isFlip: false),
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => LoginPage()))
                            })
                          });

                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have account?",
                            style: GoogleFonts.ubuntu(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (builder) => LoginPage()));
                            },
                            child: Text("Login",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff5172b4),
                                  fontWeight: FontWeight.bold,
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }

  PlatformFile? objFile;
  File? imagefile;
  Uint8List? imageBytes;
  String? fileName;

  pickFile(AuthProvider model) async {
    var result = await FilePicker.platform.pickFiles(
      withReadStream:
      true, // this will return PlatformFile object with read stream
    );
    if (result != null) {
      /* setState(() {
        objFile = result.files.single;
      });*/
      try {
        fileName = result.files.first.name;
        print(result.files.first.toString());
        //imagefile = File(result.files.first.name);
        imageBytes = result.files.first.bytes;
        objFile = result.files.single;
        print('ncmdvndkjvnfdvnfdvmnfdvmfvnfdmvnfmvfvfdvnfdvmnfvfvf-------------------------------------------------------------------------');
        print(fileName);
        model.setImage(fileName);

      } catch (ex) {
        throw Exception("Exception Occurred ${ex.toString()}");
      }
    }
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
