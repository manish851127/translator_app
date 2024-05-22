import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translator/translator.dart';
import 'package:translator_app/langauge_tranlation.dart';
class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});


  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return
       SafeArea(
         child: Scaffold(
           body: Column(
             children: [
               Padding(padding: EdgeInsets.all(10),child: Center(child: Text('History',style: TextStyle(fontSize: 30),),),),
               Expanded(
                 child: ListView.builder(
                  padding: const EdgeInsets.only(top: 0,left: 20),
                  itemCount: historyList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text('${historyList[index]['first']}'),
                      subtitle: Text('${historyList[index]['second']}'),
                      trailing: Text('${historyList[index]['datetime']}'),
                      // height: 60,
                      // // color: Colors.amber,
                      // child: Column(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text('${historyList[index]['first']}',
                      //       style: GoogleFonts.lato(
                      //         textStyle: TextStyle(color: Colors.black54),
                      //         fontSize: 12,
                      //         fontWeight: FontWeight.w700,
                      //         fontStyle: FontStyle.normal,
                      //       )
                      //     ),
                      //     SizedBox(height: 10,),
                      //     Text('${historyList[index]['second']}',
                      //         style: GoogleFonts.lato(
                      //           textStyle: TextStyle(color: Colors.black54),
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.w500,
                      //           fontStyle: FontStyle.italic,
                      //         )
                      //     ),
                      //
                      //   ],
                      // ),
                    );
                  },
                  // separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 0,),
                       ),
               ),
             ],
           ),
         ),
       );

  }
}
