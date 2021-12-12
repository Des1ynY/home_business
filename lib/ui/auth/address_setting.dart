import 'package:flutter/material.dart';

import '/ui/ui_components.dart';
import '/services/router.dart';
import 'sign_up.dart';
import '/appdata/funcs.dart';
import '/models/app_user.dart';
import '/appdata/consts.dart';

class AddressSettings extends StatefulWidget {
  const AddressSettings({Key? key}) : super(key: key);

  @override
  _AddressSettingsState createState() => _AddressSettingsState();
}

class _AddressSettingsState extends State<AddressSettings> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _streetField = FocusNode(),
      _approachField = FocusNode(),
      _homeField = FocusNode(),
      _apartmentField = FocusNode();

  String _city = '', _street = '', _approach = '', _home = '', _apartment = '';

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
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  'Укажите адрес',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Text(
                'Его увидят только жители вашего дома',
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
                  'Город',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Москва',
                    ),
                    textCapitalization: TextCapitalization.words,
                    cursorColor: primaryColor,
                    keyboardType: TextInputType.text,
                    onChanged: (value) => _city = value,
                    validator: (value) =>
                        value!.isEmpty ? 'Укажите город' : null,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_streetField);
                    },
                  ),
                ),
                Text(
                  'Улица',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Пушкина',
                    ),
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.streetAddress,
                    focusNode: _streetField,
                    onChanged: (value) => _street = value,
                    validator: (value) =>
                        value!.isEmpty ? 'Укажите улицу' : null,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_homeField);
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 90,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Дом',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                counterText: '',
                                hintText: '4',
                              ),
                              maxLength: 4,
                              keyboardType: TextInputType.number,
                              focusNode: _homeField,
                              onChanged: (value) => _home = value,
                              validator: (value) => !isDigit(value) ? '' : null,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_approachField);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 90,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Подъезд',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                counterText: '',
                                hintText: '1',
                              ),
                              maxLength: 2,
                              keyboardType: TextInputType.number,
                              focusNode: _approachField,
                              onChanged: (value) => _approach = value,
                              validator: (value) => !isDigit(value) ? '' : null,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_apartmentField);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Квартира',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                counterText: '',
                                hintText: '99',
                              ),
                              keyboardType: TextInputType.number,
                              focusNode: _apartmentField,
                              maxLength: 4,
                              onChanged: (value) => _apartment = value,
                              validator: (value) => !isDigit(value) ? '' : null,
                              onFieldSubmitted: (_) => _submit(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: CustomButton(
              label: 'Продолжить',
              action: () => _submit(),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, signInRoute);
              },
              behavior: HitTestBehavior.translucent,
              child: const SizedBox(
                height: 30,
                child: Text(
                  'У меня уже есть аккаунт',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    FocusScope.of(context).requestFocus(FocusNode());
    bool formIsValid = _formKey.currentState?.validate() ?? false;

    if (formIsValid) {
      AppUser.city = _city.trim();
      AppUser.street = _street.trim();
      AppUser.building = _home.trim();
      AppUser.approach = _approach.trim();
      AppUser.apartment = _apartment.trim();

      loginCurrentPage += 1;
      loginPageController.animateToPage(
        loginCurrentPage,
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    }
  }
}
