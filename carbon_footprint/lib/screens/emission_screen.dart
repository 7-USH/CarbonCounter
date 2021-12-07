// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, must_be_immutable

import 'package:carbon_footprint/constants/themes.dart';
import 'package:carbon_footprint/models/tiles.dart';
import 'package:carbon_footprint/screens/journery.dart';
import 'package:carbon_footprint/screens/login_screen.dart';
import 'package:carbon_footprint/screens/provider/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EmissionPage extends StatefulWidget {
  EmissionPage({Key? key}) : super(key: key);

  @override
  _EmissionPageState createState() => _EmissionPageState();
}

class _EmissionPageState extends State<EmissionPage> {
  bool _onCreatePage = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      _onCreatePage = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double pinVisible = size.height / 11;
    double pinInvisible = size.height / 1.2;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [kPrimeColor, kGreenOne, kGreenTwo])),
        child: Scaffold(
            bottomNavigationBar: EmissionBottomBar(size: size),
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.black,
                elevation: 0,
                leading: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios_new)),
                  ],
                )),
            body: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 25.0, right: 20.0),
                  height: size.height / 6,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Journey Time",
                        style: GoogleFonts.lobster(
                            color: Colors.white, fontSize: 40),
                      ),
                    ],
                  ),
                ),
                AnimatedPadding(
                  curve: Curves.easeInOutBack,
                  duration: Duration(seconds: 1),
                  padding: EdgeInsets.only(
                      top: _onCreatePage ? pinVisible : pinInvisible),
                  child: Container(
                    height: size.height * 4 / 6.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.19),
                              offset: const Offset(5, 7),
                              spreadRadius: 1,
                              blurRadius: 8),
                        ]),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("How are you travelling ?",
                              style: GoogleFonts.notoSans(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25,
                                  color: kTextColor)),
                          SizedBox(
                            height: 20,
                          ),
                          TransportList(),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Details",
                              style: GoogleFonts.notoSans(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25,
                                  color: kTextColor)),
                          SizedBox(
                            height: 20,
                          ),
                          Details()
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class EmissionBottomBar extends StatelessWidget {
  const EmissionBottomBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        padding: const EdgeInsets.only(bottom: 15, top: 10),
        height: size.height / 10,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [kPrimeColor, kGreenOne]),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.19),
                  offset: const Offset(1, -2),
                  spreadRadius: 1,
                  blurRadius: 8),
            ]),
        child: Center(
          child: GestureDetector(
            onTap: () {
              // TODO: next Page Map
              Navigator.pushNamed(context, JourneyCounter.id);
            },
            onTapDown: (details) => {},
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white.withOpacity(0.95),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.19),
                        offset: const Offset(1, 10),
                        spreadRadius: 1,
                        blurRadius: 8),
                  ]),
              child: Center(child: Text("Start Journery")),
            ),
          ),
        ));
  }
}

class TransportList extends StatefulWidget {
  TransportList({Key? key}) : super(key: key);

  @override
  _TransportListState createState() => _TransportListState();
}

class _TransportListState extends State<TransportList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: Utils.getEmissionTiles().length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                print(index);
                //TODO: clickable blocks for each different index
              },
              child: ModeTiles(
                index: index,
              ));
        },
      ),
    );
  }
}

class ModeTiles extends StatelessWidget {
  ModeTiles({
    required this.index,
    Key? key,
  }) : super(key: key);
  int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 10),
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              color: Utils.getEmissionTiles()[index].color,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.19),
                    offset: const Offset(1, 4),
                    spreadRadius: 1,
                    blurRadius: 8),
                BoxShadow(
                    color: Colors.white.withOpacity(0.4),
                    offset: const Offset(-3, -4),
                    spreadRadius: -2,
                    blurRadius: 20),
              ]),
          child: Center(
            child: Icon(
              Utils.getEmissionTiles()[index].icon,
              size: 60,
            ),
          ),
        ),
        Text(Utils.getEmissionTiles()[index].mode)
      ],
    );
  }
}

class Details extends StatelessWidget {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Flex(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      direction: Axis.vertical,
      children: [
        InkWell(
          splashColor: Colors.grey,
          onTap: () {
            //  TODO: size page
          },
          child: Container(
            color: Colors.white24,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.19),
                              offset: const Offset(1, 4),
                              spreadRadius: 1,
                              blurRadius: 8),
                          BoxShadow(
                              color: Colors.white.withOpacity(0.4),
                              offset: const Offset(-3, -4),
                              spreadRadius: -2,
                              blurRadius: 20),
                        ]),
                    child: Icon(
                      Icons.pedal_bike,
                      size: 40,
                    )),
                Text(
                  "Vehicle Size",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        GestureDetector(
          onTap: () {
            //  TODO fuel page
          },
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.19),
                              offset: const Offset(1, 4),
                              spreadRadius: 1,
                              blurRadius: 8),
                          BoxShadow(
                              color: Colors.white.withOpacity(0.4),
                              offset: const Offset(-3, -4),
                              spreadRadius: -2,
                              blurRadius: 20),
                        ]),
                    child: Icon(
                      Icons.bike_scooter,
                      size: 40,
                    )),
                Text(
                  "Fuel Type",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        )
      ],
    ));
  }
}
