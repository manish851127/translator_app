import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:translator_app/history_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

List<Map<String, dynamic>> historyList= [

];

class Translator extends StatefulWidget {
  const Translator({super.key});

  @override
  State<Translator> createState() => _TranslatorState();
}

class _TranslatorState extends State<Translator> {
  final _box= Hive.box('testBox');
  // Current date and time
  String currentDateTime='';

  @override
  void initState() {
    updateDateTime();
    super.initState();
  }
  void updateDateTime(){
    currentDateTime=DateTime.now().toString();
  }

  void addValue(String first, String second, String datetime){
    historyList.add({
      "first":first,
      "second": second,
      'datetime': datetime,
    });
  }

  var languages=[
    'Hindi','English', 'Arabic'
  ];
  var originLanguage= 'From';
  var destinationLanguage='To';
  var output='Result..';
  TextEditingController languageController=TextEditingController();

  void translateFunction(String src, String dest, String input) async{
    GoogleTranslator translator= GoogleTranslator();
    var translation= await translator.translate(input, from: src, to: dest);
    setState(() {
      output= translation.text.toString();

      // History List
      addValue(languageController.text.toString(),output, currentDateTime);
      if(src=='--' || dest=='--'){
        output='Fail to translate';
      }
    },
    );



  }
  String getLanguageCode(String language){
    if(language=='English'){
      return 'en';
    }else if(language=='Hindi'){
      return 'hi';
    }else if(language=='Arabic'){
      return 'ar';
    }
     return "--";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HistoryPage()));
                  }, child: Text('History',style: TextStyle(fontSize: 20,color: Colors.grey,fontStyle: FontStyle.italic),)),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 50,bottom: 25),
            child: Text('LANGUAGE TRANSLATOR',
              style: GoogleFonts.actor(
                textStyle: TextStyle(color: Colors.black54),
                fontSize: 30,
              ),
            ),),
             ClipRRect(
               borderRadius: BorderRadius.circular(10),
                 child: Image.asset('assets/timg.jpg',height: 50,width: 50,),
             ),
            const SizedBox(height: 50,),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              DropdownButton(
                  // focusColor: Colors.white,
                  // iconDisabledColor: Colors.white,
                  // iconEnabledColor: Colors.white,
                  hint: Text(originLanguage,style: const TextStyle(color: Colors.black54,fontSize: 15
                  ),),
                  dropdownColor: Colors.white,
                  icon:const  Icon(Icons.keyboard_arrow_down_outlined,size: 20,),
        
                  items: languages.map((String dropDownStringItem){
                    return DropdownMenuItem(
                        child: Text(dropDownStringItem),
                        value: dropDownStringItem,
                    );
        
              },).toList(),
                onChanged: (value){
                  setState(() {
                    originLanguage=value!;
                  });
                },
        
              ),
              const  SizedBox(width: 30,),
              const Icon(Icons.arrow_right_alt,color: Colors.black54,size: 40,),
              const SizedBox(width: 30,),
              DropdownButton(
                // focusColor: Colors.white,
                // iconDisabledColor: Colors.white,
                // iconEnabledColor: Colors.white,
                hint: Text(destinationLanguage,style: const TextStyle(color: Colors.black54,fontSize: 15),),
                dropdownColor: Colors.white,
                icon: const Icon(Icons.keyboard_arrow_down_outlined,size: 20,),
        
                items: languages.map((String dropDownStringItem){
                  return DropdownMenuItem(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
        
                },).toList(),
                onChanged: (value){
                  setState(() {
                    destinationLanguage=value!;
                  });
                },
        
              ),
        
        
            ],),
            const SizedBox(height: 10,),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
            child: TextField(
              // keyboardType: TextInputType.emailAddress,
              // textInputAction: TextInputAction.next, // Change keyboard action
              autocorrect: true,
              // cursorColor: Colors.white,
              // autofocus: false,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                alignLabelWithHint: true,
                labelText: 'Please enter your text..',
                // labelStyle: TextStyle(fontSize: 15,color: Colors.white),
                border: OutlineInputBorder(
                   // borderSide: BorderSide(color: Colors.white70)
                ),
                // errorStyle: TextStyle(color: Colors.red,fontSize: 15),
              ),
              controller: languageController,
              // validator: (value){
              //   if(value== null || value.isEmpty){
              //     return 'Please enter text to translate';
              //   }
              //   return null;
              // },
        
            ),),
            Padding(padding: const EdgeInsets.all(8),
            child: Container(
              width: 150,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    side: BorderSide(width: 1,color: Colors.indigoAccent),
                  backgroundColor: Colors.green.shade800
                ),
                onPressed: (){
                  translateFunction(
                      getLanguageCode(originLanguage),
                      getLanguageCode(destinationLanguage),
                      languageController.text.toString()
                  );
                },
                child: const Text('Translate',style: TextStyle(fontSize: 15,color: Colors.white),),
              ),
            ),),
            const SizedBox(height: 10,),
            Text(
              "\n$output",
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
            )
        
        
          ],
        ),
      ),
    );
  }
}
