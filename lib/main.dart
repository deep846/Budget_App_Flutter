
import 'package:budgetapp/failure_model.dart';
import 'package:budgetapp/item_model.dart';
import 'package:budgetapp/spending_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

import 'budget_repository.dart';
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
   late Future<List<Item>> _futureItems;
   void initState() {
    super.initState();
    _futureItems = BudgetRepository().getItems();
  }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Center(child: Text('Budget Tracker'),),
       ),
       body: RefreshIndicator(
                 onRefresh: () async {
          _futureItems = BudgetRepository().getItems();
          setState(() {});
        },
         child: FutureBuilder<List<Item>>(
           future: _futureItems,
           builder: (context,snapshot){
             if(snapshot.hasData){
                final items = snapshot.data!;
                return ListView.builder(
                  itemCount: items.length+1,
                  itemBuilder: (BuildContext context, int index){
                    if(index==0)return SpendingChart(items: items);
                    final item = items[index-1];
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          width: 2.0,
                          color: getCategoryColor(item.category),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0 , 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(item.name),
                        subtitle: Text('${item.category} . ${DateFormat.yMd().format(item.date)}'),
                        trailing: Text('-\₹${item.price.toStringAsFixed(2)}'),
                      ),
                    );
                  },
                );
             }
             else if(snapshot.hasError)
               {
                 print('there is some error');
                 final failure = snapshot.error as Failure;
                 return Center(child:Text(failure.message) ,);
               }
             print('there is some error');
             return const Center(child: CircularProgressIndicator(),);
           },
         ),
       ),
     );
   }
 }

Color getCategoryColor(String category) {
  switch (category) {
    case 'Entertainment':
      return Colors.red[400]!;
    case 'Food':
      return Colors.green[400]!;
    case 'Personal':
      return Colors.blue[400]!;
    case 'Transportation':
      return Colors.purple[400]!;
    default:
      return Colors.orange[400]!;
  }
}