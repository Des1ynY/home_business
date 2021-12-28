part of 'sign_up.dart';

class AddressSetting extends StatefulWidget {
  AddressSetting({Key? key}) : super(key: key);

  @override
  State<AddressSetting> createState() => _AddressSettingState();
}

class _AddressSettingState extends State<AddressSetting> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthController _authController = AuthController.to;

  final FocusNode _streetNode = FocusNode(),
      _buildingNode = FocusNode(),
      _approachNode = FocusNode(),
      _appartmentNode = FocusNode();

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
            'Укажите адрес',
            style: Get.textTheme.headline1,
          ),
          Text(
            'Его увидят только жители вашего ЖК',
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
                FormFieldLabel(label: 'Город'),
                CustomFormField(
                  hintText: 'Москва',
                  controller: _authController
                      .fieldControllers[FormFieldControllers.city]!,
                  validator: Validator.notEmpty,
                  action: (_) => Get.focusScope!.requestFocus(_streetNode),
                ),
                SizedBox(
                  height: 20,
                ),
                FormFieldLabel(label: 'Улица'),
                CustomFormField(
                  hintText: 'Пушкина',
                  controller: _authController
                      .fieldControllers[FormFieldControllers.street]!,
                  focusNode: _streetNode,
                  validator: Validator.notEmpty,
                  action: (_) => Get.focusScope!.requestFocus(_buildingNode),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormFieldLabel(label: 'Дом'),
                          CustomFormField(
                            hintText: '4',
                            controller: _authController.fieldControllers[
                                FormFieldControllers.building]!,
                            focusNode: _buildingNode,
                            keyboardType: TextInputType.number,
                            validator: Validator.number,
                            action: (_) =>
                                Get.focusScope!.requestFocus(_approachNode),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormFieldLabel(label: 'Подъезд'),
                          CustomFormField(
                            hintText: '1',
                            controller: _authController.fieldControllers[
                                FormFieldControllers.approach]!,
                            focusNode: _approachNode,
                            keyboardType: TextInputType.number,
                            validator: Validator.number,
                            action: (_) =>
                                Get.focusScope!.requestFocus(_appartmentNode),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormFieldLabel(label: 'Квартира'),
                          CustomFormField(
                            hintText: '99',
                            controller: _authController.fieldControllers[
                                FormFieldControllers.appartment]!,
                            focusNode: _appartmentNode,
                            keyboardType: TextInputType.number,
                            validator: Validator.number,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          CustomButton(
            label: 'Продолжить',
            action: () {
              if (_formKey.currentState!.validate()) {
                _authController.nextPage();
              }
            },
          ),
          GestureDetector(
            onTap: () => Get.toNamed(signInRoute),
            child: SizedBox(
              height: 40,
              child: Center(
                child: Text(
                  'Уже есть аккаунт?',
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
