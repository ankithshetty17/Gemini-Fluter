import 'package:flutter/material.dart';
import 'package:gemini/messages.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controlller = TextEditingController();
  final List<messages> _messages= [
    messages(text: 'Hi', isUser: true),
    messages(text: 'Hello', isUser: false),
    messages(text: 'How Are You !!', isUser: true),
    messages(text: 'How Was Ur Dayy', isUser: false)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title:Row(
          children: [
            Icon(Icons.smart_toy_outlined,color: Colors.blue,size: 34,),
            SizedBox(width: 5),
            Text('Gemini-Chat',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
          ],
        ),
        actions: [
          IconButton(onPressed: (){},
           icon:Icon(Icons.volume_down_alt,color: Colors.blue,))
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
                boxShadow: [
                  BoxShadow(
                    color:Color.fromARGB(255, 211, 244, 248),
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: Offset(0, 2)
                  )
                ]
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controlller,
                      decoration:const  InputDecoration(
                        hintText: 'Enter Message',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: InputBorder.none
                      ),
                    ),
                    ),
                    IconButton(
                      onPressed: (){}, 
                      icon:const  Icon(Icons.send,color: Colors.blue,))
                ],
              ),
            ),
           ),
         ],
       ),
    );
  }
}