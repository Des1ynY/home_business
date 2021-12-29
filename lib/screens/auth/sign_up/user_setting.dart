part of 'sign_up.dart';

class UserSettings extends StatefulWidget {
  UserSettings({Key? key}) : super(key: key);

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthController _authController = AuthController.to;

  final FocusNode _surnameNode = FocusNode(), _bioNode = FocusNode();

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
            'Расскажите о себе',
            style: Get.textTheme.headline1,
          ),
          Text(
            'Позвольте соседям узнать вас лучше',
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
                FormFieldLabel(label: 'Имя'),
                CustomFormField(
                  hintText: 'Роберт',
                  controller: _authController
                      .fieldControllers[FormFieldControllers.name]!,
                  validator: Validator.name,
                  action: (_) =>
                      FocusScope.of(context).requestFocus(_surnameNode),
                ),
                SizedBox(
                  height: 20,
                ),
                FormFieldLabel(label: 'Фамилия'),
                CustomFormField(
                  hintText: 'Дауни Мл.',
                  controller: _authController
                      .fieldControllers[FormFieldControllers.surname]!,
                  focusNode: _surnameNode,
                  validator: Validator.name,
                  action: (_) => FocusScope.of(context).requestFocus(_bioNode),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FormFieldLabel(
                      label: 'Био',
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      'опционально',
                      style: TextStyle(
                        color: CustomTheme.hintTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
                CustomFormField(
                  hintText: 'Гений, миллиардер, плейбой, филантроп.',
                  controller: _authController
                      .fieldControllers[FormFieldControllers.bio]!,
                  focusNode: _bioNode,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
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
          CustomTextButton(
            text: 'Назад',
            action: () => _authController.prevPage(),
          ),
        ],
      ),
    );
  }
}
