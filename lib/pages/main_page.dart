import 'package:abora_client/DB/functions.dart';
import 'package:abora_client/constants/app_styles.dart';
import 'package:abora_client/pages/booking/booked_sessions.dart';
import 'package:abora_client/pages/home.dart';
import 'package:abora_client/pages/profile.dart';
import 'package:flutter/material.dart';

// Global vars
DbServices dbServices = DbServices();
String userName = '';

// StatefulWidget widget
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

//  BottomNavigationBar configs
List pages = [HomePage(), BookedSessions(), ProfilePage()];
int currentIndex = 0;

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await DbServices().fillDocSnap();
      userName = await DbServices().getUserName();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final width = SizeConfig.screenWidth;
    final height = SizeConfig.screenHeight;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(235, 247, 244, 244),
      body: Stack(children: [
        //Current Page
        ListView(children: [
          Padding(
            padding: EdgeInsets.only(
              // top: height != null ? height * 0.06 : 5,
              left: width != null ? width * 0.03 : 5,
              right: width != null ? width * 0.03 : 5,
            ),
            child: pages[currentIndex],
          ),
        ]),

        // bottom_navigation_bar
        Positioned(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                width: width! / 1.5,
                height: 50,
                padding: const EdgeInsets.all(12),
                margin: EdgeInsets.only(bottom: height! * .01),
                decoration: BoxDecoration(
                  color: navBarBck.withOpacity(0.8),
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = 0;
                          });
                        },
                        child: Image.asset('assets/icons/home.png',
                            color: kIconColor)),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentIndex = 1;
                        });
                      },
                      child: Image.asset('assets/icons/calendar.png',
                          color: kIconColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentIndex = 2;
                        });
                      },
                      child: Image.asset('assets/icons/user.png',
                          color: kIconColor),
                    ),
                  ],
                )),
          ),
        )
      ]),
    );
  }
}
