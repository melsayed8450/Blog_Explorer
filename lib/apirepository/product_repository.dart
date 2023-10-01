import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '../common/routes/remote_routes.dart';

import 'api_http_response.dart';
import 'package:http/http.dart' as http;

String domain = AppRemoteRoutes.baseUrl;
Future<ApiHttpResponse> callPostMethod(Map authData, String apiUrl) async {
  try {
    String url = domain + apiUrl;

    Map<String, String> header = {'Content-Type': 'application/json'};

    http.Response response = await http.post(Uri.parse(url),
        body: json.encode(authData), headers: header);
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = response.statusCode;
    apiResponse.responseString = response.body;

    return apiResponse;
  } on SocketException catch (_) {
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responseString = json.encode(
        {"success": false, "message": AppRemoteRoutes.internetConnectionMsg});
    return apiResponse;
  } catch (e) {
    debugPrint("catch error $e");
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responseString = json.encode(
        {"success": false, "message": AppRemoteRoutes.someThingWentWrong});
    return apiResponse;
  }
}

Future<ApiHttpResponse> callGetMethod(String apiUrl) async {
  try {
    String url = domain + apiUrl;

    Map<String, String> header = {
      'x-hasura-admin-secret': AppRemoteRoutes.adminSecret,
    };

    http.Response response = await http.get(Uri.parse(url), headers: header);
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = response.statusCode;
    apiResponse.responseString = response.body;
    return apiResponse;
  } on SocketException catch (_) {
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responseString = json.encode(
        {"success": false, "message": AppRemoteRoutes.internetConnectionMsg});
    return apiResponse;
  } catch (e) {
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responseString = json.encode(
        {"success": false, "message": AppRemoteRoutes.someThingWentWrong});
    return apiResponse;
  }
}

Future<ApiHttpResponse> callPutMethod(Map authData, String apiUrl) async {
  try {
    String url = domain + apiUrl;

    Map<String, String> header = {'Content-Type': 'application/json'};

    http.Response response = await http.put(Uri.parse(url),
        body: json.encode(authData), headers: header);
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = response.statusCode;
    apiResponse.responseString = response.body;

    return apiResponse;
  } on SocketException catch (_) {
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responseString = json.encode(
        {"success": false, "message": AppRemoteRoutes.internetConnectionMsg});
    return apiResponse;
  } catch (e) {
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responseString = json.encode(
        {"success": false, "message": AppRemoteRoutes.someThingWentWrong});
    return apiResponse;
  }
}

Future<ApiHttpResponse> callDeleteMethod(Map authData, String apiUrl) async {
  try {
    String url = domain + apiUrl;

    Map<String, String> header = {'Content-Type': 'application/json'};

    http.Response response = await http.delete(Uri.parse(url),
        body: json.encode(authData), headers: header);
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = response.statusCode;
    apiResponse.responseString = response.body;

    return apiResponse;
  } on SocketException catch (_) {
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responseString = json.encode(
        {"success": false, "message": AppRemoteRoutes.internetConnectionMsg});
    return apiResponse;
  } catch (e) {
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responseString = json.encode(
        {"success": false, "message": AppRemoteRoutes.someThingWentWrong});
    return apiResponse;
  }
}
