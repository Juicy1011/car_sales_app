import 'package:get/get.dart';

class Homescreencontroller extends GetxController {
  var selectectedScreenIndex = 0.obs;
  updatedSelectedIndex(pos) => selectectedScreenIndex.value = pos;
}
