part of 'sign_up.dart';

class PhoneVerification extends StatefulWidget {
  PhoneVerification({Key? key}) : super(key: key);

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthController _authController = AuthController.to;

  final FocusNode _otpNode = FocusNode();

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
                CustomFormField(
                  hintText: '+7(900)-000-00-00',
                  controller: _authController
                      .fieldControllers[FormFieldControllers.phone]!,
                  keyboardType: TextInputType.number,
                  validator: Validator.number,
                  action: null,
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
                              validator: Validator.notEmpty,
                              action: null,
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
          SizedBox(
            height: 40,
          ),
          Obx(
            () => CustomButton(
              label: 'Зарегистрироваться',
              action: _authController.codeSend.value ? null : null,
            ),
          ),
          GestureDetector(
            onTap: () => _authController.prevPage(),
            child: SizedBox(
              height: 40,
              child: Center(
                child: Text(
                  'Назад',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: CustomTheme.textColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
