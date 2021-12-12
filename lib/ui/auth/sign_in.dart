import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/services/router.dart';
import '/ui/ui_components.dart';
import '/services/firebase_db.dart';
import '/services/firebase_auth.dart';
import '/services/shared_prefs.dart';
import '/appdata/consts.dart';
import '/appdata/funcs.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  String _phone = '', _otp = '', _verificationID = '';
  bool _otpSend = false, _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    const CustomAppBar(),
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
                              margin: const EdgeInsets.only(bottom: 10),
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
                                Container(
                                  margin: const EdgeInsets.only(bottom: 40),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _otpSend = false;
                                        _verificationID = '';
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
                                          color: textColor,
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
          ),
        ),
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
        timeout: const Duration(seconds: 60),
        verificationCompleted: (phoneAuthCredential) async {
          await _verificationCompleted(phoneAuthCredential);
          Navigator.pushNamedAndRemoveUntil(
              context, homescreenRoute, (route) => false);
        },
        verificationFailed: (verificationFailed) async {
          setState(() {
            _isLoading = false;
          });
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

    await _verificationCompleted(phoneAuthCredential);
    Navigator.pushNamedAndRemoveUntil(
        context, homescreenRoute, (route) => false);
  }

  _verificationCompleted(phoneAuthCredential) async {
    UserCredential userCredential =
        await Auth.signInWithPhoneAuthCredential(phoneAuthCredential);
    User user = userCredential.user!;

    if (await UsersDatabase.checkUser(user.uid)) {
      StreamBuilder(
        stream: UsersDatabase.getUser(user.uid),
        builder: (
          context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
        ) {
          if (snapshot.hasData) {
            var doc = snapshot.data!.docs.first;
            Map<String, dynamic> json = doc.data();
            LocalDataStorage.setUserData(json);

            return Container();
          } else {
            return Container();
          }
        },
      );
    } else {
      setState(() {
        _otp = '';
        _otpSend = false;
        _verificationID = '';
        _phone = '';
      });

      Fluttertoast.showToast(
        msg: 'Аккаута с таким номером не существует',
        backgroundColor: Colors.black.withOpacity(0.7),
      );
    }
  }
}
