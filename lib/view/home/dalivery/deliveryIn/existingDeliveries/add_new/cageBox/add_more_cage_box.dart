
import 'package:crm/view/home/dalivery/deliveryIn/existingDeliveries/add_new/cageBox/show_cage_box.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AddMoreCageBox extends StatefulWidget {
  const AddMoreCageBox({super.key});

  @override
  State<AddMoreCageBox> createState() => _AddMoreCageBoxState();
}

class _AddMoreCageBoxState extends State<AddMoreCageBox> {

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppWidget(
      appBarTitle: "Delivery In ID: D1000034",
      appBarOnBack: ()=>Get.back(),
      body:  SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            SizedBox(height: size.height*.02,),
            const Center(child: Text("Cage/Box",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600
              ),
            ),),
            SizedBox(height: size.height*.08,),
            Row(
              children: [
                const Expanded(
                  child: Text("User ID",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 15
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
                Expanded(
                    flex: 2,
                    child: TextFormField(
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none
                          ),
                          hintText: "Auto Fill up"
                      ),
                    )
                )
              ],
            ),

            const SizedBox(height: 20,),
            Row(
              children: [
                const Expanded(
                  child: Text("User Name",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 15
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
                Expanded(
                    flex: 2,
                    child: TextFormField(
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none
                          ),
                          hintText: "Auto Fill up"
                      ),
                    )
                )
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                const Expanded(
                  child: Text("Date",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 15
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
                Expanded(
                    flex: 2,
                    child: TextFormField(
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none
                          ),
                          hintText: "Auto Fill up"
                      ),
                    )
                )
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                const Expanded(
                  child: Text("Weight",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 15
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
                Expanded(
                    flex: 2,
                    child: TextFormField(
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none
                          ),
                          hintText: "40KG"
                      ),
                    )
                )

              ],
            ),

            const SizedBox(height: 70,),
            InkWell(
              onTap: ()=>Get.to(const ShowCageBox()),
              child: Container(
                width: 200,
                height: 60,
                decoration: BoxDecoration(
                    gradient: AppWidgets.buildLinearGradient(),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: const Center(
                  child: Text("Input",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 16
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );

  }
}
