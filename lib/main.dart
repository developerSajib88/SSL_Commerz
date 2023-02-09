import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SSL_Commerz(),
    );
  }
}
class SSL_Commerz extends StatefulWidget {
  const SSL_Commerz({Key? key}) : super(key: key);

  @override
  State<SSL_Commerz> createState() => _SSL_CommerzState();
}

class _SSL_CommerzState extends State<SSL_Commerz> {


  TextEditingController totalAmount = TextEditingController();


 //This method called when I want to do payment then We are call this method or Function
 Future payment(double amount,)async{

   //This is Main area for SSL_Commerz
   Sslcommerz sslcommerz = Sslcommerz(
       initializer: SSLCommerzInitialization(
         //   ipn_url: "www.ipnurl.com",
           currency: SSLCurrencyType.BDT,
           product_category: "Food",
           sdkType: SSLCSdkType.TESTBOX,
           store_id: "learn637a7078165de",
           store_passwd: "learn637a7078165de@ssl",
           total_amount: amount,
           tran_id: "12124"
       )
   );

   try{
     SSLCTransactionInfoModel result = await sslcommerz.payNow();
     if(result.status!.toLowerCase() == "failed"){
       ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
               content: const Text("Payment Failed"),
               action: SnackBarAction(
                 label: "OK",
                 onPressed: () {  },
               ),
           ));
     }

     else if(result.status!.toLowerCase() == "closed"){
       ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
             content: const Text("Payment Closed"),
             action: SnackBarAction(
               label: "OK",
               onPressed: () {  },
             ),
           ));
     }

     else{

       ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
             content:  Text("Payment ${result.status} and Amount is ${result.amount}"),
             action: SnackBarAction(
               label: "OK",
               onPressed: () {  },
             ),
           ));

     }





   }catch(e){
     debugPrint(e.toString());
   }

 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SSL_Commerz"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200.0,
                  height: 50.0,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: totalAmount,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      labelText: "Enter Amount"
                    )
                  ),
                ),

                const SizedBox(height: 20.0,),

                SizedBox(
                  width: 200.0,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: (){
                      payment(double.parse(totalAmount.text));
                    },
                    child: const Text("PAY NOW"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

