import 'package:dio/dio.dart';
import 'package:show_loader_dialog/show_loader_dialog.dart';

class HTTPManager {
  late final Dio _dio;

  HTTPManager() {
    ///Dio
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://newsapi.org/v2/",
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.json,
      ),
    );
  }

  ///Post method
  Future<dynamic> post({
    required String url,
    dynamic data,
    FormData? formData,
    Options? options,
    Function(num)? progress,
    bool? loading,
  }) async {
    if (loading == true) {
      CommonDialog.showLoader(true);
    }
    try {
      // Map<String, dynamic> headers = {
      //   "Authorization": "Bearer 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",
      //   "Content-Type": "application/json",
      // };
      final response = await _dio.post(
        url,
        data: data ?? formData,
        options: options,
        onSendProgress: (sent, total) {
          if (progress != null) {
            progress((sent / total) / 0.01);
          }
        },
      );
      return response.data;
    } on DioError catch (error) {
      return _errorHandle(error);
    } finally {
      if (loading == true) {
        CommonDialog.showLoader(false);
      }
    }
  }

  Future<dynamic> get({
    required String url,
    dynamic queryParams,
    dynamic data,
    FormData? formData,
    Options? options,
    Function(num)? progress,
    bool? loading,
  }) async {
    if (loading == true) {
      CommonDialog.showLoader(true);
    }
    try {
      // Map<String, dynamic> headers = {
      //   "Authorization": "Bearer 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",
      //   "Content-Type": "application/json",
      // };
      final response = await _dio.get(
        url,
        data: data ?? formData,
        queryParameters: queryParams,
        options: options,
        onReceiveProgress: (received, total) {
          if (progress != null) {
            progress((received / total) / 0.01);
          }
        },
      );
      return response.data;
    } on DioError catch (error) {
      return _errorHandle(error);
    } finally {
      if (loading == true) {
        CommonDialog.showLoader(false);
      }
    }
  }

  ///Error common handle
  Map<String, dynamic> _errorHandle(DioError error) {
    String message = "unknown_error";
    Map<String, dynamic> data = {};
    switch (error.type) {
      case DioErrorType.sendTimeout:
        message = "send_time_out";
        break;
      case DioErrorType.receiveTimeout:
        message = "request_time_out";
        break;
      case DioErrorType.connectionTimeout:
        message = "connection_time_out";
        break;
      case DioErrorType.badCertificate:
        message = " incorrect_certificate_error";
        break;
      case DioErrorType.badResponse:
        message = "incorrect_statuscode_badresponse";
        break;
      case DioErrorType.cancel:
        message = " request_is_cancelled";
        break;
      case DioErrorType.connectionError:
        message = "connection_error_or_socketexceptions";
        break;
      case DioErrorType.unknown:
        message = "unknown_error";
        break;
      default:
        message = "unknown_error";
        break;
    }

    return {
      "success": false,
      "message": message,
      "data": data,
    };
  }
}
