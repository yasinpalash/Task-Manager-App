import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/ui/Controller/Login_Controller.dart';
import 'package:taskmanager/ui/Controller/New_task_Controller.dart';
import 'package:taskmanager/ui/Screens/SplashScreen.dart';

class TaskManager extends StatefulWidget {
  const TaskManager({Key? key}) : super(key: key);

  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManager.globalKey,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      initialBinding: ControllerBinder(),
      theme: ThemeData(
        primaryColor: Colors.green,
        primarySwatch: Colors.green
      ),
    );
  }
}
class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(NewTaskController());
  }

}