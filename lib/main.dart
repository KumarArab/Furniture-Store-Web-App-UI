import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Furniture Web App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      body: Stack(
        children: [
          Container(
            height: _height,
            width: _width,
            child: CustomPaint(
              painter: ShapePainter(),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: _width * 0.05,
            ),
            height: _height,
            width: _width,
            child: Column(
              children: [
                SizedBox(
                  height: _width * 0.02,
                ),
                NavBar(),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Definition(),
                      ),
                      Expanded(
                        flex: 4,
                        child: Chair(),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: _width,
                  height: _width * 0.05,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
                width: _width,
                height: _width * 0.12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      backgroundColor: Color(0xff699272),
                    ),
                    Container(
                        width: _width * 0.5,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: ChairList.length,
                          itemBuilder: (ctx, i) {
                            return Container(
                                height: 100,
                                width: 250,
                                margin: EdgeInsets.all(30),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        offset: Offset(5, 5),
                                        blurRadius: 5,
                                        spreadRadius: 5,
                                      )
                                    ]),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Image.asset(ChairList[i].image),
                                    ),
                                    Text(ChairList[i].name,
                                        style: GoogleFonts.openSans(
                                          fontSize: 20,
                                        )),
                                    SizedBox(height: 10),
                                    Text(ChairList[i].price,
                                        style: GoogleFonts.openSans(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        )),
                                    SizedBox(height: 10),
                                  ],
                                ));
                          },
                        )),
                    CircleAvatar(
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      backgroundColor: Color(0xff699272),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class Definition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Furniture You Will Love",
          style: TextStyle(
            fontFamily: "Tahu",
            fontWeight: FontWeight.w700,
            fontSize: 100,
          ),
        ),
        Text(
          "It is a long established fact that a reader will be distracted by the readable\ncontent of a page when looking at its layout",
          style: GoogleFonts.openSans(
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),
        ),
        SizedBox(
          height: 50,
        ),
        RaisedButton(
          color: Color(0xff699272),
          elevation: 5,
          onPressed: () {},
          padding: EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 20,
          ),
          child: Text("EXPLORE",
              style: GoogleFonts.openSans(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              )),
        )
      ],
    );
  }
}

class ChairItem {
  final String name;
  final String image;
  final String price;

  ChairItem({this.name, this.image, this.price});
}

List<ChairItem> ChairList = [
  ChairItem(
    name: "Padded Chair",
    image: "assets/images/trichair.png",
    price: "\$122.99",
  ),
  ChairItem(
    name: "Sofa",
    image: "assets/images/sofa.png",
    price: "\$122.99",
  ),
  ChairItem(
    name: "Chair",
    image: "assets/images/Chair.png",
    price: "\$122.99",
  ),
];

class Chair extends StatefulWidget {
  @override
  _ChairState createState() => _ChairState();
}

class _ChairState extends State<Chair> with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller =
        new AnimationController(vsync: this, duration: Duration(seconds: 5))
          ..repeat(reverse: true);
    super.initState();
  }

  double chair1Opacity = 1;
  double chair2Opacity = 1;
  double chair3Opacity = 1;

  double getChair1Opacity() {
    if (controller.value <= 0.66)
      return 0;
    else if (controller.value >= 0.66 && controller.value <= 1) {
      double op = (controller.value - 0.66) * 3;
      if (op > 1)
        return 1;
      else
        return op;
    } else
      return 1;
  }

  double getChair2Opacity() {
    if (controller.value <= 0.33)
      return 0;
    else if (controller.value >= 0.33 && controller.value <= 0.66)
      return (controller.value - 0.33) * 3;
    else
      return 1;
  }

  double getChair3Opacity() {
    if (controller.value <= 0.33)
      return controller.value * 3;
    else
      return 1;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _width * 0.28,
      width: _width * 0.28,
      child: Stack(
        children: [
          Image.asset(
            "assets/images/chairblack.png",
          ),
          AnimatedChair(
            assetName: "assets/images/chairred.png",
            controller: controller,
            getChairOpacity: getChair3Opacity,
          ),
          AnimatedChair(
            assetName: "assets/images/chairyellow.png",
            controller: controller,
            getChairOpacity: getChair2Opacity,
          ),
          AnimatedChair(
            assetName: "assets/images/chairgreen.png",
            controller: controller,
            getChairOpacity: getChair1Opacity,
          )
        ],
      ),
    );
  }
}

class AnimatedChair extends StatelessWidget {
  final String assetName;
  final AnimationController controller;
  final Function getChairOpacity;

  AnimatedChair({this.assetName, this.controller, this.getChairOpacity});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Opacity(
          opacity: getChairOpacity(),
          child: child,
        );
      },
      child: Image.asset(assetName),
    );
  }
}

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          "assets/images/logo.png",
          height: 30,
          width: 30,
        ),
        SizedBox(width: 10),
        Text(
          "Wood",
          style: TextStyle(
            fontFamily: 'Euphoria',
            fontSize: 40,
            color: Color(0xff699272),
          ),
        ),
        Spacer(),
        Text(
          "Home",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: "SF Pro Display"),
        ),
        SizedBox(
          width: 40,
        ),
        Text(
          "Furniture",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: "SF Pro Display"),
        ),
        SizedBox(
          width: 40,
        ),
        Text(
          "Product",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: "SF Pro Display"),
        ),
        SizedBox(
          width: 40,
        ),
        Text(
          "Store",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: "SF Pro Display"),
        ),
        SizedBox(
          width: 40,
        ),
        Image.asset(
          "assets/images/search.png",
          height: 30,
          width: 30,
        ),
        SizedBox(
          width: 40,
        ),
        Image.asset(
          "assets/images/shopping-cart.png",
          height: 30,
          width: 30,
        ),
        SizedBox(
          width: 100,
        ),
      ],
    );
  }
}

class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paintMain = Paint();

    paintMain.color = Color(0xff699272);
    paintMain.style = PaintingStyle.fill;

    var pathMain = Path();

    pathMain.moveTo(size.width, 0);
    pathMain.quadraticBezierTo(
        size.width / 6, size.height * 0.4, size.width * 0.8, size.height * 0.4);
    pathMain.quadraticBezierTo(
        size.width, size.height * 0.4, size.width * 0.8, size.height * 0.6);
    pathMain.quadraticBezierTo(
        size.width * 0.7, size.height * 0.7, size.width, size.height * 0.8);
    pathMain.lineTo(size.width, size.height);

    canvas.drawPath(pathMain, paintMain);

    var paintShadow = Paint();

    paintShadow.color = Color(0xff699272).withOpacity(0.3);
    paintShadow.style = PaintingStyle.fill;

    var pathShadow = Path();

    pathShadow.moveTo(size.width, size.height * 0.2);
    pathShadow.quadraticBezierTo(size.width / 10, size.height * 0.4,
        size.width * 0.8, size.height * 0.5);
    pathShadow.quadraticBezierTo(
        size.width, size.height * 0.5, size.width * 0.8, size.height * 0.6);
    pathShadow.lineTo(size.width, size.height * 0.5);

    canvas.drawPath(pathShadow, paintShadow);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
