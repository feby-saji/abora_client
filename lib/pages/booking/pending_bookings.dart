import 'package:abora_client/constants/app_styles.dart';
import 'package:abora_client/pages/main_page.dart';
import 'package:flutter/material.dart';

class PendingBookingsPage extends StatelessWidget {
  const PendingBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final width = SizeConfig.screenWidth;
    final height = SizeConfig.screenHeight;

    return Scaffold(
        appBar: AppBar(
            backgroundColor: kGreen,
            title: Text('Status of your bookings',
                style: kPoppinsMedium.copyWith(color: Colors.white))),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: FutureBuilder(
                future: dbServices.getPendingReqs(),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(color: Colors.green));
                  }
                  if (snap.data != null) {
                    return ListView.builder(
                        itemCount: snap.data!.docs.length,
                        itemBuilder: (BuildContext context, int ind) {
                          var data = snap.data!.docs[ind];

                          return PendingReqTile(
                              height: height,
                              width: width,
                              image: data['image'],
                              userNm: data['name'],
                              goal: data['goal'],
                              sessionCount: data['sessionCount']);
                        });
                  } else {
                    return Container();
                  }
                })));
  }
}

class PendingReqTile extends StatelessWidget {
  final image;
  final userNm;
  final sessionCount;
  final goal;
  const PendingReqTile({
    super.key,
    required this.height,
    required this.width,
    required this.image,
    required this.userNm,
    required this.goal,
    required this.sessionCount,
  });

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        height: height! / 6,
        child: Column(children: [
          Row(
            children: <Widget>[
              const SizedBox(width: 5),
              SizedBox(
                width: 70,
                height: 70,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(userNm.isEmpty ? '' : userNm,
                  // style: kPoppinsMedium.copyWith(fontSize: 18)),
                  Text('Goal : goal',
                      style: kPoppinsRegular.copyWith(fontSize: 15)),
                  Text('sessions : sessionCount',
                      style: kPoppinsRegular.copyWith(fontSize: 15)),
                ],
              ),
            ],
          ),
          SizedBox(
            width: width! / 1.1,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    textStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
                child: const Text('waiting for trainer to accept')),
          )
        ]),
      ),
    ]);
  }
}
