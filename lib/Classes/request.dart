enum status { Accepted, Rejected, waiting }

class request {
  String rid = '';
  String Stuid = '';
  String stu_name = '';
  String proj_id = '';
  DateTime created_on = DateTime.now();
  String position_name = '';
  status req_status = status.waiting;

  request(
      {required this.Stuid,
      required this.stu_name,
      required this.proj_id,
      required this.position_name});

  Map<String, dynamic> SaveReqDB(request r) {
    final save_out = {
      'rid': r.rid,
      'stuid': r.Stuid,
      'stu_name': r.stu_name,
      'created_on': r.created_on,
      'proj_id': r.proj_id,
      'position_name': r.position_name,
      'status': r.req_status.toString()
    };

    return save_out;
  }
}


/*

Map request = {
  'requestId': id,
  'Stuid' : stu_id,
  'stu_name':stu_name
  'Proj_id': proj_id,
  "position_name": positionId,

};
*/

