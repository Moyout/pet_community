import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/community/community_detail_viewmodel.dart';
import 'package:pet_community/views/community/detail/comment_item.dart';

class CommentListView extends StatefulWidget {
  final int articleId;
  final int userId;

  const CommentListView({Key? key, required this.articleId, required this.userId}) : super(key: key);

  @override
  State<CommentListView> createState() => _CommentListViewState();
}

class _CommentListViewState extends State<CommentListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(context.read<CommunityDetailViewModel>().commentModel.data!.articleComments.length, (index) {
          return CommentItem(
            userId: widget.userId,
            index: index,
            commentatorId: context.read<CommunityDetailViewModel>().commentModel.data!.articleComments[index].userId,
          );
        })
      ],
    );
  }
}
