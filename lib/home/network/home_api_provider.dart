



import 'package:plateron_assignment/utils/common/network/endpoints.dart';
import 'package:plateron_assignment/utils/common/network/model/response_api.dart';
import 'package:plateron_assignment/utils/common/network/service/api_service.dart';
import 'package:plateron_assignment/utils/common/network/service/http_service.dart';
import 'package:plateron_assignment/utils/common/network/service/status.dart';

class HomeApiProvider {
  Future<ResponseApi> jokesApi() async {
    return await apiService.getRequest(
      headers: httpService.getHeader(),
      url: Endpoints.jokesApiUrl,
      apiType: ApiStatus.JOKES_API,
    );
  }


  Future<ResponseApi> memesApi() async {
    return await apiService.getRequest(
      headers: httpService.getHeader(),
      url: Endpoints.memesApiUrl,
      apiType: ApiStatus.MEMES_API,
    );
  }
}
