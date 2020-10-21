import 'package:flutter/material.dart';

void main() => {runApp(MyApp())};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginStateWidget(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('状态管理'),
          ),
          body: MainPage(),
        ),
      ),
      loginState: LoginState(),
    );
  }
}

/**
 * https://blog.csdn.net/qq_19431333/article/details/100878756
 */
class LoginStateWidget extends InheritedWidget {
  final LoginState loginState;

  const LoginStateWidget({Key key, this.loginState, Widget child})
      : super(key: key, child: child);

  static LoginStateWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(LoginStateWidget);
  }

  @override
  bool updateShouldNotify(LoginStateWidget oldWidget) {
    return oldWidget.loginState == this.loginState;
  }
}

class LoginState {
  bool isLogin = false;

  @override
  bool operator ==(other) {
    return isLogin == (other as LoginState).isLogin;
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginState loginState = LoginStateWidget.of(context).loginState;
    return Container(
      child: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return LoginPage();
            }));
          },
          child: Text(loginState.isLogin ? '已登录' : '未登录'),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginState loginState = LoginStateWidget.of(context).loginState;

    return Scaffold(
      appBar: AppBar(
        title: Text('登录页面'),
      ),
      body: Container(
        child: Center(
          child: RaisedButton(
            onPressed: () {
              loginState.isLogin = !loginState.isLogin;
              Navigator.of(context).pop();
            },
            child: Text(loginState.isLogin ? '退出登录' : '登录'),
          ),
        ),
      ),
    );
  }
}
