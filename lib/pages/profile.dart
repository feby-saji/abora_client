import 'package:abora_client/constants/app_styles.dart';
import 'package:abora_client/constants/vars.dart';
import 'package:abora_client/constants/widgets.dart';
import 'package:abora_client/main.dart';
import 'package:abora_client/pages/main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' show get;
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

String goal = 'empty';
bool textFieldErr = false;

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      SharedPrefVal sharedPrefVal = SharedPrefVal();
      if (sharedPref.getString(sharedPrefVal.profilePic) != null) {
        file = File(sharedPref.getString(sharedPrefVal.profilePic)!);
      }
      goal = await dbServices.getUserGoal();

// check shared has ImgPath
      if (sharedPref.getString(SharedPrefVal().profilePic) == null) {
// getImgUrl
        DocumentSnapshot snapDoc =
            await dbServices.usersCollection.doc(dbServices.uid).get();
        // file = snapDoc['profilePic'];
// download and save it in local storage
        //comment out the next two lines to prevent the device from getting
        // the image from the web in order to prove that the picture is
        // coming from the device instead of the web.
        var url = snapDoc['profilePic']; // <-- 1
        var response = await get(Uri.parse(url)); // <--2
        var documentDirectory = await getApplicationDocumentsDirectory();
        var firstPath = "${documentDirectory.path}/images";
        var filePathAndName = '${documentDirectory.path}/images/pic.jpg';
        //comment out the next three lines to prevent the image from being saved
        //to the device to show that it's coming from the internet
        await Directory(firstPath).create(recursive: true); // <-- 1
        File file2 = File(filePathAndName); // <-- 2
        file2.writeAsBytesSync(response.bodyBytes); // <-- 3
        setState(() {
          file = file2;
        });
        await sharedPref.setString(SharedPrefVal().profilePic, filePathAndName);
      } else {
        print('this thing wont run cuz this aint null');
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final width = SizeConfig.screenWidth;
    final height = SizeConfig.screenHeight;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          height: height! / 9,
          child: Row(
            children: <Widget>[
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () => selectImage(),
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: file == null
                      ? const CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/images/login_bck_pg.jpg'),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            file!,
                            fit: BoxFit.cover,
                            width: 90,
                            height: 90,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(userName.isEmpty ? '' : userName,
                            style: kPoppinsMedium.copyWith(fontSize: 20)),
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                          width: width! / 1.7,
                          child: Row(
                            children: [
                              Text("Goal : ", style: kPoppinsMedium),
                              Text(goal.isEmpty ? '' : goal,
                                  style:
                                      kPoppinsRegular.copyWith(fontSize: 18)),
                            ],
                          )),
                      GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: Container(
                                      width: 200,
                                      height: 300,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: navBarBck,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            'Select your Goal',
                                            style: kPoppinsMedium.copyWith(
                                                color: Colors.white),
                                          ),
//  ? first option

                                          GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                goal = 'Lean body';
                                              });
                                              await dbServices.setGoal(goal);

                                              Get.back();
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 35,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white,
                                              ),
                                              child: const Center(
                                                child: DefaultTextStyle(
                                                  style: TextStyle(),
                                                  child: Text(
                                                    'Lean',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

// ? second option
                                          GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                goal = 'Muscle building';
                                              });
                                              await dbServices.setGoal(goal);
                                              Get.back();
                                            },
                                            child: Container(
                                              width: 150,
                                              height: 40,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white,
                                              ),
                                              child: const Center(
                                                child: DefaultTextStyle(
                                                  style: TextStyle(),
                                                  child: Text(
                                                    'Muscle building',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

// ? third option
                                          GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                goal = 'Fat loss';
                                              });
                                              await dbServices.setGoal(goal);
                                              Get.back();
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 35,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white,
                                              ),
                                              child: const Center(
                                                child: DefaultTextStyle(
                                                  style: TextStyle(),
                                                  child: Text(
                                                    'Fat Loss',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

// ? Weight gain
                                          GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                goal = 'Weight gain';
                                              });
                                              await dbServices.setGoal(goal);
                                              Get.back();
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 40,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white,
                                              ),
                                              child: const Center(
                                                child: DefaultTextStyle(
                                                  style: TextStyle(),
                                                  child: Text(
                                                    'Weight gain',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: const Icon(Icons.edit_outlined))
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
          width: 200,
          child: Divider(color: Colors.grey),
        ),
        InfoCard(
            text: 'Payment settings',
            img: 'assets/icons/credit-card.png',
            onPressed: () {}),
        InfoCard(
            text: 'Refund', img: 'assets/icons/refund.png', onPressed: () {}),
        InfoCard(
            text: 'FAQ\'s',
            img: 'assets/icons/conversation.png',
            onPressed: () {}),
        InfoCard(
            text: 'Report', img: 'assets/icons/report.png', onPressed: () {}),
        InfoCard(
            text: 'Contact us',
            img: 'assets/icons/email.png',
            onPressed: () => launchEmailSubmission()),
      ]),
    );
  }

  Future<void> selectImage() async {
    final navigator = Navigator.of(context);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(
              child: SizedBox(
            width: 300,
            height: 300,
            child:
                // CircularProgressIndicator()
                RiveAnimation.asset('assets/rive/loading.riv'),
          ));
        });
    SharedPreferences sharedPref = await SharedPreferences.getInstance();

// get file
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile == null) {
      Get.back();
      return;
    }

    setState(() {
      file = File(xFile.path);
    });

// compresss it
    File compressedFile = await FlutterNativeImage.compressImage(xFile.path,
        quality: 80, targetWidth: 500, targetHeight: 500);

// upload
    final cloudinary = CloudinaryPublic('dgfprpoif', 'jtxhrv2n', cache: false);

    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(compressedFile.path,
            resourceType: CloudinaryResourceType.Image),
      );
      dbServices.usersCollection
          .doc(dbServices.uid)
          .update({'profilePic': response.secureUrl});
    } on CloudinaryException catch (e) {
      Get.snackbar('', 'something went wrong $e');
      print(e.message);
      print(e.request);
      navigator.pop();
    }

    await sharedPref.setString(SharedPrefVal().profilePic, compressedFile.path);
    navigator.pop();
  }

  void launchEmailSubmission() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'abora@gmail.com',
    );
    if (!await launchUrl(params)) {
      throw Exception('Could not launch $params');
    }
  }

  void showUserProfileEdit(BuildContext context, width, height) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              padding: EdgeInsets.only(
                  top: height * 0.03, left: width * 0.04, right: width * 0.04),
              width: width / 1.3,
              height: height / 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Material(
                  child: TextFormField(
                    initialValue: 'add goal',
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: textFieldErr ? Colors.red : Colors.green,
                          width: 2.0,
                        ),
                      ),
                      labelText: 'Goal',
                      suffixIcon: Icon(
                        textFieldErr ? Icons.error : null,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        textStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    child: const Text('Done'))
              ]),
            ),
          );
        });
  }
}
