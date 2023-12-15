
 import 'package:get/get.dart';

import '../../data/models/task-model.dart';
import '../../data/network-utils.dart';

class NewTaskController extends GetxController{

  bool _inProgress=false;
  TaskModel _newTaskModel = TaskModel();
  bool get getNewTaskInProgress=>_inProgress;
  TaskModel get taskListModel=>_newTaskModel;

  Future<bool> getNewTasks() async {
    bool isSuccess=false;
    _inProgress = true;
    update();
    final response = await NetworkUtils()
        .getMethod('https://task.teamrabbil.com/api/v1/listTaskByStatus/New');
    _inProgress = false;
    if (response != null) {
      _newTaskModel = TaskModel.fromJson(response);
      isSuccess==true;
    }

    update();
    return isSuccess;
  }

}