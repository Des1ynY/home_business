part of 'sign_up.dart';

class PhoneVerification extends StatefulWidget {
  PhoneVerification({Key? key}) : super(key: key);

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthController _authController = AuthController.to;

  final FocusNode _phoneNode = FocusNode(), _otpNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Последний шаг',
            style: Get.textTheme.headline1,
          ),
          Text(
            'Подтвердите номер',
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
                            SizedBox(
                              height: 20,
                            ),
                            FormFieldLabel(label: 'Код подтверждения'),
                            CustomFormField(
                              hintText: '000000',
                              controller: _authController
                                  .fieldControllers[FormFieldControllers.otp]!,
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
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
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
                        _authController.signUpWithOtp();
                    }
                  : () {
                      if (_formKey.currentState!.validate()) {
                        _authController.signUp();
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
          CustomTextButton(
            text: 'Назад',
            action: () => _authController.prevPage(),
          ),
        ],
      ),
    );
  }
}
