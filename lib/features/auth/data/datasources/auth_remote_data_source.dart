import 'package:dio/dio.dart';
import 'package:vill_finder/core/env/env.dart';
import 'package:vill_finder/core/error/exceptions.dart';
import 'package:vill_finder/core/firebase/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:vill_finder/core/interceptor/api_interceptor.dart';
import 'package:vill_finder/features/auth/data/models/google_signin_response_model.dart';
import 'package:vill_finder/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signinWithGoogle();
  Future<GoogleSigninResponseModel> verifySigninToken(String idToken);
  Future<String> logout();
  Future<UserModel> currentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final firebase_auth.FirebaseAuth firebaseAuth;
  final AuthService authService;
  final Dio dio = Dio();
  final apiInstance = ApiInterceptor.apiInstance();

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.authService,
  });

  @override
  Future<String> signinWithGoogle() async {
    try {
      final response = await authService.signInWithGoogle();
      final String? idToken = await response!.getIdToken();
      return idToken ?? '';
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthenticationException(
          e.message ?? 'Unknown authentication error');
    } catch (e) {
      throw FirebaseException('An error occurred during sign-in');
    }
  }

  @override
  Future<String> logout() async {
    try {
      await authService.signOut();
      return "Succcessfully logout.";
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthenticationException(e.message ?? 'Something went wrong');
    } catch (e) {
      throw FirebaseException('An error occurred during sign-in');
    }
  }

  @override
  Future<GoogleSigninResponseModel> verifySigninToken(String idToken) async {
    try {
      String url = '${Env.apiURL}/verify/token';
      Map<String, dynamic> data = {
        'id_token': idToken,
        'client_id': Env.clientId,
      };

      final response = await dio.post(url, data: data);
      return GoogleSigninResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> currentUser() async {
    try {
      String url = '${Env.apiURL}/api/profile';

      final response = await apiInstance.get(url);
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
