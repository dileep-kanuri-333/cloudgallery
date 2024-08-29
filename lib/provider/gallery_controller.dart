import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final galleryProvider = AutoDisposeChangeNotifierProvider<Gallery_Controller>(
    (ref) => Gallery_Controller());
class Gallery_Controller extends ChangeNotifier{


bool isStartLoading=false;
bool isStartLoadingforDeletedImg=false;





@override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
  }










}