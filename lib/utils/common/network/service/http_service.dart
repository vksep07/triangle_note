import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:plateron_assignment/utils/common/logger/app_logger.dart';

class HttpService {
  final tag = 'HTTP_SERVICE';

  getHeader() {
    return {
      'X-CMC_PRO_API_KEY': '',
      'content-type': 'application/json;charset=utf-8'
    };
  }


  Future<Response> getResult({
    RequestType? type,
    Uri? address,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    List<int>? listBody,
    String? plainBody,
    bool? requireInterceptor,
  }) async {
    AppLogger.printLog('ADDRESS: $address', tag: tag);
    if (listBody != null) {
      AppLogger.printLog('listBody: ${jsonEncode(listBody)}', tag: tag);
    }
    if (plainBody != null) {
      AppLogger.printLog('plainBody: $plainBody', tag: tag);
    }
    if (body != null) {
      AppLogger.printLog('body: ${jsonEncode(body)}', tag: tag);
    }
    Response? response;
 //   try {
      Uri? uri = address; //Uri.parse(address);
      switch (type) {
        case RequestType.post:
          response = await Client().post(
            uri!,
            headers: headers,
            body: jsonEncode(body),
          );
          break;

        case RequestType.get:
          response = await Client().get(uri!, headers: headers);
          break;


        default:
          //DEFAULT CASE IF GET REQUEST
          response = await Client().get(uri!, headers: headers);
          break;
      }
      return response;
   // } catch (exception) {
      //TODO: RETURN EXCEPTION ONLY IF IT IS NOT HANDLED BY CUSTOM EXCEPTION
      //CHECK IF UNAUTHORISED REQUEST ARE CAUGHT OR NOT HERE
      // throw exception;
      //AppLogger.printLog('$exception', tag: tag);
      throw Exception("Something went wrong!!");
   // }
  }
}

enum RequestType {
  get,
  post
}

final HttpService httpService = HttpService();
