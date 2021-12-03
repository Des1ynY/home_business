import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/services/router.dart';
import '/services/firebase_auth.dart';
import '/appdata/consts.dart';
import '/appdata/funcs.dart';
import '/widgets/appbar.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _phone = '', _code = '', _verificationID = '';
  bool _codeSend = false, _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: getScaffoldSize(context),
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
                      margin: const EdgeInsets.only(top: 35),
                      child: Text(
                        'Зарегистрируйтесь',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    Text(
                      'Подтвердите номер, чтобы продолжить',
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
                        'Номер телефона',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: _codeSend ? 30 : 0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            counterText: '',
                            hintText: '+7(900)-000-00-00',
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: textColor,
                          ),
                          cursorColor: primaryColor,
                          keyboardType: TextInputType.number,
                          maxLength: 12,
                          enabled: !_codeSend,
                          onChanged: (value) => _phone = value,
                          validator: (value) => isValidPhone(value)
                              ? null
                              : 'Некорректно набран номер',
                          onFieldSubmitted: (value) => _sendCode(),
                        ),
                      ),
                      _codeSend
                          ? Text(
                              'Код потверждения',
                              style: Theme.of(context).textTheme.headline2,
                            )
                          : const SizedBox(),
                      _codeSend
                          ? Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Введите код из SMS',
                                  counterText: '',
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: textColor,
                                ),
                                cursorColor: primaryColor,
                                keyboardType: TextInputType.number,
                                maxLength: 8,
                                onChanged: (value) => _code = value,
                                onFieldSubmitted: (value) => _submit(),
                              ),
                            )
                          : const SizedBox(),
                      _codeSend
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 30,
                                  child: RawMaterialButton(
                                    onPressed: () => setState(() {
                                      _codeSend = false;
                                    }),
                                    elevation: 0,
                                    child: const Text(
                                      'Изменить номер',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: textColor,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : const SizedBox(),
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
                    onPressed: () => _codeSend ? _submit() : _sendCode(),
                    elevation: 0,
                    child: !_isLoading
                        ? Text(
                            'Зарегистрироваться',
                            style: Theme.of(context).textTheme.button,
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                              backgroundColor: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                  ),
                ),
                _codeSend
                    ? const SizedBox()
                    : Container(
                        height: 140,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _sendCode() async {
    bool formIsValid = _formKey.currentState?.validate() ?? false;

    if (formIsValid) {
      setState(() {
        _isLoading = true;
      });
      await Auth.auth.verifyPhoneNumber(
        phoneNumber: _phone,
        verificationCompleted: (phoneAuthCredential) async {
          Auth.signInWithPhoneAuthCredential(phoneAuthCredential);
          setState(() {
            _isLoading = false;
          });
          Navigator.pushNamedAndRemoveUntil(
            context,
            residentsRoute,
            (route) => false,
          );
        },
        verificationFailed: (verificationFailed) async {
          setState(() {
            _isLoading = false;
          });
          Fluttertoast.showToast(
            msg: 'Неудачная верификация',
          );
          log(verificationFailed.toString());
        },
        codeSent: (verificationID, resendingToken) async {
          setState(() {
            _isLoading = false;
            _codeSend = true;
            _verificationID = verificationID;
          });
        },
        codeAutoRetrievalTimeout: (verificationID) async {},
      );
    }
  }

  Future _submit() async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: _verificationID,
      smsCode: _code,
    );

    Auth.signInWithPhoneAuthCredential(phoneAuthCredential);
  }
}
