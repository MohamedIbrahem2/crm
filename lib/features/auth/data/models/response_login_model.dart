import '../../domain/entities/response_login_entity.dart';

class ResponseLoginModel extends ResponseLoginEntity {
  const ResponseLoginModel({required super.token, required super.moduleId, required super.message,required super.userId});

  factory ResponseLoginModel.fromJson(Map<String, dynamic> json) {

    return ResponseLoginModel(
      userId: json['data']['user']['id'].toString(),
      token: json['data']['access_token'],
      moduleId: json['data']['user']['module_id'].toString(),  // Convert int to String
      message: json['message'],
    );
  }



}