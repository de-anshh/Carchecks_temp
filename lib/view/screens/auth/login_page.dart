import 'package:carcheck/provider/auth_provider.dart';
import 'package:carcheck/util/color-resource.dart';
import 'package:carcheck/util/style.dart';
import 'package:carcheck/view/base_widgets/custom_button.dart';
import 'package:carcheck/view/screens/auth/join_us_screen.dart';
import 'package:carcheck/view/screens/customer/customer_dashboard.dart';
import 'package:carcheck/view/screens/customer/garage/garage_dashboard.dart';
import '../customer/service_search.dart';
import '../garage_owner/garage_services/choose_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool garageOwnerLogin = false, customerLogin = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<AuthProvider>(
          builder: (context, model, child) => Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: DrawClip2(),
                    child: Container(
                      width: size.width,
                      height: size.height * 0.8,
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
                      height: size.height * 0.8,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                        ColorResources.PRIMARY_COLOR,
                        Color(0xff91c5fc)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: Column(
                        children: [
                          Text(
                            "Welcome",
                            style: GoogleFonts.ubuntu(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          input("Username", false),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white),
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: _isObscure,
                                obscuringCharacter: '*',
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle:
                                        GoogleFonts.ubuntu(color: Colors.grey),
                                    contentPadding:
                                        EdgeInsets.only(top: 15, bottom: 15),
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: Colors.grey,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isObscure
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      },
                                    ),
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide.none)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 100,
                            child: customerLogin == true
                                ? CustomButton(
                                    buttonText: 'Login',
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        var result = await model
                                            .loginUsingMobileNumber(
                                                mobileController.text,passwordController.text)
                                            .then((value) {
                                              print("loginResponse :: ");
                                              print(value);
                                              if (mobileController.text != '') {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (builder) =>
                                                            CustomerDashboard()));
                                              } else {
                                                //   print(result['data']);
                                                showSimpleNotification(
                                                    Text(
                                                      "Please Register before login",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    background: Colors.black);
                                              }
                                        });
                                      }
                                    },
                                  )
                                : CustomButton(
                                    buttonText: 'Login',
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        var result = await model
                                            .loginUsingMobileNumber(
                                                mobileController.text,passwordController.text);
                                        if (mobileController.text != '') {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (builder) =>
                                                      GarageDashboard()));
                                        } else {
                                          //   print(result['data']);
                                          showSimpleNotification(
                                              Text(
                                                "Please Register before login",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              background: Colors.black);
                                        }
                                      }
                                    },
                                  ),
                          ),
                          /*Text(
                            "Forget your password?",
                            style: GoogleFonts.ubuntu(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),*/
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                customerLogin == true
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Login for?",
                                            style: Style.newheading,
                                            textAlign: TextAlign.center,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                garageOwnerLogin = true;
                                                customerLogin = false;
                                              });
                                            },
                                            child: Text(" Garage Owner",
                                                style: Style.aleaready,
                                                textAlign: TextAlign.center),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Login for?",
                                              style: Style.newheading,
                                              textAlign: TextAlign.center),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                garageOwnerLogin = false;
                                                customerLogin = true;
                                              });
                                            },
                                            child: Text(" Customer",
                                                style: Style.aleaready,
                                                textAlign: TextAlign.center),
                                          ),
                                        ],
                                      ),
                                /*Row(
                  //  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Continue as a?",
                        style: Style.newheading,textAlign: TextAlign.center,),
                      InkWell(
                        onTap: (){
                          // Navigator.pushReplacement(context,
                          //     MaterialPageRoute(builder: (builder) => Registration()));
                        },
                        child: Text(" Guest",
                            style: Style.aleaready,textAlign: TextAlign.center),
                      ),
                    ],
                  )*/
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have account?",
                    style: GoogleFonts.ubuntu(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => JoinUsScreen()));
                    },
                    child: Text("Sign Up",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff5172b4),
                          fontWeight: FontWeight.bold,
                        )),
                  )
                ],
              )
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
          controller: mobileController,
          obscureText: pass ? _isObscure : false,
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
