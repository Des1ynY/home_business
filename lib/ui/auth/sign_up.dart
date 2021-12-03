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

  String _phone = '', _otp = '', _verificationID = '';
  bool _otpSend = false, _isLoading = false;

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
                        'Добро пожаловать',
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
                        margin: EdgeInsets.only(bottom: _otpSend ? 30 : 0),
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
                          keyboardType: TextInputType.phone,
                          maxLength: 18,
                          enabled: !_otpSend,
                          onChanged: (value) => _phone = value,
                          validator: (value) => isValidPhoneNumber(value),
                          onFieldSubmitted: (value) => _sendOTP(),
                        ),
                      ),
                      _otpSend
                          ? Text(
                              'Код потверждения',
                              style: Theme.of(context).textTheme.headline2,
                            )
                          : const SizedBox(),
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
                                cursorColor: primaryColor,
                                keyboardType: TextInputType.number,
                                maxLength: 6,
                                onChanged: (value) => _otp = value,
                                onFieldSubmitted: (value) => _login(),
                              ),
                            )
                          : const SizedBox(),
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
                    onPressed: () => _otpSend ? _login() : _sendOTP(),
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
                _otpSend
                    ? const SizedBox()
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _sendOTP() async {
    bool formIsValid = _formKey.currentState?.validate() ?? false;

    if (formIsValid) {
      setState(() {
        _isLoading = true;
      });
      await Auth.verifyPhoneNumber(
        phoneNumber: makePhoneValid(_phone),
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
          Fluttertoast.showToast(msg: 'Неудачная верификация');
        },
        codeSent: (verificationID, resendingToken) async {
          setState(() {
            _isLoading = false;
            _otpSend = true;
            _verificationID = _verificationID;
          });
        },
      );
    }
  }

  Future _login() async {
    var phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: _verificationID,
      smsCode: _otp,
    );

    Auth.signInWithPhoneAuthCredential(phoneAuthCredential);
  }
}
