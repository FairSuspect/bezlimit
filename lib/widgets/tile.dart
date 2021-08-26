import 'package:bezlimit/getx/main.dart';
import 'package:bezlimit/screens/select_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tile extends StatelessWidget {
  final int index;
  final Function()? onTap;
  const Tile({
    Key? key,
    required this.index,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Controller c = Get.find();
    return Obx(
      () => Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: c.count.value == index ? Colors.lightGreen : Colors.white70,
            border: Border.all(),
            borderRadius: BorderRadius.circular(12.5)),
        // width: 50,
        child: InkWell(
          child: Text("$index"),
          onTap: onTap ??
              () async {
                await Get.to(() => SelectScreen(
                      index: index,
                    ));
              },
        ),
      ),
    );
  }
}
