import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/services/router.dart';
import '/services/firebase_auth.dart';
import '/appdata/consts.dart';
import '/appdata/funcs.dart';

class PhoneInfo extends StatefulWidget {
  const PhoneInfo({Key? key}) : super(key: key);

  @override
  _PhoneInfoState createState() => _PhoneInfoState();
}

class _PhoneInfoState extends State<PhoneInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  String _phone = '', _otp = '', _verificationID = '';
  bool _otpSend = false, _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: defaultPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Добро пожаловать',
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                'Подтвердите номер, чтобы продолжить',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
          const SizedBox(
            height: 40,
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
                  margin: EdgeInsets.only(bottom: _otpSend ? 30 : 0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      counterText: '',
                      hintText: '+7(900)-000-00-00',
                    ),
                    keyboardType: TextInputType.phone,
                    maxLength: 18,
                    enabled: !_otpSend,
                    onChanged: (value) => _phone = value,
                    validator: (value) => isValidPhoneNumber(value),
                    onFieldSubmitted: (_) => _sendOTP(),
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
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          onChanged: (value) => _otp = value,
                          onFieldSubmitted: (_) => _login(),
                        ),
                      )
                    : Container(),
                _otpSend
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                            child: RawMaterialButton(
                              onPressed: () => setState(() {
                                _otpSend = false;
                                _verificationID = '';
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
                    : Container(),
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
              onPressed: () => _otpSend ? _login() : _sendOTP(),
              elevation: 0,
              child: !_isLoading
                  ? Text(
                      _otpSend ? 'Подтвердить' : 'Продолжить',
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
        ],
      ),
    );
  }

  Future _sendOTP() async {
    FocusScope.of(context).requestFocus(FocusNode());
    bool formIsValid = _formKey.currentState?.validate() ?? false;

    if (formIsValid) {
      setState(() {
        _isLoading = true;
      });
      await Auth.auth.verifyPhoneNumber(
        phoneNumber: makePhoneValid(_phone),
        timeout: const Duration(seconds: 30),
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
          log(verificationFailed.message!);
          Fluttertoast.showToast(
            msg: 'Неудачная верификация',
            backgroundColor: Colors.black.withOpacity(0.7),
          );
        },
        codeSent: (verificationID, resendingToken) async {
          setState(() {
            _isLoading = false;
            _otpSend = true;
            _verificationID = verificationID;
          });
        },
        codeAutoRetrievalTimeout: (verificationID) async {},
      );
    }
  }

  Future _login() async {
    FocusScope.of(context).requestFocus(FocusNode());
    var phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: _verificationID,
      smsCode: _otp,
    );

    Auth.signInWithPhoneAuthCredential(phoneAuthCredential);
  }
}
