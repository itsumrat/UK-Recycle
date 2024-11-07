import 'package:crm/view/flash_screen/flash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UK TEXTILE AND RECYCLING',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FlashScreen(),
    );
  }
}
