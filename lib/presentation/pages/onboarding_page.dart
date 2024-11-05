import 'package:flutter/material.dart';
import 'package:gemini/presentation/pages/my_home_page.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(18),
        child: Center(
          child:
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        const   Column(
            children:[
          Text('Your Ai Assistant',
          style: TextStyle(color: Colors.blue,
                           fontWeight: FontWeight.bold,
                           fontSize:30),),
          SizedBox(height: 15,),
          Text('Using this software, you can ask you questions and receive articles using artificial intelligence assistant.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey,
                           fontWeight: FontWeight.bold,
                           fontSize:12),),
            ],
          ),
          Image.asset('assets/onboarding.png'),
              ElevatedButton(
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context, 
                   MaterialPageRoute(builder: (context) => const MyHomePage()),
                   (route) => false);
                },
               child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Continue'),
                  Icon(Icons.arrow_right_rounded)
                ],
               ),
               style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
                  padding:const  EdgeInsets.symmetric(horizontal: 32,vertical: 16)
                )
               ),
        ],
        ),
        ),
      ),
    );
  }
}