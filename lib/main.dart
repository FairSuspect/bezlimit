import 'dart:math';

import 'package:bezlimit/getx/main.dart';
import 'package:bezlimit/screens/select_screen.dart';
import 'package:bezlimit/widgets/placeholder_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'widgets/tile.dart';

void main() {
  debugRepaintRainbowEnabled = true;
  runApp(GetMaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

double get tileWidth => 100;

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _mainScrollController = ScrollController();
  late AnimationController _animationController;
  late Controller c;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    // _animationController.forward();
    c = Get.put(Controller());
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    _mainScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            border: Border(),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: NotificationListener(
          onNotification: _onNotification,
          child: Stack(
            children: [
              Positioned(
                top: -100,
                left: -100,
                child: AnimatedBuilder(
                  animation: _animationController.view,
                  builder: (context, child) => Transform.rotate(
                      angle: 360 - _animationController.value * pi,
                      child: child!),
                  child: SvgPicture.asset(
                    'assets/circle.svg',
                    height: 300,
                  ),
                ),
              ),
              SingleChildScrollView(
                controller: _mainScrollController,
                child: Column(
                  children: [
                    Container(
                      height: Get.height / 2,
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      height: Get.height,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(175, 175, 175, 1),
                          borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(15),
                              topRight: const Radius.circular(15))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [..._someTiles(4), _tiles()],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _onNotification(Notification notification) {
    if (notification is OverscrollIndicatorNotification) {
      notification.disallowGlow();
      if (_mainScrollController.offset ==
          _mainScrollController.position.maxScrollExtent)
        Get.snackbar("Внимание", "Достигнута верхняя граница");
    }
    if (notification is ScrollUpdateNotification) {
      _animationController.value =
          _mainScrollController.position.pixels / Get.height;
    }

    return true;
  }

  List<Widget> _someTiles([int itemCount = 3]) {
    return List.generate(itemCount,
        (index) => PlaceholderTile(width: 25 * index + 50 * (index % 2) + 200));
  }

  _tiles() {
    // Controller c = Get.find();

    return Container(
      height: 100,
      child: ListView.builder(
        controller: _scrollController,
        primary: false,
        // shrinkWrap: true,
        itemExtent: tileWidth,
        scrollDirection: Axis.horizontal,
        itemCount: c.maxTiles.value,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Tile(
            index: index + 1,
            onTap: () async {
              await Get.to(() => SelectScreen(
                    index: index + 1,
                  ));

              /// Задержка для того, чтобы была видна анимация прокрутки
              await Future.delayed(Duration(milliseconds: 500));
              _scrollController.animateTo(
                  c.count.toDouble() * tileWidth - tileWidth,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOutCirc);
            },
          ),
        ),
      ),
    );
  }
}
