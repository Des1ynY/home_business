import 'package:flutter/material.dart';

import '/services/router.dart';
import '/ui/auth/login.dart';
import '/models/app_user.dart';
import '/appdata/consts.dart';
import '/widgets/button.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({Key? key}) : super(key: key);

  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _surnameField = FocusNode(), _bioField = FocusNode();

  String _name = '', _surname = '', _bio = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: defaultPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Расскажите о себе',
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                'Позвольте соседям узнать вас ближе',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Имя',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Роберт',
                    ),
                    keyboardType: TextInputType.name,
                    onChanged: (value) => _name = value,
                    validator: (value) =>
                        value!.isEmpty ? 'Представьтесь' : null,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_surnameField),
                  ),
                ),
                Text(
                  'Фамилия',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Дауни Мл.',
                    ),
                    keyboardType: TextInputType.name,
                    onChanged: (value) => _surname = value,
                    validator: (value) =>
                        value!.isEmpty ? 'Представьтесь' : null,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_bioField),
                  ),
                ),
                Text(
                  'Био',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: '19 лет. Мобильный разработчик на Flutter.'),
                    focusNode: _bioField,
                    maxLength: 140,
                    maxLines: 5,
                    minLines: 1,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (value) => _bio = value,
                    onFieldSubmitted: (_) => _submit(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: CustomButton(
              label: 'Зарегистрироваться',
              action: () => _submit(),
            ),
          ),
          Center(
            child: CustomTextButton(
              label: 'Назад',
              action: () {
                loginCurrentPage -= 1;
                loginPageController.animateToPage(
                  loginCurrentPage,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInBack,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Future _submit() async {
    FocusScope.of(context).requestFocus(FocusNode());
    bool formIsValid = _formKey.currentState?.validate() ?? false;

    if (formIsValid) {
      var user = AppUser();
      user.name = _name;
      user.surname = _surname;
      user.bio = _bio;

      Navigator.pushReplacementNamed(context, successRoute);
    }
  }
}
