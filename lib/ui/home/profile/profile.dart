import 'package:flutter/material.dart';

import '/models/app_user.dart';
import '/services/router.dart';
import '/appdata/consts.dart';

class AppUserProfile extends StatefulWidget {
  const AppUserProfile({
    Key? key,
  }) : super(key: key);

  @override
  _AppUserProfileState createState() => _AppUserProfileState();
}

class _AppUserProfileState extends State<AppUserProfile> {
  final TextEditingController _controller = TextEditingController();
  final user = AppUser();

  @override
  void initState() {
    super.initState();
    _controller.text = user.bio;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: defaultPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _getProfileData(context),
            const Divider(color: darkGrey, indent: 20, endIndent: 20),
            _getServicesData(context),
          ],
        ),
      ),
    );
  }

  Widget _getProfileData(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: CircleAvatar(
            radius: 100,
            backgroundImage: const AssetImage('assets/default_ava.png'),
            foregroundImage: NetworkImage(user.imageUrl),
          ),
        ),
        Text(
          '${user.name} ${user.surname}',
          style: Theme.of(context).textTheme.headline2,
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: Text(
            'ул. ${user.street}, ${user.home}-${user.apartment}, подъезд №${user.approach}',
            maxLines: 2,
            style: const TextStyle(color: darkGrey),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15),
          child: TextField(
            decoration: InputDecoration(
              label: const Text(
                'О себе',
                style: TextStyle(
                  color: darkGrey,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: darkGrey),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            minLines: 1,
            maxLines: 5,
            controller: _controller,
            readOnly: true,
            enabled: false,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: buttonHeight,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    border: const Border.fromBorderSide(
                      BorderSide(color: darkGrey),
                    ),
                    borderRadius: BorderRadius.circular(buttonBorderRadius),
                  ),
                  child: RawMaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, userSettingsRoute);
                    },
                    elevation: 0,
                    child: const Text(
                      'Настроить профиль',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getServicesData(BuildContext context) {
    List<Widget> orders = [];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10, top: 3),
          child: Text(
            'Ваши услуги',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        orders.isEmpty
            ? SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: Text(
                    'Не предоставляете услуги',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: darkGrey,
                    ),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: orders.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return orders.elementAt(index);
                },
              )
      ],
    );
  }
}
