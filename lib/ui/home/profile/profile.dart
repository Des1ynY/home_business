import 'package:flutter/material.dart';

import '/models/app_user.dart';
import '/appdata/consts.dart';

class AppUserProfile extends StatefulWidget {
  const AppUserProfile({Key? key}) : super(key: key);

  @override
  _AppUserProfileState createState() => _AppUserProfileState();
}

class _AppUserProfileState extends State<AppUserProfile> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Padding(
          padding: defaultPadding,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.6,
                  width: MediaQuery.of(context).size.width * 0.6,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: const CircleAvatar(
                    backgroundImage: AssetImage('assets/default_ava.png'),
                    foregroundImage: AssetImage('assets/ava_0.png'),
                  ),
                ),
                const _ProfileData(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileData extends StatefulWidget {
  const _ProfileData({Key? key}) : super(key: key);

  @override
  __ProfileDataState createState() => __ProfileDataState();
}

class __ProfileDataState extends State<_ProfileData> {
  final AppUser _user = AppUser();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text('${_user.name} ${_user.surname}'),
          Text(_user.bio),
          Text('${_user.city}, ул. ${_user.street}, ${_user.home}'),
          Text('Подъезд ${_user.approach}, кв. ${_user.apartment}'),
        ],
      ),
    );
  }
}
