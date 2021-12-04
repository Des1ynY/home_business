import 'package:flutter/material.dart';

import '/widgets/button.dart';
import '/widgets/appbar.dart';
import '/widgets/layer.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _surnameField = FocusNode(), _ageField = FocusNode();

  String _name = '', _surname = '', _age = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomLayer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(leading: true),
                Container(
                  margin: const EdgeInsets.only(top: 35),
                  child: Text(
                    'Расскажите о себе',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Text(
                  'Позвольте соседям узнать вас немного лучше',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
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
                    margin: const EdgeInsets.only(bottom: 30),
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
                    margin: const EdgeInsets.only(bottom: 30),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Дауни Мл.',
                      ),
                      keyboardType: TextInputType.name,
                      onChanged: (value) => _surname = value,
                      validator: (value) =>
                          value!.isEmpty ? 'Представьтесь' : null,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_ageField),
                    ),
                  ),

                  // Todo: specify age and bio fileds
                ],
              ),
            ),
            CustomButton(
              label: 'Продолжить',
              action: () => _submit(),
            ),
          ],
        ),
      ),
    );
  }

  Future _submit() async {}
}
