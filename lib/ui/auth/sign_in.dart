import 'package:flutter/material.dart';

import '/widgets/appbar.dart';
import '/appdata/consts.dart';
import '/appdata/funcs.dart';
import '/services/router.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _passwordField = FocusNode();

  String _login = '', _password = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: getPadding(context),
          child: Container(
            height: getScaffoldSize(context),
            padding: paddingWithAppbar,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomAppBar(leading: true),
                    Container(
                      margin: const EdgeInsets.only(bottom: 15, top: 35),
                      child: Text(
                        'Добро пожаловать',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    Text(
                      'Войдите, чтобы продолжить',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                const Spacer(),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Логин',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Номер телефона',
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: textColor,
                          ),
                          cursorColor: primaryColor,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _login = value,
                          validator: (value) => isValidPhone(value)
                              ? null
                              : 'Некорректно введен номер',
                          onFieldSubmitted: (value) => FocusScope.of(context)
                              .requestFocus(_passwordField),
                        ),
                      ),
                      Text(
                        'Пароль',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Введите пароль',
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: textColor,
                          ),
                          cursorColor: primaryColor,
                          focusNode: _passwordField,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          onChanged: (value) => _password = value,
                          validator: (value) => isValidPass(value)
                              ? null
                              : 'Некорректно введен пароль',
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).unfocus();
                            _submit();
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 30,
                            child: RawMaterialButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, restoreRoute),
                              elevation: 0,
                              child: const Text(
                                'Забыли пароль?',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  height: buttonHeight,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(buttonBorderRadius),
                  ),
                  child: RawMaterialButton(
                    onPressed: () => _submit(),
                    elevation: 0,
                    child: Text(
                      'Войти',
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                ),
                const Spacer(
                  flex: 4,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _submit() async {
    _formKey.currentState?.validate();
  }
}
