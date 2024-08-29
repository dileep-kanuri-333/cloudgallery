// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:galleryproject999666333/animations/fadeinup.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:galleryproject999666333/screens/otpverify_screen.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';

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
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               height: 400,
//               child: Stack(
//                 children: <Widget>[
//                   Positioned(
//                     top: -40,
//                     height: 400,
//                     width: width,
//                     child: FadeInUpAnimation(duration: Duration(seconds: 1), child: Container(
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage('assets/images/background.png'),
//                           fit: BoxFit.fill
//                         )
//                       ),
//                     )),
//                   ),
//                   Positioned(
//                     height: 400,
//                     width: width+20,
//                     child: FadeInUpAnimation(duration: Duration(milliseconds: 1000), child: Container(
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage('assets/images/background-2.png'),
//                           fit: BoxFit.fill
//                         )
//                       ),
//                     )),
//                   )
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 40),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   FadeInUpAnimation(duration: Duration(milliseconds: 1500), child: Text("Login", style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),)),
//                   SizedBox(height: 30,),
//                   FadeInUpAnimation(duration: Duration(milliseconds: 1700), child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.white,
//                       border: Border.all(color: Color.fromRGBO(196, 135, 198, .3)),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color.fromRGBO(196, 135, 198, .3),
//                           blurRadius: 20,
//                           offset: Offset(0, 10),
//                         )
//                       ]
//                     ),
//                     child: Container(
//                       padding: EdgeInsets.all(10),
//                       child:  TextFormField(
//                                           controller: phoneNoController,
//                                           inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9 +]'))],
//                                           keyboardType: TextInputType.number,
//                                           decoration:const InputDecoration(
//                     hintText: "your 10 digits phone number",
//                     border: InputBorder.none,
//                     suffixIcon: Icon(Icons.phone),
                    
//                                           ),
//                                           validator: (value) => value!.isEmpty? "phone number should not be empty":null,
                                        
//                                         ),
//                     ),
//                   )),
//                   SizedBox(height: 20,),
//                   FadeInUpAnimation(duration: Duration(milliseconds: 1700), child: Center(child: TextButton(onPressed: () {}, child: Text("Forgot Password?", style: TextStyle(color: Color.fromRGBO(196, 135, 198, 1)),)))),
//                   SizedBox(height: 30,),
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
//                 , child:const Text("Send OTP")),
//                   SizedBox(height: 30,),
//                   FadeInUpAnimation(duration: Duration(milliseconds: 2000), child: Center(child: TextButton(onPressed: () {}, child: Text("Create Account", style: TextStyle(color: Color.fromRGBO(49, 39, 79, .6)),)))),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//    Future<void> savePhoneNumber(String phoneNumber) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setString('phoneNumber', phoneNumber);
// }
// }