

import 'package:plateron_assignment/utils/common/bloc/handle_response_bloc.dart';
import 'package:plateron_assignment/utils/common/network/model/response_api.dart';
import 'package:plateron_assignment/utils/common/network/service/http_service.dart';
import 'package:plateron_assignment/utils/common/network/service/status.dart';

class APIService {
  //GET REQUEST
  Future<ResponseApi> getRequest(
      {required String url,
      required ApiStatus apiType,
      Map<String, String>? headers,}) async {
    final resp = await httpService.getResult(
        type: RequestType.get,
        address: Uri.parse(url),
        headers: headers ?? httpService.getHeader());
    return await handleResponseBloc.handleResponse(
      result: resp,
      apiType: apiType,
    );
  }
}

final APIService apiService = APIService();
