import 'package:abora_client/constants/app_styles.dart';
import 'package:abora_client/constants/widgets.dart';
import 'package:abora_client/pages/booking/booking.dart';
import 'package:abora_client/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<DateTime> specialDatesD = [];
List<DateTime> blackOutDatesD = [];

class TrainerProfileView extends StatefulWidget {
  final String userName;
  final String profilePic;
  final String specializeIn;
  final String bio;
  final bool home;
  final bool gym;
  final String pricePerSession;
  final List specialDates;
  final List blackOutDates;
  const TrainerProfileView({
    super.key,
    required this.userName,
    required this.profilePic,
    required this.specializeIn,
    required this.bio,
    required this.home,
    required this.gym,
    required this.pricePerSession,
    required this.specialDates,
    required this.blackOutDates,
  });

  @override
  State<TrainerProfileView> createState() => _TrainerProfileViewState();
}

class _TrainerProfileViewState extends State<TrainerProfileView> {
  @override
  void initState() {
    super.initState();
    dbServices.getSessionsAvailable(widget.specialDates);
    dbServices.getSessionsBooked(widget.blackOutDates);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final blkVerSize = SizeConfig.blockSizeVertical!;

    final blkHorSize = SizeConfig.blockSizeHorizontal!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: GestureDetector(
            onTap: () => Get.back(),
            child: const SizedBox(
              child: Icon(Icons.close_rounded),
            )),
        title: Text('Trainer\'s Profile',
            style: kPoppinsMedium.copyWith(
                fontSize: blkHorSize * 5, color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Center(
                  child: widget.profilePic.isEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            'assets/images/abora_logo.png',
                            fit: BoxFit.cover,
                            width: 90,
                            height: 90,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            widget.profilePic,
                            fit: BoxFit.cover,
                            width: 90,
                            height: 90,
                          ),
                        )),
              SizedBox(width: blkHorSize * 4),

              //
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userName,
                    style: kPoppinsMedium.copyWith(
                      fontSize: blkHorSize * 4.5,
                    ),
                  ),
                  SizedBox(height: blkVerSize * 2),
                  Row(
                    children: [
                      Text(
                        'specialize in :',
                        style: kPoppinsRegular.copyWith(),
                      ),
                      Text(
                        widget.specializeIn,
                        style: kPoppinsMedium.copyWith(color: Colors.black),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: blkVerSize * 2),
          Text('Bio', style: kPoppinsMedium),
          SizedBox(height: blkVerSize * 0.1),
          Text(widget.bio),
          SizedBox(height: blkVerSize * 3),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          DescriptionTile(text: 'home', value: widget.home ? 'Yes' : 'No'),
          DescriptionTile(text: 'gym', value: widget.gym ? 'Yes' : 'No'),
          DescriptionTile(
              text: 'price per sesion', value: widget.pricePerSession),
          SizedBox(height: blkVerSize * 4),
          Text('Training location', style: kPoppinsMedium),
          SizedBox(height: blkVerSize * 25),
          Center(
            child: ElevatedButton(
              onPressed: () => Get.to(() => BookingPage(
                    specialDates: specialDatesD,
                    blackOutDates: blackOutDatesD,
                    name: widget.userName,
                    image: widget.profilePic,
                  )),
              style: ElevatedButton.styleFrom(
                backgroundColor: kGreen,
              ),
              child: const Text('Book Now'),
            ),
          )
        ]),
      ),
    );
  }
}
