
import 'package:crm/view/home/dalivery/deliveryIn/existingDeliveries/transactions.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ShowTranscations extends StatefulWidget {
  const ShowTranscations({super.key});

  @override
  State<ShowTranscations> createState() => _ShowTranscationsState();
}

class _ShowTranscationsState extends State<ShowTranscations> {

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
      appBarTitle: "NEW Deliveries",
      appBarOnBack: ()=>Get.back(),
      body:  SingleChildScrollView(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 50, top: 20),
        child: Column(
          children: [
            SizedBox(height: size.height*.05,),
            const Center(
              child: Text("New Cage/Box ID Create DI0000213/01",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87
                ),
              ),
            ),
            const SizedBox(height: 30,),
            const Row(
              children: [
                Expanded(
                  child: Text("User ID: ",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 15
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                    flex: 2,
                    child: Text("SUP00001",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 18
                      ),
                    )
                )
              ],
            ),

            const SizedBox(height: 40,),
            const Row(
              children: [
                Expanded(
                  child: Text("User Name: ",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 15
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                    flex: 2,
                    child: Text("Mr Nayon",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 18
                      ),
                    )
                )
              ],
            ),
            const SizedBox(height: 40,),
            const Row(
              children: [
                Expanded(
                  child: Text("TRX ID",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 15
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                    flex: 2,
                    child: Text("DI000125",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 18
                      ),
                    )
                )
              ],
            ),
            const SizedBox(height: 40,),
            const Row(
              children: [
                Expanded(
                  child: Text("Date: ",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 15
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                    flex: 2,
                    child: Text("38/06/2022",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 18
                      ),
                    )
                )
              ],
            ),
            const SizedBox(height: 40,),

            const Row(
              children: [
                Expanded(
                  child: Text("Suppliers Name: ",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 15
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                    flex: 2,
                    child: Text("Suppliers Name 1",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 18
                      ),
                    )
                )
              ],
            ),
            const SizedBox(height: 40,),
            const Row(
              children: [
                Expanded(
                  child: Text("Delivery Type: ",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 15
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                    flex: 2,
                    child: Text("New",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 18
                      ),
                    )
                )
              ],
            ),
            const SizedBox(height: 40,),
            const Row(
              children: [
                Expanded(
                  child: Text("Product Type: ",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 15
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                    flex: 2,
                    child: Text("Toys",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 18
                      ),
                    )
                )
              ],
            ),
            const SizedBox(height: 40,),
            const Row(
              children: [
                Expanded(
                  child: Text("Cage No: ",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 15
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                    flex: 2,
                    child: Text("Toys",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 18
                      ),
                    )
                )
              ],
            ),
            const SizedBox(height: 40,),
            const Row(
              children: [
                Expanded(
                  child: Text("Weight: ",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 15
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                    flex: 2,
                    child: Text("40 KG",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 18
                      ),
                    )
                )
              ],
            ),

            const SizedBox(height: 70,),
            InkWell(
              onTap: ()=>Get.to(const Transactions()),
              child: Container(
                width: 200,
                height: 60,
                decoration: BoxDecoration(
                    gradient: AppWidgets.buildLinearGradient(),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: const Center(
                  child: Text("Back",
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
