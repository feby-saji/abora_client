import 'package:abora_client/constants/app_styles.dart';
import 'package:abora_client/constants/widgets.dart';
import 'package:abora_client/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchTrainer extends StatelessWidget {
  String searchName;
  SearchTrainer({super.key, required this.searchName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
// seach bar
            Row(children: [
              Flexible(
                flex: 1,
                child: TextField(
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
                      suffixIcon: Container(
                        padding: const EdgeInsets.all(11),
                        width: 25,
                        child: Image.asset(
                          'assets/icons/search.png',
                          color: kIconColor,
                        ),
                      )),
                ),
              ),
            ]),
//
            FutureBuilder(
                future: dbServices.getSearchTrainers(),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(color: Colors.green));
                  }
                  if (snap.hasData) {
                    print('has data');
                    print(snap.data!.docs);
                    if (snap.data!.docs.isNotEmpty) {
                      return SizedBox(
                        height: 500,
                        child: ListView.builder(
                            itemCount: snap.data!.docs.length,
                            itemBuilder: (context, ind) {
                              var data = snap.data!.docs[ind];

                              return NearTrainerTile(
                                  name: data['name'],
                                  imgPath: data['profilePic'],
                                  bio: data['bio'],
                                  onTap: () => Get.to(() => {}));
                            }),
                      );
                    } else {
                      return Text('no data to show');
                    }
                  } else {
                    return Text('no data to show');
                  }
                })
          ],
        ),
      ),
    );
  }
}
