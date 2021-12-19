import 'package:flutter_template_mini/http/request.dart';

class Api {
  // 登录
  static login(data) {
    return Request.post(
      "/users/login",
      data: data,
    );
  }
}
