import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../../../core/networking/api_constants.dart';
import '../../domain/use_cases/login_usecase.dart';
import '../models/response_login_model.dart';

part 'login_remote_data_source.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class LoginRemoteDataSource {
  factory LoginRemoteDataSource(Dio dio) =
      _LoginRemoteDataSource;
  @POST(ApiConstants.loginEndpoint)
  Future<ResponseLoginModel> login(@Body() LoginParameters parameters);
}

