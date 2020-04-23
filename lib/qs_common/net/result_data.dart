/// @author Qson
/// @create 2019/12/12
/// @Describe
class ResultData {
  var data;
  bool result;
  int code;
  var headers;
  var error;

  ResultData(this.data, this.result, this.code, {this.headers, this.error});

  toJson() {
    return {"code": code, "result": result, "data": data, "headers": headers};
  }

  @override
  String toString() {
    return {"code": code, "result": result, "data": data, "headers": headers}
        .toString();
  }
}
