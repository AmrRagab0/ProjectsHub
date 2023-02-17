import 'Classes/request.dart';
import 'Classes/Project.dart';
import 'Classes/Student.dart';

List<dynamic> updated_notifications = [];

int findRequestIndex(List<dynamic> list, String id) {
  for (var i = 0; i < list.length; i++) {
    if (list[i].rid == id) {
      return i;
    }
  }
  return -1;
}


/*
int findRequestIndex(var li, String id) {
  for (var i in li) {
    if (i.rid == id) {
      return li.indexOf(i);
    }
  }
  return -1;
}
*/
