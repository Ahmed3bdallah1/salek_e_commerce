import 'package:car_rentting/Features/chat/domain/entities/chats_room_entity.dart';
import 'package:car_rentting/Features/chat/presentation/chat_screen.dart';
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  child: Image.asset(
                    chatsRoomEntity.photo,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chatsRoomEntity.title,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              chatsRoomEntity.lastMessage,
                              style: const TextStyle(
                                  fontSize: 13, color: AppColors.grayC4),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Text(
                  intl.DateFormat.jm().format(chatsRoomEntity.lastMessageTime),
                  style: const TextStyle(fontSize: 13, color: AppColors.grayC4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
