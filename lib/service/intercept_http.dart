import 'package:http_interceptor/http_interceptor.dart';

class ApiInterceptor implements InterceptorContract {
  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    data.headers["Content-Type"] = "application/json";
    return data;
  }
}
