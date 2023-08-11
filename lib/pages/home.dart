import 'package:abora_client/constants/app_styles.dart';
import 'package:abora_client/constants/widgets.dart';
import 'package:abora_client/models/trainer.dart';
import 'package:abora_client/pages/booking/pending_bookings.dart';
import 'package:abora_client/pages/main_page.dart';
import 'package:abora_client/pages/search_results.dart';
import 'package:abora_client/pages/view_trainer_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

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
    final blkVerSize = SizeConfig.blockSizeVertical!;
    final blkHorSize = SizeConfig.blockSizeHorizontal!;
    TextEditingController trainerNameCtrl = TextEditingController();

    return SizedBox(
      width: width,
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              '${userName.isEmpty ? 'HOME' : 'Welcome $userName,'} ',
              style: kPoppinsMedium,
            ),
            GestureDetector(
                onTap: () => Get.to(() => PendingBookingsPage()),
                child: Image.asset('assets/icons/appoinment.png',
                    width: 40, height: 40)),
          ]),
          SizedBox(height: blkVerSize * 3),
// Search Bar
          Row(children: [
            Flexible(
              flex: 1,
              child: TextField(
                controller: trainerNameCtrl,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: 'Search Trainers...',
                    hintStyle:
                        const TextStyle(color: Colors.black, fontSize: 18),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        if (trainerNameCtrl.text.isNotEmpty) {
                          Get.to(() =>
                              SearchTrainer(searchName: trainerNameCtrl.text));
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(11),
                        width: 25,
                        child: Image.asset(
                          'assets/icons/search.png',
                          color: kIconColor,
                        ),
                      ),
                    )),
              ),
            ),
          ]),
          SizedBox(height: blkVerSize * 5),

// Trainers near users
          Text('Trainers near you', style: kPoppinsMedium),
          Expanded(
            child: SizedBox(
              child: FutureBuilder(
                  future: dbServices.getNearTrainers(),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child:
                              CircularProgressIndicator(color: Colors.green));
                    }
                    if (snap.data != null) {
                      return ListView.builder(
                          itemCount: snap.data!.docs.length,
                          itemBuilder: (BuildContext context, int ind) {
                            var data = snap.data!.docs[ind];

                            return NearTrainerTile(
                                name: data['name'],
                                imgPath: data['profilePic'],
                                bio: data['bio'],
                                onTap: () => Get.to(() => TrainerProfileView(
                                      userName: data['name'],
                                      profilePic: data['profilePic'],
                                      specializeIn: data['speciality'],
                                      bio: data['bio'],
                                      home: data['homeTraining'],
                                      gym: data['gymTraining'],
                                      pricePerSession: data['pricePerSession'],
                                      blackOutDates: data['sessionsBooked'],
                                      specialDates: data['availableSessions'],
                                    )));
                          });
                    } else {
                      return Container();
                    }
                  }),
            ),
          ),
          SizedBox(height: height! * 0.02)
        ],
      ),
    );
  }
}
