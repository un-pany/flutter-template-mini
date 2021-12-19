import 'package:flutter/material.dart';
import 'package:flutter_template_mini/db/my_sp.dart';
import 'package:flutter_template_mini/pages/login_page.dart';
import 'package:flutter_template_mini/pages/navigator_page.dart';

class MyNavigator {
  static MyNavigator? _instance;

  MyNavigator._();

  // 单例模式
  static MyNavigator getInstance() {
    if (_instance == null) {
      _instance = MyNavigator._();
    }
    return _instance!;
  }

  // 路由钩子（能监听到命名路由跳转，但是手机自带的物理返回按钮不行）
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    String? routeName;
    routeName = routeBeforeHook(settings);
    return MaterialPageRoute(builder: (context) {
      /// 注意：如果路由的形式为: '/a/b/c'
      /// 那么将依次检索 '/' -> '/a' -> '/a/b' -> '/a/b/c'
      /// 所以，这里的路由命名最好避免使用 '/xxx' 形式
      switch (routeName) {
        case "login":
          return LoginPage();
        case "navigator":
          return NavigatorPage();
        default:
          return Scaffold(
            body: Center(
              child: Text("页面不存在"),
            ),
          );
      }
    });
  }

  // 路由拦截器
  String? routeBeforeHook(RouteSettings settings) {
    final token = MySP.getToken() ?? '';
    if (token != '') {
      if (settings.name == 'login') {
        return 'navigator';
      }
      return settings.name;
    }
    return 'login';
  }
}
