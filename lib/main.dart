import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template_mini/common/my_init.dart';
import 'package:flutter_template_mini/navigator/my_navigator.dart';
import 'package:flutter_template_mini/provider/my_provider.dart';
import 'package:flutter_template_mini/provider/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  // 网格线
  // debugPaintSizeEnabled = true;
  // Flutter 版本 (1.12.13+hotfix.5) 后，初始化插件必须加 ensureInitialized
  WidgetsFlutterBinding.ensureInitialized();
  // 应用入口
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // 进行项目的预初始化
      future: MyInit.init(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        String initialRoute = snapshot.connectionState == ConnectionState.done
            // 加载首页
            ? 'navigator'
            // 初始化未完成时，显示 loading 页面
            : 'loading';

        return MultiProvider(
          providers: topProviders,
          // 这里通过 Consumer 读取数据，灵活度高
          // 还有其他的读取方式，比如 context.read<ThemeProvider>()
          child: Consumer<ThemeProvider>(
            builder: (
              BuildContext context,
              ThemeProvider themeProvider,
              Widget? child,
            ) {
              return MaterialApp(
                title: 'flutter_template_mini',
                theme: themeProvider.getTheme(),
                darkTheme: themeProvider.getTheme(isDarkMode: true),
                themeMode: themeProvider.getThemeMode(),
                localizationsDelegates: [
                  // 本地化的代理类
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: [
                  const Locale('en', 'US'), // 美国英语
                  const Locale('zh', 'CH'), // 中文简体
                ],
                builder: EasyLoading.init(),
                initialRoute: initialRoute,
                onGenerateRoute: MyNavigator.getInstance().onGenerateRoute,
              );
            },
          ),
        );
      },
    );
  }
}
