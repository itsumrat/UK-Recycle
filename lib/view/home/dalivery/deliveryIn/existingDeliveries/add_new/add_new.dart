import 'package:crm/utility/utility.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../createNewDelivery.dart';
import '../singleExistingDeliveries.dart';
import 'cageBox/create_cage_box.dart';
import 'pieces_pallet/create_new_pieces.dart';


class AddNewExistingDeliveries extends StatefulWidget {
  const AddNewExistingDeliveries({Key? key}) : super(key: key);

  @override
  State<AddNewExistingDeliveries> createState() => _AddNewExistingDeliveriesState();
}

class _AddNewExistingDeliveriesState extends State<AddNewExistingDeliveries> {
  @override
  Widget build(BuildContext context) {
    return AppWidget(
      appBarOnBack: ()=>Get.back(),
      appBarTitle: "Delivery In ID: DI000001",
      textSize: 25,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: ()=>Get.to(CreateNewCageBox()),
                    child: Container(
                      height: 220,
                      decoration: BoxDecoration(
                          gradient: AppWidgets.buildLinearGradient(),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.shirt,size: 50, color: Colors.white,),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: InkWell(
                    onTap: ()=>Get.to(CreateNewPiecesPallet()),
                    child: Container(
                      height: 220,
                      decoration: BoxDecoration(
                          gradient: AppWidgets.buildLinearGradient(),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.shirt,size: 50, color: Colors.white,),
                          SizedBox(height: 30,),
                          Text("Pieces/Pallet",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 18
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
