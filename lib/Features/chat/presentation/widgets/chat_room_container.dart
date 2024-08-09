import 'package:car_rentting/Features/chat/domain/entities/chats_room_entity.dart';
import 'package:car_rentting/Features/chat/presentation/chat_screen.dart';
import 'package:car_rentting/Ui/shared_widget/custom_text_field.dart';
import 'package:car_rentting/Ui/shared_widget/image_or_svg.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/utils/colors.dart';
import 'package:intl/intl.dart' as intl;

class ChatRoomContainer extends StatelessWidget {
  final ChatsRoomEntity chatsRoomEntity;

  const ChatRoomContainer({super.key, required this.chatsRoomEntity});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                id: chatsRoomEntity.id,
                isDisabled: chatsRoomEntity.status == 3 ? true : false,
              ),
            ),
          );
        },
        child: ListTile(
          trailing: Text(
            intl.DateFormat.yMd()
                .add_jm()
                .format(chatsRoomEntity.lastMessageTime),
            style: const TextStyle(fontSize: 13, color: AppColors.grayC4),
          ),
          subtitle: Text(
            chatsRoomEntity.lastMessage,
            style: AppFont.font12W400PrimaryOrange,
          ),
          title: Text(
            chatsRoomEntity.title,
            style: AppFont.font14W500Primary,
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ImageOrSvg(
              chatsRoomEntity.photo,
              fit: BoxFit.cover,
              width: 75,
              height: 75,
            ),
          ),
        ));
  }
}
