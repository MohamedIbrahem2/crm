import 'package:equatable/equatable.dart';

class ResponseLoginEntity extends Equatable {
  final String token;
  final String moduleId;
  final String message;
  final String userId;

  const ResponseLoginEntity({required this.token,required this.moduleId,required this.message,required this.userId});

  @override
  List<Object> get props => [token,moduleId,message,userId];

}
