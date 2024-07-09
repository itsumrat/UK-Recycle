import 'package:crm/controller/attendance_controller/attendance_controller.dart';
import 'package:crm/controller/user_controller/userController.dart';
import 'package:crm/model/user_model/allUserModel.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/loader.dart';
import 'package:crm/view_controller/snackbar_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Clicking extends StatefulWidget {
  const Clicking({super.key});

  @override
  State<Clicking> createState() => _ClickingState();
}

class _ClickingState extends State<Clicking> {
  final List<String> items = [
    'Name 2',
    'Name 2',
  ];
  var selectedValue;
  final passKey = TextEditingController();
  final time = TextEditingController();
  final date = TextEditingController();

  final dateNow = DateTime.now();
  TimeOfDay timeNow = TimeOfDay.now();
  var selectedPassKey;

  bool isLoading = false;
  bool isClockInOut = false;
  final List<UserDatum> _allUserList = [];
  getAllUser() async {
    setState(() => isLoading = true);
    var res = await UserController.getAllUserList();
    for (var i in res.data!) {
      setState(() {
        _allUserList.add(i);
      });
    }
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllUser();
    date.text = DateFormat('yyyy-MM-dd').format(dateNow);
    time.text = "${timeNow.hour}:${timeNow.minute}";
  }

  @override
  Widget build(BuildContext context) {
    return AppWidget(
      appBarTitle: "Check In",
      appBarOnBack: () => Get.back(),
      body: isLoading
          ? const Center(
              child: AppLoader(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Date",
                          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          flex: 2,
                          child: TextFormField(
                            readOnly: true,
                            controller: date,
                            onTap: () => selectDate(context),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                border: const OutlineInputBorder(borderSide: BorderSide.none),
                                hintText: "Auto Fill up"),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Time",
                          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          flex: 2,
                          child: TextFormField(
                            readOnly: true,
                            onTap: () => selectTime(context: context),
                            controller: time,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                border: const OutlineInputBorder(borderSide: BorderSide.none),
                                hintText: "Input"),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Name",
                          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 2,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              'Select One',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: _allUserList
                                .map((item) => DropdownMenuItem<String>(
                                      value: item.id!.toString(),
                                      child: Text(
                                        item.name!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                                for (var i in _allUserList) {
                                  if (i.id.toString().contains(selectedValue)) {
                                    selectedPassKey = i.passkey.toString();
                                  }
                                }
                              });
                              print("selectedValue == $selectedValue");
                            },
                            buttonStyleData: ButtonStyleData(
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)),
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              height: 60,
                              width: 140,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Pass Key",
                          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: passKey,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                border: const OutlineInputBorder(borderSide: BorderSide.none),
                                hintText: "Input"),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  InkWell(
                    onTap: () async {
                      if (selectedPassKey == passKey.text) {
                        setState(() => isClockInOut = true);
                        var res = await AttendnaceController.clockIn(
                            date: date.text,
                            time: time.text,
                            userId: selectedValue.toString(),
                            passKey: passKey.text.toString());
                        print("data == ${res.body}");
                        if (res.statusCode == 200) {
                          time.clear();
                          date.clear();
                          selectedValue = null;
                          passKey.clear();
                          AppSnackbar.appSnackbar("Clock in success", Colors.green, context);
                        } else {
                          AppSnackbar.appSnackbar("Something went wrong.", Colors.red, context);
                        }
                        setState(() => isClockInOut = false);
                      } else {
                        AppSnackbar.appSnackbar("Pass key wrong.", Colors.red, context);
                      }
                    },
                    child: Container(
                      width: 200,
                      height: 60,
                      decoration: BoxDecoration(
                          gradient: AppWidgets.buildLinearGradient(), borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: isClockInOut
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Input",
                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white, fontSize: 16),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
    );
  }

  //select time
  Future<String> selectTime({required BuildContext context}) async {
    TimeOfDay selectedTime = TimeOfDay.now();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        //time.text  = formatTimeOfDay(picked);
        time.text = "${picked.hour}:${picked.minute}";
      });
    }
    return picked!.format(context);
  }

  //select date
  Future<void> selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      print("Selected date: ${DateFormat('DD-MM-YYYY').format(picked)}");
      setState(() {
        date.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  //convert time into am pm
  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final formattedTime = DateFormat.jm().format(dateTime); // 'jm' formats time as AM/PM
    return formattedTime;
  }
}
