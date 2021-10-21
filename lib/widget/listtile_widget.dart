import 'package:assignmentforjob/Screens/list_screen.dart';
import 'package:assignmentforjob/models/listdata_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ListCard extends StatelessWidget {
  final ListDataModel onedata;
  const ListCard({Key? key, required this.onedata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            Icons.book,
            color: blackcolor,
            size: 40,
          ),
          horizontalTitleGap: 5,
          title: (onedata.login)
              .text
              .black
              .size(14)
              .fontWeight(FontWeight.w600)
              .make(),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 32,
                child: (onedata.description.replaceAll("[DEPRECATED] ", ""))
                    .text
                    .color(lightblackcolor)
                    .size(12)
                    .fontWeight(FontWeight.w400)
                    .softWrap(true)
                    .maxLines(2)
                    .overflow(TextOverflow.ellipsis)
                    .align(TextAlign.left)
                    .make(),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildicondetail(
                    text: onedata.language,
                    icon: Icons.code,
                  ),
                  buildicondetail(
                    text: onedata.openIssues,
                    icon: Icons.bug_report,
                  ),
                  buildicondetail(
                    text: onedata.watchers,
                    icon: Icons.face,
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(
          height: 1,
          color: Colors.grey,
        ),
      ],
    );
  }
}

Widget buildicondetail({
  required String text,
  required IconData icon,
}) {
  return Visibility(
    visible: text.isNotEmpty,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: blackcolor,
          size: 14,
        ),
        const SizedBox(
          width: 5,
        ),
        (text).text.size(12).color(lightblackcolor).make(),
        const SizedBox(
          width: 3,
        ),
      ],
    ),
  );
}
