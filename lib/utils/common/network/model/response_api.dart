



import 'package:plateron_assignment/utils/common/network/service/status.dart';

class ResponseApi {
  ApiStatus? status;
  ApiStatus? apiTypeStatus;
  Object? data;
  Map<String, String>? headers;

  ResponseApi(this.status, this.data, this.apiTypeStatus,{this.headers});

  static ResponseApi loading(ApiStatus apiTypeStatus) {
    return ResponseApi(ApiStatus.LOADING, '', apiTypeStatus);
  }

  static ResponseApi success(Object data, ApiStatus apiTypeStatus,{Map<String, String>? headers}) {
    return ResponseApi(ApiStatus.SUCCESS, data, apiTypeStatus,headers: headers);
  }

  static ResponseApi fail400(Object data, ApiStatus apiTypeStatus) {
    return ResponseApi(ApiStatus.FAIL_400, data, apiTypeStatus);
  }

  static ResponseApi fail401(Object data, ApiStatus apiTypeStatus) {
    return ResponseApi(ApiStatus.FAIL_401, data, apiTypeStatus);
  }

  static ResponseApi fail403(Object data, ApiStatus apiTypeStatus) {
    return ResponseApi(ApiStatus.FAIL_403, data, apiTypeStatus);
  }

  static ResponseApi authFail(Object data, ApiStatus apiTypestatus) {
    return ResponseApi(ApiStatus.AUTH_FAIL, '', apiTypestatus);
  }

  static ResponseApi fail(Object data, ApiStatus apiTypeStatus) {
    return new ResponseApi(ApiStatus.FAIL, data, apiTypeStatus);
  }

  static ResponseApi failDb(String data, ApiStatus apiTypeStatus) {
    return new ResponseApi(ApiStatus.FAIL_DB, data, apiTypeStatus);
  }

  static ResponseApi internalServerError(String data, ApiStatus apiTypeStatus) {
    return new ResponseApi(ApiStatus.INTERNAL_SERVER_ERROR, data, apiTypeStatus);
  }
}
