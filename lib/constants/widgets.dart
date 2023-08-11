import 'package:abora_client/constants/app_styles.dart';
import 'package:flutter/material.dart';

class NearTrainerTile extends StatelessWidget {
  final String name;
  final String imgPath;
  final String bio;
  final VoidCallback onTap;

  const NearTrainerTile({
    super.key,
    required this.name,
    required this.imgPath,
    required this.bio,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical! * 1),
      width: SizeConfig.screenWidth,
      height: SizeConfig.blockSizeVertical! * 14,
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal! * 3,
          vertical: SizeConfig.blockSizeVertical! * 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: navBarBck,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Row(
          children: [
            Column(
              children: [
                Row(children: [
                  imgPath.isEmpty
                      ? const SizedBox(
                          width: 60,
                          height: 60,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('assets/images/login_bck_pg.jpg'),
                          ),
                        )
                      : SizedBox(
                          width: 60,
                          height: 60,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(imgPath),
                          ),
                        ),
                  const SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: kPoppinsSemiBold.copyWith(
                          color: kWhite,
                        ),
                      ),
                      const SizedBox(height: 2),
                      SizedBox(
                        width: SizeConfig.screenWidth! * 0.6,
                        height: 40,
                        child: Text(
                          bio,
                          overflow: TextOverflow.fade,
                          style: kPoppinsRegular.copyWith(
                            color: kWhite,
                          ),
                        ),
                      )
                    ],
                  )
                ]),
              ],
            )
          ],
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            'view profile',
            style: kPoppinsMedium.copyWith(
              color: kWhite,
              fontSize: SizeConfig.blockSizeHorizontal! * 3,
            ),
          ),
        )
      ]),
    );
  }
}

// Trainer tiles on User Upcoming sessions
class SessionTrainerTile extends StatelessWidget {
  // final String noOfBooking;
  // final VoidCallback sessionType;
  final String name;
  final String imgPath;
  final String goal;
  final VoidCallback? onTap;

  const SessionTrainerTile({
    super.key,
    required this.name,
    required this.imgPath,
    required this.goal,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
        margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical! * 1),
        height: SizeConfig.blockSizeVertical! * 11,
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal! * 3,
            vertical: SizeConfig.blockSizeVertical! * 1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: navBarBck,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Pic
            const Expanded(
              flex: 1,
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/login_bck_pg.jpg'),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trainer Name',
                        style: kPoppinsMedium.copyWith(color: Colors.white),
                      ),
                      Text(
                        onTap != null ? 'View details' : '',
                        style: kPoppinsMedium.copyWith(
                            color: Colors.white60, fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Goal',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text('Muscle Gain',
                          style: TextStyle(color: Colors.white)),
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class DescriptionTile extends StatefulWidget {
  final String text;
  final String value;
  const DescriptionTile({
    Key? key,
    required this.text,
    required this.value,
  }) : super(key: key);

  @override
  State<DescriptionTile> createState() => _DescriptionTileState();
}

class _DescriptionTileState extends State<DescriptionTile> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final blkVerSize = SizeConfig.blockSizeVertical!;
    final blkHorSize = SizeConfig.blockSizeHorizontal!;
    return Container(
      margin: EdgeInsets.only(bottom: blkVerSize * 1),
      padding: EdgeInsets.symmetric(
          horizontal: blkHorSize * 7, vertical: blkVerSize * 2),
      decoration: BoxDecoration(
        color: navBarBck,
        borderRadius: BorderRadiusDirectional.circular(20),
      ),
      width: blkHorSize * 90,
      height: blkVerSize * 6,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          widget.text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        Text(
          widget.value,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ]),
    );
  }
}

// profiel card
class InfoCard extends StatelessWidget {
  // the values we need
  final String text;
  final String img;
  final VoidCallback onPressed;

  const InfoCard(
      {super.key,
      required this.text,
      required this.img,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Row(children: [
          SizedBox(width: 20, height: 20, child: Image.asset(img)),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 20, fontFamily: "Source Sans Pro"),
          ),
        ]),
      ),
    );
  }
}
