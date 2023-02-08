import '/utils/utils.dart';

class AuthService {
  final Dio _dio = Dio();
  Future<Response> postRequestHandler(
      String path, Map<String, dynamic> data) async {
    return await _dio.post(
      '${ChatConstant.baseUrl}/$path',
      data: data,
      queryParameters: data,
    );
  }

  Future<Response> getRequestHandler(String path) async {
    return await _dio.get('${ChatConstant.baseUrl}/$path');
  }

//   Future<LoginResponse> loginUser(
//       String email, String password, String deviceName) async {
//     try {
//       Response response = await postRequestHandler(
//         '$_baseUrl/auth/user/login',
//         {
//           "email": email,
//           "password": password,
//           "device_name": deviceName,
//         },
//       );
//       if (response.statusCode == 200) {
//         return LoginResponse(
//           status: true,
//           token: response.data['token'],
//         );
//       } else {
//         return LoginResponse(
//           status: false,
//           message: response.data['message'],
//         );
//       }
//     } on DioError catch (e) {
//       return LoginResponse(
//         status: false,
//         message: e.response!.data['message'],
//       );
//     }
//   }

//   Future<RegisterResponse> registerUser(String fullName, String phone,
//       String email, String password, String username) async {
//     try {
//       await postRequestHandler(
//         '$_baseUrl/auth/user/register',
//         {
//           "username": username,
//           "email": email,
//           "phone": phone,
//           "password": password,
//         },
//       );

//       return const RegisterResponse(status: true);
//     } on DioError {
//       return const RegisterResponse(status: false);
//     }
//   }
}
