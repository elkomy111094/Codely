import '../models/notification_model.dart';
import '../repositories/notification_repository.dart';
import '../shared/generic_cubit/generic_cubit.dart';
import '../shared/models/failure.dart';

class NotificationViewModel {
  ///Constructor
  /// Called When Creating An Object From This View Moddel == initState
  NotificationViewModel() {
    getAllNotification();
  }

  GenericCubit<dynamic> notificationCubit = GenericCubit(null);
  NotificationRepository notificationRepository = NotificationRepository();
  List<NotificationModel>? notificationsList;
  List<NotificationModel>? fakeNotificationsList;

  Future getAllNotification() async {
    if (notificationsList != null) notificationsList = null;
    notificationCubit.onLoadingState();
    try {
      notificationsList = await notificationRepository.getNotificationsList();
      fakeNotificationsList?.addAll(notificationsList!);
      notificationCubit.onSuccessRequest(notificationsList);
    } on Failure catch (failure) {
      notificationCubit.onErrorState(Failure(message: failure.message));
    }
  }

  deleteNoteFromMyList(int index) {
    notificationsList!.removeAt(index);
    notificationCubit.onUpdateData(true);
  }

  Future deleteNote(int noteId) async {
    try {
      await notificationRepository.deleteNote(noteId: noteId);
    } on Failure catch (failure) {
      notificationCubit.onErrorState(Failure(message: failure.message));
    }
  }
}
