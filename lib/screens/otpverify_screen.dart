// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:galleryproject999666333/screens/home_screen.dart';
import 'package:galleryproject999666333/screens/login_screen.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';


var otploadingprovider=StateProvider<bool>((ref) => false);
class OtpVerification extends ConsumerStatefulWidget {
  final String vid;
  final String phoneNumber; 

  const OtpVerification({super.key, required this.vid, required this.phoneNumber});

  @override
  ConsumerState<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends ConsumerState<OtpVerification> {
  var code="";
  
  // Future<bool> checkUserInFirestore(String phoneNumber) async {
  //   try {
  //     // Query Firestore collection for the given phone number
  //     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //         .collection("Users")
  //         .where("employeephoneNo", isEqualTo: phoneNumber)
  //         .get();

  //     // If there's a document matching the phone number, return true
  //     return querySnapshot.docs.isNotEmpty;
  //   } catch (e) {
  //     print("Error checking user in Firestore: $e");
  //     return false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
   bool isLoadings=ref.watch(otploadingprovider);

    return Scaffold(
      body:isLoadings?const Center(child: CircularProgressIndicator()):   Padding(
        padding: const EdgeInsets.all(23),
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/otpimage.png'),
             const SizedBox(height: 30,),
              Text("OTP verification",style: GoogleFonts.lato().copyWith(fontSize: 33,color: Colors.black),),
              Text(("Enter OTP sent to ")+phoneNoController.text),
            const  SizedBox(height: 20,),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Pinput(
                    length: 6,
                    onChanged: (val){
                      setState(() {
                        code=val;
                      });
          
                    },
                  ),
                ),
              ),
            const  SizedBox(height: 23,),
              ElevatedButton(onPressed: () async{
                        ref.read(otploadingprovider.notifier).state = true;
                        // ref.read(phNoloadingprovider.notifier).state = false;
          
                        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.vid, smsCode:code);
                        try {
                          final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
                          
                          final user = userCredential.user;
                          if (user != null) {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                      bool isUser = widget.phoneNumber ==widget.phoneNumber;
                      await prefs.setBool('isUser', isUser);
                          // final userCredentials = await FirebaseAuth.instance.signInWithCredential(credential);
          
                            if (isUser){
                            // ref.read(otploadingprovider.notifier).state=false;
                            ref.read(phNoloadingprovider.notifier).state=false;
          
          
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>const HomeScreen()), (route) => false);
                              
                            } 
                            
                          }
                        } on FirebaseAuthException catch (e) {
                          ref.read(otploadingprovider.notifier).state = false;
                          Get.snackbar("", e.code);
                        } catch (e) {
                          ref.read(otploadingprovider.notifier).state = false;
                          Get.snackbar("Erroroccured", e.toString());
                        }
                      },
          
              
              
              
              style:const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black,),
                foregroundColor: MaterialStatePropertyAll(Colors.white)),
               child: const Text("Verify & Proceed"))
            ],
          ),
        ),
      ),
    );
  }
}