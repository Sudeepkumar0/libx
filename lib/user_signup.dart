import 'package:flutter/material.dart';

class usersignup extends StatefulWidget {
  const usersignup({super.key});

  @override
  State<usersignup> createState() => _usersignupState();
}

class _usersignupState extends State<usersignup> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: sigup(),
    );
  }
}

class sigup extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Form(child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       children: [
         //Image
         Padding(
           padding: const EdgeInsets.only(top: 90),
           child: Center(
             child: Container(
               width: 200,
               height: 180,
               child: Image.asset('assets/education.png'),
             ),
           ),
         ),
         //img closed here
         //---------------------------------------------------------
         // Register Text
         Container(
           child: Text(
             'Registration',style: TextStyle(
             color: Colors.deepPurpleAccent.withOpacity(0.9),
             fontWeight: FontWeight.bold,
             fontSize: 40
           ),
           ),
         ),


         SizedBox(
           height: 20,
         ),
         //text closed here

         //---------------------------------------------------------

       //Text field   user name

         Container(
           width: 300,
           height: 50,
           child: TextField(
             decoration: InputDecoration(
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(5),

               ),
               labelText: "User_Name",
               floatingLabelBehavior: FloatingLabelBehavior.always,
               hintText: "Enter Your Name",
             ),obscureText:true ,
           ),
         ),
         //closed Text field   user name
         SizedBox(
           height: 20,
         ),

         //---------------------------------------------------------
         //Text field Email

         Container(
           width: 300,
           height: 50,
           child: TextField(
             decoration: InputDecoration(
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(5),
                 borderSide: BorderSide(color: Colors.deepPurpleAccent,width: 2),

               ),
               labelText: "Email",
               floatingLabelBehavior: FloatingLabelBehavior.always,
               hintText: "Enter Your Email",
             ),obscureText:true ,
           ),
         ),
         // close Text field Email


         SizedBox(
           height: 20,
         ),
         //---------------------------------------------------------
         //Text field password


         Container(
           width: 300,
           height: 50,
           child: TextField(
             decoration: InputDecoration(
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(5),
                 borderSide: BorderSide(color: Colors.deepPurpleAccent,width: 2),

               ),
               labelText: "Password",
               floatingLabelBehavior: FloatingLabelBehavior.always,
               hintText: "Enter Your Password",
             ),obscureText:true ,
           ),
         ),

         SizedBox(
           height: 20,
         ),
         //---------------------------------------------------------
         //Text field Re enter pass

         Container(
           width: 300,
           height: 50,
           child: TextField(
             decoration: InputDecoration(
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(5),
                 borderSide: BorderSide(color: Colors.deepPurpleAccent,width: 2),

               ),
               labelText: "Re_Enter_Your_Password",
               floatingLabelBehavior: FloatingLabelBehavior.always,
               hintText: "Enter Your Password",
             ),obscureText:true ,
           ),
         ),


         SizedBox(
           height: 20,
         ),
         //---------------------------------------------------------
         // register btn

         Container(
           width: 190,
           height: 40,
           child: Center(child: Text('Register',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),)),
           decoration: BoxDecoration(
             color: Colors.deepPurpleAccent ,
             borderRadius: BorderRadius.circular(12),
             boxShadow: [
               BoxShadow(
                 color: Colors.deepPurple.withOpacity(0.9),
                 spreadRadius:1,
                 blurRadius: 6,
               ),
             ]
           ),
         ),

         SizedBox(
           height: 25,
         ),
         //---------------------------------------------------------
         InkWell(
           child: Container(
             child: Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Padding(
                   padding: const EdgeInsets.only(left:70),
                   child: Text(
                     'Already have an account?',style: TextStyle(fontSize: 16),
                   ),
                 ),
                 Container(
                   child: InkWell(
                     child: Text(
                       'Login',style: TextStyle(color: Colors.deepPurple,fontSize: 16),
                     ),
                   ),
                 ),
               ],
             ),
           ),
         ),
       ],
     ),

     ),

   );
  }

}
