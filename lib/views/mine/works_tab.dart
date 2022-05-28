import 'package:pet_community/util/tools.dart';

class WorksTab extends StatefulWidget {
  const WorksTab({Key? key}) : super(key: key);

  @override
  State<WorksTab> createState() => _WorksTabState();
}

class _WorksTabState extends State<WorksTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3,
            height: 150.w,
            color: ThemeUtil.primaryColor(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.camera_alt),
                Text("发作品"),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            height: 150.w,
            color: Colors.redAccent,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            height: 150.w,
            color: Colors.pinkAccent,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            height: 150.w,
            color: Colors.deepPurpleAccent,
          ),
        ],
      ),
    );
  }
}
