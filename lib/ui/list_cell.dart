import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';

class ListCell extends StatelessWidget {
  const ListCell({
    @required this.title,
    this.leading,
    this.trailing,
    this.subtitle,
    this.onTap,
    this.onLongPress,
  });

  factory ListCell.icon({
    @required IconData icon,
    @required String title,
    Widget trailing,
    Widget subtitle,
    VoidCallback onTap,
    VoidCallback onLongPress,
  }) {
    return ListCell(
      leading: Icon(icon, size: 40),
      trailing: trailing,
      title: title,
      subtitle: subtitle,
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }

  final Widget leading, trailing, subtitle;
  final String title;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(thickness: 2, indent: 15, endIndent: 15),
        ListTile(
          leading: leading,
          title: Text(
            title,
            style: TextStyle(
              fontSize: 17.ssp.toDouble(),
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          trailing: trailing,
          dense: true,
          subtitle: subtitle,
          contentPadding: EdgeInsets.symmetric(horizontal: 28.w.toDouble()),
          onTap: onTap,
          onLongPress: onLongPress,
        ),
        const Divider(thickness: 2, indent: 15, endIndent: 15),
      ],
    );
  }
}
