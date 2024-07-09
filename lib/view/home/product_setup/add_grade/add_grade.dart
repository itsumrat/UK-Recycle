import 'package:crm/controller/production_setup/gradeController.dart';
import 'package:crm/model/delivery_model/grade_model/grade_model.dart';
import 'package:crm/view/home/product_setup/product_setup.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AddGrade extends StatefulWidget {
  const AddGrade({super.key});

  @override
  State<AddGrade> createState() => _AddGradeState();
}

class _AddGradeState extends State<AddGrade> {
  List list = [
    "A",
    "B",
    "c",
  ];

  final name = TextEditingController();

  Future<GradeModel>? getGradeFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGradeFuture = GradeController.getGradeList();

  }


  @override
  Widget build(BuildContext context) {
    return AppWidget(
      appBarTitle: "Grade",
      appBarOnBack: ()=>Get.to(const ProductSetup()),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child:  TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none
                          ),
                          hintText: "Grade Name"
                      ),
                    )
                ),
                const SizedBox(width: 15,),
                InkWell(
                  onTap: ()async{
                    var res = await GradeController.createNewGrade(name: name.text);
                    if(res.statusCode == 200){
                      getGradeFuture = GradeController.getGradeList();
                      name.clear();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Grade added success."),
                        backgroundColor: Colors.green,
                        duration: Duration(milliseconds: 3000),
                      ));
                    }

                    setState(() {});
                  },
                  child: Container(
                    width: 100,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: AppWidgets.buildLinearGradient()
                    ),
                    child: const Center(
                      child: Text("Add",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
            const SizedBox(height: 20,),
            Expanded(
              //height: 500,
              child: FutureBuilder<GradeModel>(
                future: getGradeFuture,
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: AppLoader(),);
                  }else if(snapshot.hasData){
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (_, index){

                        var data = snapshot.data!.data![index];
                        return Container(
                          padding: const EdgeInsets.all(20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            //borderRadius: BorderRadius.circular(5),
                              border: Border(
                                left: BorderSide(width: 1, color: Colors.grey.shade400),
                                right: BorderSide(width: 1, color: Colors.grey.shade400),
                                top: BorderSide(width: index == 0 ? 1:0, color: Colors.grey.shade400),
                                bottom: BorderSide(width: 1, color: Colors.grey.shade400),
                              )
                          ),
                          child: Text("${data.name}"),
                        );
                      },
                    );
                  }else{
                    return const Center(child: Text("Something went wrong"),);
                  }
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
