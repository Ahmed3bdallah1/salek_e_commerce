// //TODO
// final updatePasswordProvider = FutureProvider<UpdatePasswordModel>((ref) async {
//   final updated = await getIt<UpdatePasswordUseCase>().call(UpdatePasswordParams(
//     oldPassword: 'oldPassword',
//     newPassword: 'newPassword',
//     confirmPassword: 'confirmPassword',
//   ));
//   return updated.fold((l) {
//     throw l;
//   }, (r) {
//     return (r);
//   });
// });
