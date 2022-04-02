import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import '../widget/iconWidget.dart';

class NewSetting extends StatefulWidget {
  const NewSetting({Key? key}) : super(key: key);

  @override
  _NewSettingState createState() => _NewSettingState();
}

class _NewSettingState extends State<NewSetting> {
  @override
  Widget build(BuildContext context) =>Scaffold(
    body: SafeArea(
      child: ListView(
        padding: EdgeInsets.all(21.0),
        children: [
            SettingsGroup(
            title: 'General',
            children: <Widget>[
              buildLogout(),
              buildDeleteAccount()
            ],
          ),
        ],
      ),
    ),
  );

  Widget buildLogout() =>SimpleSettingsTile(
    title: "Logout",
    subtitle:'',
    leading: IconWidget(icon: Icons.logout,color: Colors.blueAccent,),
    onTap: (){},
  );
  Widget buildDeleteAccount() =>SimpleSettingsTile(
    title: "Account Delete",
    subtitle:'',
    leading: IconWidget(icon: Icons.delete,color: Colors.redAccent,),
    onTap: (){},
  );
}
