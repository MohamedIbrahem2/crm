import '../../domain/entities/response_login_entity.dart';

class ResponseLoginModel extends ResponseLoginEntity {
  const ResponseLoginModel({required super.token, required super.moduleId, required super.message});

  factory ResponseLoginModel.fromJson(Map<String, dynamic> json) {
    return ResponseLoginModel(
      token: json['data']['access_token'],
      moduleId: json['data']['user']['module_id'],
      message: json['message'],
    );
  }



}