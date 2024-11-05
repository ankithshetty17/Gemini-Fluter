import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini/common/theme/theme_notifier.dart';
import 'package:gemini/data/model/messages.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final TextEditingController _controlller = TextEditingController();
  final List<messages> _messages= [];
  bool _isLoading = false;

  callGeminiModel() async{
   try{
   if(_controlller.text.isNotEmpty){
     _messages.add(messages(text: _controlller.text, isUser: true));
     _isLoading= true;
   }

    final model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: dotenv.env['google_api_key']!
  );
  final prompt = _controlller.text.trim();
  final content = [Content.text(prompt)];
  final response = await model.generateContent(content);
 
  setState(() {
    _messages.add(messages(text:response.text!, isUser:false));
    _isLoading= false;
  });

  _controlller.clear();


   } catch(e){
    print('Error: $e');
   }
  }
  
  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.read(themeProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title:Row(
          children: [
           const  Icon(Icons.smart_toy_outlined,color: Colors.blue,size: 34,),
           const  SizedBox(width: 5),
            Text('Gemini-Chat',style:  Theme.of(context).textTheme.titleLarge,)
          ],
        ),
        actions: [
          IconButton(onPressed: (){
              ref.read(themeProvider.notifier).toggleTheme();
          },
           icon:(currentTheme == ThemeMode.dark) ? Icon(Icons.light_mode,color:Theme.of(context).colorScheme.secondary,) 
           : Icon(Icons.dark_mode,color: Theme.of(context).colorScheme.primary,)
          ),
        ],
      ),
      body:
       Column(
         children: [
           Expanded(
             child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context,index){
                final message = _messages[index];
                return ListTile(
                 title: Align(
                  alignment:message.isUser ? Alignment.centerRight : Alignment.centerLeft,
                   child: Container(
                    padding: const EdgeInsets.all(10),
                    child:Text(
                      message.text,
                      style: TextStyle(
                        color: message.isUser ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold
                      ),),
                    decoration: BoxDecoration(
                      color: message.isUser ? Colors.grey[300] : Colors.blue,
                      borderRadius: message.isUser ? const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ) : const  BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ) ,
                    ),
                   ),
                 )
                );
              }),
           ),
           Padding(
            padding:const  EdgeInsets.only(bottom:20,left: 16, right: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color:Colors.white),
                boxShadow:const  [
                  BoxShadow(
                    color:Color.fromARGB(255, 211, 244, 248),
                    blurRadius: 3,
                    spreadRadius: 0,
                    offset: Offset(2, 2)
                  )
                ]
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controlller,
                      style: Theme.of(context).textTheme.titleSmall,
                      decoration:const  InputDecoration(
                        hintText: 'Enter Message',
                        hintStyle:TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: InputBorder.none
                      ),
                    ),
                    ),
                    SizedBox(width: 8,),
                    _isLoading ?
                     Padding(padding: EdgeInsets.all(8),
                    child:
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    )
                    )
                   : Padding(padding: EdgeInsets.all(12),
                    child:
                    IconButton(
                      onPressed: callGeminiModel, 
                      icon:const  Icon(Icons.send,color: Colors.blue,))
                    ),
                ],
              ),
            ),
           ),
         ],
       ),
    );
  }
}