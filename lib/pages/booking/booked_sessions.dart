import 'package:abora_client/constants/app_styles.dart';
import 'package:abora_client/constants/widgets.dart';
import 'package:abora_client/models/trainer.dart';
import 'package:flutter/material.dart';

class BookedSessions extends StatelessWidget {
  BookedSessions({super.key});

  final List<NearTrainersModel> list = [
    NearTrainersModel(
        name: 'trainer',
        imgPath: 'img',
        bio:
            'BIO this is demo text to test the bio text contianert limit see if its working okay'),
    NearTrainersModel(
        name: ' trainer',
        imgPath: 'img',
        bio:
            'BIO this is demo text to test the bio text contianert limit see if its working okay'),
    NearTrainersModel(
        name: ' trainer',
        imgPath: 'img',
        bio:
            'BIO this is demo text to test the bio text contianert limit see if its working okay'),
    NearTrainersModel(
        name: 'trainer',
        imgPath: 'img',
        bio:
            'BIO this is demo text to test the bio text contianert limit see if its working okay'),
    NearTrainersModel(
        name: '1 trainer',
        imgPath: 'img',
        bio:
            'BIO this is demo text to test the bio text contianert limit see if its working okay'),
    NearTrainersModel(
        name: '1 trainer',
        imgPath: 'img',
        bio:
            'BIO this is demo text to test the bio text contianert limit see if its working okay'),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final width = SizeConfig.screenWidth;
    final height = SizeConfig.screenHeight;

    return SizedBox(
        width: width,
        height: height,
        child: ListView(children: [
          Center(
              child: Text(
            'My Bookings',
            style: kPoppinsMedium,
          )),
          SizedBox(height: height! * 0.02),
          SizedBox(
            height: height / 2.2,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Upcoming Sessions',
                style: kPoppinsMedium,
              ),
              SizedBox(
                  height: height * 0.42,
                  child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, ind) {
                        return SessionTrainerTile(
                            name: 'namne',
                            imgPath: 'img path',
                            goal: 'goalIs',
                            onTap: () => GestureDetector(
                                  onTap: () {},
                                ));
                      }))
            ]),
          ),
          SizedBox(height: height * 0.02),
          Text(
            'Previous Sessions',
            style: kPoppinsMedium,
          ),

// Previous sessions
          SizedBox(
              height: height * 0.42,
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, ind) {
                    return SessionTrainerTile(
                      name: 'namne',
                      imgPath: 'img path',
                      goal: 'goalIs',
                    );
                  })),
        ]));
  }
}
