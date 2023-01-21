import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int totalCount = 0;
  int swipeUps = 0;
  bool dayIconActive = false;
  bool isCounting = false;

  @override
  Widget build(BuildContext context) {
    // IconData nightIcon = Icons.nightlight_round;
    // IconData dayIcon = Icons.wb_sunny;
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        setState(() {
          totalCount++;
        });
      },
      onVerticalDragUpdate: (details) {
        int sensitivity = 8;
        if (details.delta.dy < -sensitivity) {
          swipeUps++;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Tap Counter")),
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
                        });
                      },
                      child: Icon(dayIconActive
                          ? Icons.wb_sunny
                          : Icons.nightlight_round),
                    ),
                    height: 0.1 * screenWidth,
                    width: 0.1 * screenWidth,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[700]),
                  ),
                  Container(
                    width: 0.025 * screenWidth,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.grey[500],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(0.1 * screenWidth))),
                        builder: (BuildContext context) => Container(
                          height: 0.8 * screenWidth,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                // decoration: BoxDecoration(
                                //   color: Colors.grey[900],
                                //   borderRadius: BorderRadius.circular(0.05 * screenWidth)
                                // ),
                                height: 0.15 * screenWidth,
                                width: 0.8 * screenWidth,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.pause,
                                    ),
                                    Text("STOP COUNTING"),
                                    Switch.adaptive(
                                      value: isCounting,
                                      onChanged: (bool currentState) {
                                        setState(() {
                                          isCounting = currentState;
                                          print(currentState);
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                // decoration: BoxDecoration(
                                //     color: Colors.grey[900],
                                //     borderRadius: BorderRadius.circular(0.05 * screenWidth)
                                // ),
                                height: 0.15 * screenWidth,
                                width: 0.8 * screenWidth,
                              ),
                              Container(
                                // decoration: BoxDecoration(
                                //     color: Colors.grey[900],
                                //     borderRadius: BorderRadius.circular(0.05 * screenWidth)
                                // ),
                                height: 0.15 * screenWidth,
                                width: 0.8 * screenWidth,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      child: Icon(
                        Icons.settings,
                      ),
                      height: 0.1 * screenWidth,
                      width: 0.1 * screenWidth,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey[700]),
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
                mainCard(screenWidth, totalCount, "TAPS"),
                mainCard(screenWidth, swipeUps, "SWIPE UPS"),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              totalCount = 0;
              swipeUps = 0;
            });
          },
          backgroundColor: Colors.white,
          child: Text("reset"),
        ),
      ),
    );
  }
}

Widget mainCard(screenWidth, totalCount, title) {
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
        Text(
          "$title",
          // style: TextStyle(
          //     fontSize: 0.1 * screenWidth
          // ),
        ),
      ],
    ),
    height: 0.4 * screenWidth,
    width: 0.4 * screenWidth,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.05 * screenWidth),
        color: Colors.grey[700]),
  );
}

// Widget buildSheet(screenWidth, isCounting){
//
// }