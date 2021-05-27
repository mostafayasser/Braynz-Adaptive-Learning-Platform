import 'package:graduation_project/models/user.dart';

class RequestType {
  static const String Get = 'get';
  static const String Post = 'post';
  static const String Put = 'put';
  static const String Delete = 'delete';
}

/* class Header {
  static Map<String, dynamic> clientAuth({@required String clientID}) {
    final hashedClient = const Base64Encoder().convert("$clientID:".codeUnits);
    return {'Authorization': 'Basic $hashedClient'};
  }

  static Map<String, dynamic> userAuth(String accessToken) =>
      {'Authorization': 'Bearer $accessToken'};
} */

class EndPoint {
  static const String REGISTER = 'register';
  static const String TOKEN = 'auth/token';
  static const String USER = 'user';
  static const String POST = 'post';
  static const String COMMENT = 'comment';
  static const String REPLY = 'reply';
}

abstract class Api {
  Future<User> login({String email, String password});

  Future<User> getUser(int userId);

  Future<User> signUp({Map<String, dynamic> param});
}

/* Future<Response> request(String serverPAth, String endPoint,
    {body,
    Function onSendProgress,
    Map<String, dynamic> headers,
    String type = RequestType.Get,
    Map<String, dynamic> queryParameters,
    String contentType = Headers.jsonContentType,
    ResponseType responseType = ResponseType.json}) async {
  Response response;

  final dio = Dio(BaseOptions(
      baseUrl: serverPAth, connectTimeout: 5000, receiveTimeout: 5000));
  final options = Options(
      headers: headers, contentType: contentType, responseType: responseType);

  if (onSendProgress == null) {
    onSendProgress = (int sent, int total) {
      print('$endPoint\n sent: $sent total: $total\n');
    };
  }

  try {
    switch (type) {
      case RequestType.Get:
        {
          response = await dio.get(endPoint,
              queryParameters: queryParameters, options: options);
        }
        break;
      case RequestType.Post:
        {
          response = await dio.post(endPoint,
              queryParameters: queryParameters,
              onSendProgress: onSendProgress,
              data: body,
              options: options);
        }
        break;
      case RequestType.Put:
        {
          response = await dio.put(endPoint,
              queryParameters: queryParameters, data: body, options: options);
        }
        break;
      case RequestType.Delete:
        {
          response = await dio.delete(endPoint,
              queryParameters: queryParameters, data: body, options: options);
        }
        break;
      default:
        break;
    }

    print('$type $endPoint\n$headers\nstatusCode:${response.statusCode}\n');
    return response; //map of string dynamic...

  } catch (e) {
    print('🌐🌐ERROR in http $type for $endPoint:🌐🌐\n' + e.toString());
    return null;
  }
}
 */
