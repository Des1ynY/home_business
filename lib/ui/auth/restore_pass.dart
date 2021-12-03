import 'package:flutter/material.dart';

import '/appdata/consts.dart';
import '/appdata/funcs.dart';
import '/widgets/appbar.dart';

class RestorePass extends StatefulWidget {
  const RestorePass({Key? key}) : super(key: key);

  @override
  _RestorePassState createState() => _RestorePassState();
}

class _RestorePassState extends State<RestorePass> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 500,
          padding: getPadding(context),
          child: Container(
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
                      margin: const EdgeInsets.only(top: 35, bottom: 15),
                      child: Text(
                        'Восстановление пароля',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    Text(
                      'Введите почту, чтобы получить инструкции по сбросу пароля',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Почта',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'example@mail.ru',
                        ),
                        cursorColor: primaryColor,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => value = value,
                        validator: (value) => isValidEmail(value)
                            ? null
                            : 'Некорректно указана почта',
                        onFieldSubmitted: (value) => _submit(),
                      ),
                    ],
                  ),
                ),
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
                      'Сбросить пароль',
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _submit() async {}
}
