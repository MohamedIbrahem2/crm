class ApiConstants {

  const ApiConstants._();

  //-----------------Base-Url----------------//
  static const String apiBaseUrl = 'http://back.growcrm.tech/api/';

  //-----------------Endpoints----------------//

  //auth
  static const String loginEndpoint = 'login';



}



class ApiError {
  //-----------------Error-----------------//
  static const String apiConnectionTimeout = "Connection timeout with the server";
  static const String apiSendTimeout = "connection to server failed";
  static const String apiReceiveTimeout = "Receive timeout in connection with the server";
  static const String apiBadCertificate = "c";
  static const String apiBadResponse = "apiBadResponse";
  static const String apiCancel = "Request to the server was cancelled";
  static const String apiConnectionError = "Connection to server failed";
  static const String apiUnknown = "apiUnknown";
  static const String apiRequestNotFound = "apiRequestNotFound";
  static const String apiServerError = "api Server Error";
  static const String apiErrorTryAgain = "Something went wrong";
}

