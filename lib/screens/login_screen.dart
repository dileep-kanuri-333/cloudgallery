// ignore_for_file: sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:galleryproject999666333/animations/fadindown.dart';
import 'package:galleryproject999666333/contsants/constants.dart';
import 'package:galleryproject999666333/screens/otpverify_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';


var phNoloadingprovider=StateProvider<bool>((ref) => false);

TextEditingController phoneNoController=TextEditingController();


class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
     bool isLoadings=ref.watch(phNoloadingprovider);
              
              // var formkey=GlobalKey<FormState>();
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body:isLoadings?const Center(child: CircularProgressIndicator(),): SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 400,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -40,
                    height: 400,
                    width: width,
                    child: FadeInDown(duration: const Duration(seconds: 1), child: Container(
                      decoration:const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill
                        )
                      ),
                    )),
                  ),
                  Positioned(
                    height: 400,
                    width: width+20,
                    child: FadeInDown(duration: const Duration(milliseconds: 1300), child: Container(
                      decoration:const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/background-2.png'),
                          fit: BoxFit.fill
                        )
                      ),
                    )),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FadeInDown(duration: Duration(milliseconds: 1600), child: Text("Login", style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),)),
                  const SizedBox(height: 16,),
                          Text("Enter your Mobile Number below",style: GoogleFonts.aBeeZee().copyWith(fontSize: 23,color: Colors.grey),),
                  const SizedBox(height: 23,),

                     FadeInDown(duration: const Duration(milliseconds: 1900), child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: const Color.fromRGBO(196, 135, 198, .3)),
                      boxShadow:const [
                        BoxShadow(
                          color: Color.fromRGBO(196, 135, 198, .3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        )
                      ]
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child:  TextFormField(
                                          controller: phoneNoController,
                                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9 +]'))],
                                          keyboardType: TextInputType.number,
                                          decoration:const InputDecoration(
                    hintText: "your 10 digits phone number",
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.phone),
                    
                                          ),
                                          validator: (value) => value!.isEmpty? "phone number should not be empty":null,
                                        
                                        ),
                    ),
                  )),
                  const SizedBox(height: 30,),
                Center(
                  child: FadeInDown(duration: const Duration(milliseconds: 2300),
                    child: ElevatedButton(onPressed: () async{
                        
                          // if(phoneNoController.text==FirebaseFirestore.instance.collection("Users").doc(id))
                       
                          ref.read(phNoloadingprovider.notifier).state=true;
                     ref.read(otploadingprovider.notifier).state=false;
                    
                           await savePhoneNumber(phoneNoController.text);
                        try{
                              
                               await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber:("+91 ")+ phoneNoController.text,
                              verificationCompleted: (PhoneAuthCredential credential){
                                     
                              },
                     verificationFailed: (FirebaseAuthException e){
                          ref.read(phNoloadingprovider.notifier).state=false;
                      Get.snackbar("Error occured 1", e.code);
                     },
                      codeSent:  (verificationId, forceResendingToken) async{
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>OtpVerification(vid: verificationId,phoneNumber: phoneNoController.text,)), (route) => false);
                       
                    
                      }, 
                      codeAutoRetrievalTimeout: (verificationId){}
                      );}
                               on FirebaseAuthException catch(e){
                          // ref.read(phNoloadingprovider.notifier).state=false;
                                    Get.snackbar("Error Occured 2", e.code);
                               }catch (e){
                          ref.read(phNoloadingprovider.notifier).state=false;
                    
                    Get.snackbar("Error Occured 3" , e.toString());
                               }
                    
                                     
                    },
                    style:  ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll( Appconstants.mainthemeColor
                    ),
                      foregroundColor: const MaterialStatePropertyAll(Colors.white),
                      
                    
                    )
                    , child:const Text("Send OTP")),
                  ),
                ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
   Future<void> savePhoneNumber(String phoneNumber) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('phoneNumber', phoneNumber);
}
}
// var phNoloadingprovider=StateProvider<bool>((ref) => false);

// TextEditingController phoneNoController=TextEditingController();
// class LoginScreen extends ConsumerStatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   ConsumerState<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends ConsumerState<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//         bool isLoadings=ref.watch(phNoloadingprovider);
              
//               var formkey=GlobalKey<FormState>();
//     return Scaffold(
//       body:isLoadings?const Center(child: CircularProgressIndicator(),): Container(
//         width: double.infinity,
//         decoration:const BoxDecoration(
//           gradient: LinearGradient(
           
//             colors: 
//           [
//            Color.fromARGB(255, 33, 92, 242),
//                        Color.fromARGB(255, 52, 106, 243),


//                            Color.fromARGB(255, 97, 139, 244),

//           ])
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
// const SizedBox(height: 30,),
//            const Padding(
//               padding:  EdgeInsets.all(8.0),
//               child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,

//                 children: [
//                   Text("Login",style:TextStyle(fontSize: 44,color: Colors.white),),
//                   Text("welcome back to Gallery",style:TextStyle(fontSize: 19,color: Colors.white),),

//                 ],
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 decoration:const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(topLeft: Radius.circular(44),topRight:  Radius.circular(44))
//                 ),
//                 child: Padding(padding: const EdgeInsets.all(9),
//                 child: Form(
//           key: formkey,
//           child: Container(
//             padding:const EdgeInsets.all(33),
//             child: Column(
//               children: [
//               //   FadeInDown(duration:const Duration(milliseconds: 1300),child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdh-231pU2HwfbW8NQskwzvN4R7q-_tj6etg&s")),
//               //  const  SizedBox(height: 30,),
//                 Text("Enter your Mobile Number below",style: GoogleFonts.aBeeZee().copyWith(fontSize: 33,color: Colors.grey),),
//               const  SizedBox(height: 23,),
//                 Card(
//                   elevation: 4,
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 9),
//                     child: TextFormField(
//                       controller: phoneNoController,
//                       inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9 +]'))],
//                       keyboardType: TextInputType.number,
//                       decoration:const InputDecoration(
//                         hintText: "your 10 digits phone number",
//                         border: InputBorder.none,
//                         suffixIcon: Icon(Icons.phone),
                        
//                       ),
//                       validator: (value) => value!.isEmpty? "phone number should not be empty":null,
                    
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 23,),

//                const SizedBox(height: 23,),
//                 ElevatedButton(onPressed: () async{
//                       ref.read(phNoloadingprovider.notifier).state=true;
//                  ref.read(otploadingprovider.notifier).state=false;
                
//                        await savePhoneNumber(phoneNoController.text);
//                       // if(phoneNoController.text==FirebaseFirestore.instance.collection("Users").doc(id))
                               
//                     try{
                          
//                            await FirebaseAuth.instance.verifyPhoneNumber(
//                           phoneNumber:("+91 ")+ phoneNoController.text,
//                           verificationCompleted: (PhoneAuthCredential credential){
                                 
//                           },
//                  verificationFailed: (FirebaseAuthException e){
//                       ref.read(phNoloadingprovider.notifier).state=false;
//                   Get.snackbar("Error occured 1", e.code);
//                  },
//                   codeSent:  (verificationId, forceResendingToken) async{
//                     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>OtpVerification(vid: verificationId,phoneNumber: phoneNoController.text,)), (route) => false);
                   
                
//                   }, 
//                   codeAutoRetrievalTimeout: (verificationId){}
//                   );}
//                            on FirebaseAuthException catch(e){
//                       // ref.read(phNoloadingprovider.notifier).state=false;
//                                 Get.snackbar("Error Occured 2", e.code);
//                            }catch (e){
//                       ref.read(phNoloadingprovider.notifier).state=false;
                
//                 Get.snackbar("Error Occured 3" , e.toString());
//                            }
                
                                 
//                 },
//                 style: const ButtonStyle(
//                   backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 33, 92, 242),
// ),
//                   foregroundColor: MaterialStatePropertyAll(Colors.white),
                  
                
//                 )
//                 , child:const Text("Send OTP"))
//               ],
//             ),
//           ),
//         ),),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//   Future<void> savePhoneNumber(String phoneNumber) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setString('phoneNumber', phoneNumber);
// }
// }
