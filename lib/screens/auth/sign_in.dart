import 'package:flutter/material.dart';

import '/appdata/appdata.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _otpSend = false, _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: getScaffoldHeight(context),
          padding: getSafeAreaPadding(context),
          child: Padding(
            padding: paddingWithAppbar,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: Text(
                        'С возвращением',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 40),
                      child: Text(
                        'Войдите по номеру, чтобы продолжить',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
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
                        'Номер телефона',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: _otpSend ? 30 : 40),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            counterText: '',
                            hintText: '+7(900)-000-00-00',
                          ),
                          keyboardType: TextInputType.phone,
                          maxLength: 18,
                          enabled: !_otpSend,
                          validator: (value) => isValidPhoneNumber(value),
                          onFieldSubmitted: (_) => null,
                        ),
                      ),
                      _otpSend
                          ? Text(
                              'Код потверждения',
                              style: Theme.of(context).textTheme.headline2,
                            )
                          : Container(),
                      _otpSend
                          ? Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Введите код из SMS',
                                  counterText: '',
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: CustomTheme.textColor,
                                ),
                                keyboardType: TextInputType.number,
                                maxLength: 6,
                                onFieldSubmitted: (_) => null,
                              ),
                            )
                          : Container(),
                      _otpSend
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 40),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _otpSend = false;
                                      });
                                    },
                                    behavior: HitTestBehavior.translucent,
                                    child: const SizedBox(
                                      height: 30,
                                      child: Text(
                                        'Изменить номер',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          color: CustomTheme.textColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () => null,
                  elevation: 0,
                  hoverElevation: 0,
                  child: !_isLoading
                      ? Text(
                          _otpSend ? 'Подтвердить' : 'Продолжить',
                          style: Theme.of(context).textTheme.button,
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: CustomTheme.primaryColor,
                            backgroundColor: Colors.white,
                            strokeWidth: 2,
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
}
