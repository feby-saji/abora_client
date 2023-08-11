import 'package:abora_client/DB/functions.dart';
import 'package:abora_client/constants/app_styles.dart';
import 'package:abora_client/models/confirm_booking.dart';
import 'package:abora_client/pages/main_page.dart';
import 'package:abora_client/pages/view_trainer_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookingPage extends StatefulWidget {
  final String image;
  final String name;
  List<DateTime> specialDates = [];
  List<DateTime> blackOutDates = [];
  BookingPage(
      {super.key,
      required this.specialDates,
      required this.blackOutDates,
      required this.name,
      required this.image});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

String bookingTime = '';
DateTime? bookingDate;
String sessionCount = '';

class _BookingPageState extends State<BookingPage> {
  selectTime() async {
    var timePicked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (timePicked != null) {
      DateTime tempDate =
          DateFormat("hh:mm").parse("${timePicked.hour}:${timePicked.minute}");
      var dateFormat = DateFormat("h:mm a");
      setState(() {
        bookingTime = dateFormat.format(tempDate);
      });
      print('prinitng date $bookingTime');
    } else {
      return;
    }

    //
    // await showCustomTimePicker(
    //         context: context,
    //         // It is a must if you provide selectableTimePredicate
    //         onFailValidation: (context) => print('Unavailable selection'),
    //         initialTime: const TimeOfDay(hour: 6, minute: 0),
    //         selectableTimePredicate: (time) => time!.hour > 1 && time.hour < 14)
    //     .then((time) {
    //   setState(() => bookingTime = time?.format(context));
    // });
  }

  @override
  void dispose() {
    super.dispose();
    bookingDate = null;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final blkVerSize = SizeConfig.blockSizeVertical!;
    final blkHorSize = SizeConfig.blockSizeHorizontal!;

    int lastDay =
        DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;

    // List of items in our dropdown menu
    var items = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: GestureDetector(
            onTap: () => Get.back(),
            child: const SizedBox(
              child: Icon(Icons.close_rounded),
            )),
        title: Text('Booking',
            style: kPoppinsMedium.copyWith(
                fontSize: blkHorSize * 5, color: Colors.white)),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: SizedBox(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('sessions available'),
                            SizedBox(width: blkHorSize * 3),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                width: 10,
                                height: 10,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('sessions booked'),
                            SizedBox(width: blkHorSize * 5),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                width: 10,
                                height: 10,
                                color: Colors.red,
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: blkVerSize * 0.03),
// calendar
                SfDateRangePicker(
                  view: DateRangePickerView.month,
                  minDate: DateTime(DateTime.now().year, DateTime.now().month),
                  maxDate: DateTime(
                      DateTime.now().year, DateTime.now().month, lastDay),
                  monthViewSettings: DateRangePickerMonthViewSettings(
                    specialDates: widget.specialDates,
                    blackoutDates: widget.blackOutDates,
                  ),
                  monthCellStyle: DateRangePickerMonthCellStyle(
                    blackoutDatesDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.white),
                      color: Colors.red,
                    ),
                    blackoutDateTextStyle: const TextStyle(),
                    specialDatesDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.green),
                      color: Colors.green,
                    ),
                    specialDatesTextStyle: const TextStyle(color: Colors.black),
                    cellDecoration: const BoxDecoration(shape: BoxShape.circle),
                  ),
                  todayHighlightColor: Colors.green,
                  showActionButtons: bookingDate != null ? false : true,
                  confirmText: 'Confirm Date',
                  onSubmit: (date) {
                    // check if the date has session available
                    for (int i = 0; i < specialDatesD.length; i++) {
                      if (date == specialDatesD[i]) {
                        setState(() {
                          bookingDate = date as DateTime?;
                        });
                        confirmBookingFunc();
                        return;
                      } else {
                        print('sessions not available');
                      }
                    }
                  },
                ),
//
                SizedBox(height: blkVerSize * 0.05),
                Text(bookingTime!.isNotEmpty ? bookingTime.toString() : ''),
                SizedBox(height: blkVerSize * 0.01),
// time Picker
                ElevatedButton(
                  onPressed: () => selectTime(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kGreen,
                  ),
                  child: const Text('Select Time'),
                ),
                SizedBox(height: blkVerSize * 0.1),
// dropdown select sessions
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: navBarBck,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Sessions : ',
                        style: kPoppinsMedium.copyWith(color: Colors.white),
                      ),
                      DropdownButton(
                        iconEnabledColor: Colors.white,
                        dropdownColor: Colors.white,
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            sessionCount = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 1),
                const Align(
                    alignment: Alignment.bottomRight,
                    child: Text('1 session is 1 hour')),

                const SizedBox(height: 20),
//  confirm booking
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () => confirmBookingFunc(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kGreen,
                    ),
                    child: const Text('Confirm Booking'),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  confirmBookingFunc() async {
    if (bookingDate != null &&
        bookingTime.isNotEmpty &&
        sessionCount.isNotEmpty) {
      print('runing');
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          });
      String goal;
      if (docSnap != null) {
        goal = docSnap!['goal'];
      } else {
        await dbServices.fillDocSnap();
        goal = docSnap!['goal'];
      }

      ConfirmBookingModel model = ConfirmBookingModel(
        time: bookingTime,
        date: bookingDate!,
        sessions: sessionCount,
        image: widget.image,
        name: widget.name,
        goal: goal,
      );

      await dbServices.usersCollection
          .doc(dbServices.uid)
          .collection('pendingBookings')
          .add(model.toMap())
          .then((value) {
        Get.back();
      });
    } else {
      Get.snackbar('', 'fill everything to book');
    }
  }
}
