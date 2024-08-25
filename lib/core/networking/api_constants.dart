class ApiConstants {

  const ApiConstants._();

  //-----------------Base-Url----------------//
  static const String apiBaseUrlForCurrency = 'http://apilayer.net/api/live';
  static const String apiBaseUrlForGold = 'https://www.goldapi.io/api/';

  //-----------------Access-Key----------------//
  static const String apiAccessKeyForCurrency = '7891b48f3d4505edebd050c2c2da4e71';
  static const String apiAccessKeyForGold = 'goldapi-50psm0803axf-io';


  //-----------------Home-Endpoint----------------//
  static const String currencyEndpoint = '?access_key=${ApiConstants.apiAccessKeyForCurrency}&currencies=EGP,USD,EUR,GBP,CAD,PLN,CNY,INR,BRL,JPY';
  static const String goldEndpoint = 'XAU';



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

