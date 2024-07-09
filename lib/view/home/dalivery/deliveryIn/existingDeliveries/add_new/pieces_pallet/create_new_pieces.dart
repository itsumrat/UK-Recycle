
import 'package:crm/view/home/dalivery/deliveryIn/existingDeliveries/add_new/pieces_pallet/showPiecesPallet.dart';

import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CreateNewPiecesPallet extends StatefulWidget {
  const CreateNewPiecesPallet({super.key});

  @override
  State<CreateNewPiecesPallet> createState() => _CreateNewPiecesPalletState();
}

class _CreateNewPiecesPalletState extends State<CreateNewPiecesPallet> {

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
      appBarTitle: "Deliveries In ID: DI000012",
      textSize: 20,
      appBarOnBack: ()=>Get.back(),
      body:  SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 50,),
            const Text("Weight/Pallet",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 30
              ),
            ),
            const SizedBox(height: 50,),
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
                      items: items
                          .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                      buttonStyleData:  ButtonStyleData(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(5)
                        ),
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
            const SizedBox(height: 20,),
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
                          hintText: "User ID 02"
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
                  child: Text("Delivery Type",
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
                      items: items
                          .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                      buttonStyleData:  ButtonStyleData(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(5)
                        ),
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
            const SizedBox(height: 20,),
            Row(
              children: [
                const Expanded(
                  child: Text("Product Category",
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
                      items: items
                          .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                      buttonStyleData:  ButtonStyleData(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(5)
                        ),
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
            const SizedBox(height: 20,),
            Row(
              children: [
                const Expanded(
                  child: Text("Pieces",
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none
                          ),
                          hintText: "12 "
                      ),
                    )
                )

              ],
            ),


            const SizedBox(height: 70,),
            InkWell(
              onTap: ()=>Get.to(const ShowPiecesPallet()),
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
            ),
            const SizedBox(height: 30,),

          ],
        ),
      ),
    );

  }
}
