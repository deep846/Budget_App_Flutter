import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
void main() async {
  await dotenv.load(fileName: '.env');  //waiting for env details
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        primaryColor: Colors.white,
      ),
      home: BudgetScreen(),
    );
  }
}



 class BudgetScreen extends StatefulWidget {
   const BudgetScreen({Key? key}) : super(key: key);

   @override
   _BudgetScreenState createState() => _BudgetScreenState();
 }

 class _BudgetScreenState extends State<BudgetScreen> {
   @override
   Widget build(BuildContext context) {
     return Scaffold();
   }
 }

