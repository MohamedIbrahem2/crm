import 'package:equatable/equatable.dart';

class ResponseLoginEntity extends Equatable {
  final String token;
  final String moduleId;
  final String message;

  const ResponseLoginEntity({required this.token,required this.moduleId,required this.message});

  @override
  List<Object> get props => [token,moduleId,message];

}
