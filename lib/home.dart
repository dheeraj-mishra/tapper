import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_alert_window/system_alert_window.dart';
import 'model_theme.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int totalCount = 0;
  int swipeUps = 0;
  bool dayIconActive = false;
  bool isCounting = true;
  bool isUp = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      totalCount = prefs.getInt('sharedTotalCount') ?? 0;
      isCounting = prefs.getBool('sharedIsCounting') ?? true;
      swipeUps = prefs.getInt('sharedSwipeUps') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // IconData nightIcon = Icons.nightlight_round;
    // IconData dayIcon = Icons.wb_sunny;
    double screenWidth = MediaQuery.of(context).size.width;

    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return GestureDetector(
        onTap: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          setState(() {
            if (prefs.getBool('sharedIsCounting') ?? true) {
              prefs.setInt('sharedTotalCount', totalCount++);
              // totalCount = prefs.getInt('sharedTotalCount')!;
              // totalCount++;
            }
          });
        },
        onVerticalDragUpdate: (details) {
          int sensitivity = 20;
          if (details.delta.dy < -sensitivity) {
            isUp = true;
          }
        },
        onVerticalDragEnd: (details) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if (isUp) {
            setState(() {
              prefs.setInt('sharedSwipeUps', swipeUps++);
              // swipeUps++;
            });
          }
          isUp = false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text("TAPPER")),
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(0.05 * screenWidth),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            dayIconActive = dayIconActive ? false : true;
                            themeNotifier.isDark
                                ? themeNotifier.isDark = false
                                : themeNotifier.isDark = true;
                          });
                        },
                        child: Icon(dayIconActive
                            ? Icons.wb_sunny
                            : Icons.nightlight_round),
                      ),
                      height: 0.1 * screenWidth,
                      width: 0.1 * screenWidth,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor),
                    ),
                    Container(
                      width: 0.025 * screenWidth,
                    ),
                    GestureDetector(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        showModalBottomSheet(
                          context: context,
                          // backgroundColor: Color.fromARGB(255, 232, 198, 168),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(0.1 * screenWidth))),
                          builder: (BuildContext context) {
                            return StatefulBuilder(builder:
                                (BuildContext context, StateSetter mystate) {
                              return Container(
                                height: 0.8 * screenWidth,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      // decoration: BoxDecoration(
                                      //   color: Colors.grey[900],
                                      //   borderRadius: BorderRadius.circular(0.05 * screenWidth)
                                      // ),
                                      // height: 0.15 * screenWidth,
                                      // width: 0.8 * screenWidth,
                                      width: 0.8 * screenWidth,
                                      height: 0.2 * screenWidth,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              0.1 * screenWidth),
                                          color:
                                              Theme.of(context).primaryColor),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.pause,
                                              size: 0.1 * screenWidth,
                                            ),
                                            Text(
                                              "STOP COUNTING",
                                              style: TextStyle(
                                                  fontSize: 0.05 * screenWidth),
                                            ),
                                            // Container(
                                            //   width: 0.2 * screenWidth,
                                            // ),
                                            Switch.adaptive(
                                              activeColor: Color.fromARGB(
                                                  255, 230, 227, 138),
                                              value: prefs.getBool(
                                                      'sharedIsCounting') ??
                                                  true,
                                              onChanged:
                                                  (bool currentState) async {
                                                // SharedPreferences prefs =
                                                //     await SharedPreferences
                                                //         .getInstance();
                                                mystate(() {
                                                  prefs.setBool(
                                                      'sharedIsCounting',
                                                      currentState);
                                                  // isCounting = currentState;
                                                  print(currentState);
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          totalCount = 0;
                                          swipeUps = 0;
                                          // prefs.setInt('sharedTotalCount', 0);
                                          // prefs.setInt('sharedSwipeUps', 0);
                                        });
                                      },
                                      child: Container(
                                        width: 0.8 * screenWidth,
                                        height: 0.2 * screenWidth,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                0.1 * screenWidth),
                                            color:
                                                Theme.of(context).primaryColor),
                                        child: Center(
                                            child: Text(
                                          'RESET',
                                          style: TextStyle(
                                              fontSize: 0.1 * screenWidth),
                                        )),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        html.window.open(
                                            'https://github.com/dheeraj-mishra/tapper',
                                            "_blank");
                                      },
                                      child: Container(
                                        width: 0.4 * screenWidth,
                                        height: 0.15 * screenWidth,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                0.1 * screenWidth),
                                            color: Color.fromARGB(
                                                255, 230, 227, 138)),
                                        child: Image.asset('images\\git.png'),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                          },
                        );
                      },
                      child: Container(
                        child: Icon(
                          Icons.settings,
                        ),
                        height: 0.1 * screenWidth,
                        width: 0.1 * screenWidth,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 0.45 * screenWidth,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  mainCard(screenWidth, totalCount, "TAPS", context),
                  mainCard(screenWidth, swipeUps, "SWIPE UPS", context),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

Widget mainCard(screenWidth, totalCount, title, context) {
  return Container(
    child: Column(
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "$totalCount",
            style: TextStyle(fontSize: 0.25 * screenWidth),
          ),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "$title",
            // style: TextStyle(
            //     fontSize: 0.1 * screenWidth
            // ),
          ),
        ),
      ],
    ),
    height: 0.4 * screenWidth,
    width: 0.4 * screenWidth,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.05 * screenWidth),
        color: Theme.of(context).primaryColor),
  );
}

// Widget buildSheet(screenWidth, isCounting){
//
// }