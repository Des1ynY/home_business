import 'dart:developer';
import 'package:flutter/material.dart';

import '/widgets/button.dart';
import '/models/app_user.dart';
import '/widgets/layer.dart';
import '/appdata/consts.dart';
import '/widgets/appbar.dart';

class AddressInfo extends StatefulWidget {
  const AddressInfo({Key? key}) : super(key: key);

  @override
  _AddressInfoState createState() => _AddressInfoState();
}

class _AddressInfoState extends State<AddressInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _streetField = FocusNode(),
      _approachField = FocusNode(),
      _homeField = FocusNode(),
      _apartmentField = FocusNode();

  String _city = '', _street = '', _approach = '', _home = '', _apartment = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomLayer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(leading: true),
                Container(
                  margin: const EdgeInsets.only(top: 35),
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
                    margin: const EdgeInsets.only(bottom: 30),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Москва',
                      ),
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
                    margin: const EdgeInsets.only(bottom: 30),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Пушкина',
                      ),
                      keyboardType: TextInputType.streetAddress,
                      focusNode: _streetField,
                      onChanged: (value) => _street = value,
                      validator: (value) =>
                          value!.isEmpty ? 'Укажите улицу' : null,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_approachField);
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                                validator: (value) =>
                                    value!.isEmpty ? '' : null,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_homeField);
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
                                validator: (value) =>
                                    value!.isEmpty ? '' : null,
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
                                validator: (value) =>
                                    value!.isEmpty ? '' : null,
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
            CustomButton(
              label: 'Продолжить',
              action: () => _submit(),
            ),
          ],
        ),
      ),
    );
  }

  Future _submit() async {
    FocusScope.of(context).requestFocus(FocusNode());
    // Todo: specify toInt()
    var user = AppUser();
    user.city = _city;
    user.street = _street;
    user.home = _home;
    user.approach = _approach;
    user.apartment = _apartment;

    log(AppUser().city);
  }
}
