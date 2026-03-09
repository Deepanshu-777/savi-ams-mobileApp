import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:rail_weld/routes/urls.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../storage/storage.dart';
import '../widgets/custom_loader.dart';
import 'exception_handler.dart';

class NetworkRequester {
  late Dio _dio;
  int retryCount = 1;

  NetworkRequester() {
    prepareRequest();
  }

  Future<void> prepareRequest({
    bool useRefreshToken = false,
    bool basicAuthorizationToken = true,
  }) async {
    BaseOptions dioOptions = BaseOptions(
      connectTimeout: const Duration(milliseconds: 60000),
      receiveTimeout: const Duration(milliseconds: 60000),
      baseUrl: Urls.BASEURL,
      responseType: ResponseType.json,
      headers: await getHeaders(
        basicAuthorizationToken: basicAuthorizationToken,
      ),
    );

    _dio = Dio(dioOptions);

    _dio.interceptors.clear();

    _dio.interceptors.add(LogInterceptor(
      error: true,
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      logPrint: _printLog,
    ));

    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          if (retryCount > 1) {
            await Future.delayed(const Duration(seconds: 5));
          }

          // if (error.response?.statusCode == 401) {
          //   if (retryCount == 1) {
          //     retryCount++;
          //     String refreshToken = await getRefreshToken();
          //     if (refreshToken.isNotEmpty) {
          //       error.requestOptions.headers['Authorization'] =
          //       'Bearer $refreshToken';
          //       return handler.resolve(await _dio.fetch(error.requestOptions));
          //     }
          //   }
          //   else {
          //     clearUserData();
          //   }
          // }
          return handler.next(error);
        },
      ),
    );

    // if (Env.releaseEv != ReleaseEnv.prod.name) {
    //   _dio.interceptors.add(Constants.alice.getDioInterceptor());
    // }
  }

  _printLog(Object object) => log(object.toString());

  // Future<String> getRefreshToken() async {
  //   String refreshToken = "";
  //   final response = await _dio.post(
  //       URLs.refreshToken(refreshToken: "${Storage.getUser()?.refreshToken}"));
  //   if (response.statusCode == 200) {
  //     final apiResponse = json.decode(json.encode(response));
  //     final user = Storage.getUser();
  //     Storage.setUser(User(
  //         accessToken: apiResponse["payload"]["access_token"] ?? "",
  //         refreshToken: apiResponse["payload"]["refresh_token"] ?? "",
  //         userId: user?.userId ?? "",
  //         name: "",
  //         phoneNumber: ""));
  //     refreshToken =
  //     json.decode(json.encode(response))["payload"]["access_token"];
  //   }
  //   return refreshToken;
  // }

  // void clearUserData() {
  //   Storage.clearUser();
  //   if (getx.Get.currentRoute != Routes.ENTERPHONENUMBER) {
  //     getx.Get.offAllNamed(Routes.ENTERPHONENUMBER);
  //   }
  // }

  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? query,
    bool basicAuthorizationToken = true,
    Options? options,
    bool showException = true,
    bool isLoader = true,
    required dynamic Function() api,
  }) async {
    try {
      isLoader ? loader() : () {};
      await prepareRequest(
        basicAuthorizationToken: basicAuthorizationToken,
      );
      final response = await _dio.get(
        path,
        queryParameters: query,
        options: options,
      );
      return response.data;
    } on DioException catch (e) {
      return ExceptionHandler.handleError(
        callApiAgain: () async => await api(),
        error: e,
        showException: showException,
      );
    } finally {
      isLoader ? getx.Get.back() : () {};
    }
  }

  Future<dynamic> post({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    bool checkException = false,
    bool basicAuthorizationToken = true,
    bool isLoader = true,
    required dynamic Function() api,
  }) async {
    try {
      isLoader ? loader() : () {};
      await prepareRequest(basicAuthorizationToken: basicAuthorizationToken);
      final response = await _dio.post(
        path,
        queryParameters: query,
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      log("Errrrrr: $e ");
      //customToast(msg: "   Invalid credential!   ");

      return ExceptionHandler.handleError(
        callApiAgain: () async => await api(),
        error: e,
        showException:
            (checkException && e.response?.statusCode == 426) ? false : true,
      );
    } finally {
      isLoader ? getx.Get.back() : () {};
    }
  }

  Future<dynamic> put({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      await prepareRequest();
      final response = await _dio.put(path, queryParameters: query, data: data);
      return response.data;
    } on DioException catch (e) {
      return ExceptionHandler.handleError(error: e);
    }
  }

  Future<dynamic> patch({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      await prepareRequest();
      final response =
          await _dio.patch(path, queryParameters: query, data: data);
      return response.data;
    } on DioException catch (e) {
      return ExceptionHandler.handleError(error: e);
    }
  }

  Future<dynamic> delete({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      await prepareRequest();
      final response =
          await _dio.delete(path, queryParameters: query, data: data);
      return response.data;
    } on DioException catch (e) {
      return ExceptionHandler.handleError(error: e);
    }
  }

  Future<dynamic> postFormData({
    required String path,
    required FormData formData,
  }) async {
    try {
      await prepareRequest();
      final response = await _dio.post(
        path,
        data: formData,
      );
      return response.data;
    } on DioException catch (e) {
      return ExceptionHandler.handleError(error: e);
    }
  }

  Future<Map<String, dynamic>> getHeaders({
    bool useRefreshToken = false,
    bool basicAuthorizationToken = true,
  }) async {
    PackageInfo? packageInfo = await PackageInfo.fromPlatform();
    Map<String, dynamic> headers = {
      "Content-Type": "application/json",
      "device-type": "MOBILE",
      "operating-system": Platform.isAndroid ? "ANDROID" : "IOS",
      "build-number": "${packageInfo.version}+${packageInfo.buildNumber}",
    };
    if (basicAuthorizationToken) {
      log('Token: $basicAuthorizationToken');
      headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.getToken().toString()}",
        "device-type": "MOBILE",
        "operating-system": Platform.isAndroid ? "ANDROID" : "IOS",
        "build-number": "${packageInfo.version}+${packageInfo.buildNumber}",
      };
    } else {
      return headers;
    }
    return headers;
  }
}
