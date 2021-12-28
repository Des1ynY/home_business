import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '/screens/components/custom_button.dart';
import '/screens/components/tag_tile.dart';
import '/appdata/funcs.dart';
import '/services/firebase_db.dart';
import '/models/app_user.dart';

final Map<String, dynamic> _orderInfo = {};
final PageController _controller = PageController();
int _currentPage = 0;

class AddOrder extends StatefulWidget {
  const AddOrder({Key? key}) : super(key: key);

  @override
  _AddOrderState createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новое предложение'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: getScaffoldHeightWithoutAppbar(context),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: PageView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (_) => setState(() {
                _currentPage = _currentPage;
              }),
              children: const [
                _OrderDescription(),
                _OrderProperties(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OrderDescription extends StatefulWidget {
  const _OrderDescription({Key? key}) : super(key: key);

  @override
  __OrderDescriptionState createState() => __OrderDescriptionState();
}

class __OrderDescriptionState extends State<_OrderDescription> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _descriptionField = FocusNode();
  String _title = '', _description = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Опишите услугу',
          style: Theme.of(context).textTheme.headline1,
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 40),
          child: Text(
            'Расскажите соседям, что вы предлагаете',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Название',
                style: Theme.of(context).textTheme.headline2,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  decoration: const InputDecoration(hintText: 'Вкусный кофе'),
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.text,
                  onChanged: (value) => _title = value,
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Укажите название',
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionField);
                  },
                ),
              ),
              Text(
                'Описание',
                style: Theme.of(context).textTheme.headline2,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 40),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText:
                        '''Приготовлю для вас вкусный кофе на завтрак. Жду вас у себя с 8:00 до 9:15. Потом мне нужно бежать на работу(''',
                  ),
                  minLines: 3,
                  maxLines: 10,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionField,
                  onChanged: (value) => _description = value,
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Предоставьте описание',
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
    );
  }

  void _submit() {
    FocusScope.of(context).requestFocus(FocusNode());
    bool formIsValid = _formKey.currentState?.validate() ?? false;

    if (formIsValid) {
      _orderInfo['authorId'] = AppUser.uid;
      _orderInfo['title'] = _title.trim();
      _orderInfo['description'] = _description.trim();

      _currentPage += 1;
      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    }
  }
}

class _OrderProperties extends StatefulWidget {
  const _OrderProperties({Key? key}) : super(key: key);

  @override
  __OrderPropertiesState createState() => __OrderPropertiesState();
}

class __OrderPropertiesState extends State<_OrderProperties> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _tagField = FocusNode(), _priceToField = FocusNode();
  final TextEditingController _priceFrom = TextEditingController();
  final TextEditingController _priceTo = TextEditingController();
  final TextEditingController _tag = TextEditingController();
  final Set<String> _tags = {};
  final Set<Widget> _tagTiles = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Укажите цену и теги',
          style: Theme.of(context).textTheme.headline1,
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 40),
          child: Text(
            'Оцените услугу и добавьте теги для быстрого поиска',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Цена',
                style: Theme.of(context).textTheme.headline2,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'от ',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Container(
                      width: 50,
                      margin: const EdgeInsets.only(left: 10, right: 5),
                      child: TextFormField(
                        decoration: const InputDecoration(hintText: '50'),
                        maxLines: 1,
                        controller: _priceFrom,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _priceTo.text = value;
                          });
                        },
                        validator: (value) => value!.isNotEmpty ? null : ' ',
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceToField);
                        },
                      ),
                    ),
                    Text(
                      'руб. до ',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Container(
                      width: 50,
                      margin: const EdgeInsets.only(left: 10, right: 5),
                      child: TextFormField(
                        decoration: const InputDecoration(hintText: '250'),
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        controller: _priceTo,
                        focusNode: _priceToField,
                        validator: (value) => value!.isNotEmpty ? null : ' ',
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_tagField);
                        },
                      ),
                    ),
                    Text(
                      'руб.',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
              Text(
                'Тeги',
                style: Theme.of(context).textTheme.headline2,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  decoration: const InputDecoration(hintText: 'Кофе'),
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                  controller: _tag,
                  focusNode: _tagField,
                  maxLines: 1,
                  validator: (_) =>
                      _tags.isNotEmpty ? null : 'Укажите хотя бы один тег',
                  onFieldSubmitted: (_) {
                    setState(() {
                      _tags.add(_tag.text.trim());
                      _tagTiles.add(TagTile(tag: _tag.text.trim()));
                      _tag.text = '';
                    });
                    FocusScope.of(context).requestFocus(_tagField);
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 35),
          child: Wrap(
            spacing: 7,
            runSpacing: 10,
            children: _tagTiles.toList(),
          ),
        ),
        CustomButton(
          label: 'Опубликовать',
          action: () => _submit(),
        ),
      ],
    );
  }

  _submit() async {
    bool formIsValid = _formKey.currentState?.validate() ?? false;

    if (formIsValid) {
      _orderInfo['price'] = _priceFrom.text.trim() == _priceTo.text.trim()
          ? '${_priceFrom.text.trim()} руб.'
          : "${_priceFrom.text.trim()} - ${_priceTo.text.trim()} руб.";
      _orderInfo['tags'] = _tags.toList();
      _orderInfo['uid'] = getUID();
      _orderInfo['creationDate'] = Timestamp.now();

      await OrdersDatabase.createOrder(_orderInfo['uid'], _orderInfo);
      Navigator.pop(context);
    }
  }
}
