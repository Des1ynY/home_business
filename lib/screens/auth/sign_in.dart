import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/appdata/theme.dart';
import '/controllers/auth_controller.dart';
import '/screens/components/form_field.dart';
import '/screens/components/form_field_label.dart';
import '/screens/components/custom_text_button.dart';
import '/screens/components/loading_indicator.dart';
import '/services/validators.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthController _authController = AuthController.to;

  final FocusNode _phoneNode = FocusNode(), _otpNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _authController.fieldControllers[FormFieldControllers.phone]!.clear();
    _authController.fieldControllers[FormFieldControllers.otp]!.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'С возвращением',
              style: Get.textTheme.headline1,
            ),
            Text(
              'Войдите, чтобы продолжить',
              style: Get.textTheme.bodyText1,
            ),
            SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FormFieldLabel(label: 'Номер телефона'),
                  Obx(
                    () => CustomFormField(
                      hintText: '+7(900)-000-00-00',
                      controller: _authController
                          .fieldControllers[FormFieldControllers.phone]!,
                      focusNode: _phoneNode,
                      keyboardType: TextInputType.phone,
                      validator: Validator.phone,
                      enabled: !_authController.codeSend.value,
                    ),
                  ),
                  Obx(
                    () => _authController.codeSend.value
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FormFieldLabel(label: 'Код подтверждения'),
                              CustomFormField(
                                hintText: '000000',
                                controller: _authController.fieldControllers[
                                    FormFieldControllers.otp]!,
                                focusNode: _otpNode,
                                keyboardType: TextInputType.number,
                                validator: Validator.number,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomTextButton(
                                    text: 'Изменить номер',
                                    action: () {
                                      _authController.changeNumber();
                                      FocusScope.of(context)
                                          .requestFocus(_phoneNode);
                                    },
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          )
                        : SizedBox(
                            height: 40,
                          ),
                  ),
                ],
              ),
            ),
            Obx(
              () => MaterialButton(
                onPressed: _authController.codeSend.value
                    ? () {
                        if (_formKey.currentState!.validate())
                          _authController.signInWithOtp();
                      }
                    : () {
                        if (_formKey.currentState!.validate()) {
                          _authController.signIn();
                          FocusScope.of(context).requestFocus(_otpNode);
                        }
                      },
                elevation: 0,
                highlightElevation: 0,
                color: CustomTheme.primaryColor,
                minWidth: Get.width,
                child: _authController.isLoading.value
                    ? LoadingIndicator()
                    : Text(
                        _authController.codeSend.value
                            ? 'Зарегистрироваться'
                            : 'Подтвердить',
                        style: Get.textTheme.button,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
