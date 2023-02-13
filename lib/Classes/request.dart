enum status { Accepted, Rejected, wait_to_join }

class request {
  String rid = '';
  String Stuid = '';
  String stu_name = '';
  String proj_id = '';
  String proj_name = '';
  DateTime created_on = DateTime.now();
  String position_name = '';
  status req_status = status.wait_to_join;

  request(
      {required this.Stuid,
      required this.stu_name,
      required this.proj_id,
      required this.proj_name,
      required this.position_name});

  Map<String, dynamic> SaveReqDB(request r) {
    final save_out = {
      'rid': r.rid,
      'stuid': r.Stuid,
      'stu_name': r.stu_name,
      'created_on': r.created_on,
      'proj_id': r.proj_id,
      'proj_name': r.proj_name,
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

