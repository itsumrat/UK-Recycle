import 'package:crm/controller/delivery_controller%20/in_controller/product_category_controller.dart';
import 'package:crm/model/delivery_model/in_model/product_category_model.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/loader.dart';
import 'package:crm/view_controller/snackbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AddProductCategory extends StatefulWidget {
  const AddProductCategory({super.key});

  @override
  State<AddProductCategory> createState() => _AddProductCategoryState();
}

class _AddProductCategoryState extends State<AddProductCategory> {
  List cat = [
    "Product Category",
    "Product Category",
    "Product Category",
    "Product Category",
    "Product Category",
    "Product Category",
    "Product Category",
    "Product Category",
    "Product Category",
    "Product Category"
  ];

  final name = TextEditingController();
  bool isAdding = false;

  Future<ProductCategoryMdel>? getProductCategoryModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductCategoryModel = DeliveryInProductCategoryController.getProductCategory();
  }


  @override
  Widget build(BuildContext context) {
    return AppWidget(
      appBarTitle: "Add product category",
      appBarOnBack: ()=>Get.back(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 70,
              child: Row(
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
                            hintText: "Add product category"
                        ),
                      )
                  ),
                  const SizedBox(width: 15,),
                  InkWell(
                    onTap: ()=> _createProductCategory(),
                    child: Container(
                      width: 100,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: AppWidgets.buildLinearGradient()
                      ),
                      child: Center(
                        child: isAdding ? const CircularProgressIndicator(color: Colors.white,) : const Text("Add",
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
            ),
            const SizedBox(height: 20,),
            FutureBuilder<ProductCategoryMdel>(
              future: getProductCategoryModel,
              builder: (context,snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Padding( 
                    padding: EdgeInsets.only(top: 100),
                    child: Center(child: AppLoader()),);
                }else if(snapshot.hasData){
                  return SizedBox(
                    //height: 500,
                    child: ListView.builder(
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
                    ),
                  );
                }else{
                  return const Center(child: Text("No category found"),);
                }
              }
            ),
          ],
        ),
      ),
    );
  }

  void _createProductCategory() async{
    setState(() => isAdding = true);
    var res = await DeliveryInProductCategoryController.addProductCategory(name: name.text);
    if(res.statusCode == 200){
      getProductCategoryModel = DeliveryInProductCategoryController.getProductCategory();
      setState(() {});
      AppSnackbar.appSnackbar("Product Category added.", Colors.green, context);
    }else{
      AppSnackbar.appSnackbar("Something went wrong.", Colors.red, context);
    }
    setState(() => isAdding = false);
  }
}
