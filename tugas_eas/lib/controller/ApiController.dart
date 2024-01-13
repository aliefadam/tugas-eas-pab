class ApiController {
  static const String IP = "192.168.54.21";
  String api = "http://$IP/uniwear-php/crud.php";
  String uploadPath = "http://$IP/uniwear-php/uploads/";

  static getApi() {
    return ApiController().api;
  }

  static getUploadPath() {
    return ApiController().uploadPath;
  }
}
