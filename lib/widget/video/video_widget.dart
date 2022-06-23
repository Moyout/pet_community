import 'package:better_player/better_player.dart';
import 'package:pet_community/util/tools.dart';

class VideoWidget extends StatefulWidget {
  final String url;

  const VideoWidget({Key? key, required this.url}) : super(key: key);

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late BetterPlayerController playerController;

  @override
  void initState() {
    super.initState();
    BetterPlayerDataSource playerDataSource = BetterPlayerDataSource(BetterPlayerDataSourceType.network, widget.url);
    playerController =
        BetterPlayerController(const BetterPlayerConfiguration(), betterPlayerDataSource: playerDataSource);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 3,
      child: BetterPlayer(
        controller: playerController,
      ),
    );
  }
}
