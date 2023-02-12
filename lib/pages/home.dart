import 'package:abora_client/DB/functions.dart';
import 'package:abora_client/constants/app_styles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    DbServices dbServices = DbServices();

    final width = SizeConfig.screenWidth;
    final height = SizeConfig.screenHeight;

    return Column(
      children: [Text('demo text')],
    );
  }
}
