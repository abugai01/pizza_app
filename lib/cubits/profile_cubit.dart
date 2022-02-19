// import 'package:equatable/equatable.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
//
// abstract class CustomFormState extends Equatable {}
//
// class FormEmptyState extends CustomFormState {
//   @override
//   List<Object> get props => [];
// }
//
// class FormGenericState extends CustomFormState {
//   final Map<String, TextEditingController> controllers;
//   final Key formKey;
//
//   FormGenericState({
//     required this.controllers,
//     required this.formKey,
//   });
//
//   @override
//   List<Object> get props => [controllers];
// }
//
// //TODO: подумать, что можно менять, а что нет...
// //TODO: валидации также должны быть здесь! сравнивать, изменилось ли что-то по сравнению с прошлым
// //TODO: дату рождения парсить туда обратно не очень((
// //TODO: визуальный фидбек на случай, если что-то не удалось обновить
// class MyProfileCubit extends Cubit<CustomFormState> {
//   static const DATE_FORMAT = 'dd.MM.yyyy';
//
//   final ExecutorCubit executorCubit;
//
//   Map<String, TextEditingController> controllers = {};
//   Key formKey;
//   Profile profile;
//   City mainCity;
//   //List<Service> services;
//
//   MyProfileCubit(this.executorCubit)
//       : formKey = GlobalKey<FormState>(),
//         profile = executorCubit.executor!
//             .profile, //TODO: убедиться, что сюда не попасть, если executor == null
//         mainCity = executorCubit.executor!.cityEnum,
//         //services = executorCubit.executor!.services,
//         super(FormEmptyState()) {
//     fillControllers(executorCubit.executor);
//     emit(FormGenericState(controllers: controllers, formKey: formKey));
//   }
//
//   void fillControllers(Executor? executor) {
//     String birthdayText =
//         DateFormat(DATE_FORMAT).format(profile.birthday!); //TODO: null safety
//
//     if (executor != null) {
//       controllers[Profile.NAME] = TextEditingController(text: profile.name);
//       controllers[Profile.SURNAME] =
//           TextEditingController(text: profile.surname);
//       controllers[Profile.PHONE] = TextEditingController(text: profile.phone);
//       controllers[Profile.EMAIL] = TextEditingController(text: profile.email);
//       controllers[Profile.BIRTHDAY] = TextEditingController(text: birthdayText);
//
//       mainCity = executor.cityEnum;
//     }
//   }
//
//   void saveChanges() {
//     //controllers.values.toList().forEach((element) => print(element.text));
//
//     //TODO: проверить все
//
//     if (!mapEquals(profile.toMap(), executorCubit.executor!.profile.toMap()) ||
//         mainCity != executorCubit.executor!.cityEnum) {
//       //print("Data was changed");
//
//       executorCubit.updateExecutor(
//           name: controllers[Profile.NAME]!.text,
//           surname: controllers[Profile.SURNAME]!.text,
//           phone: controllers[Profile.PHONE]!.text,
//           email: controllers[Profile.EMAIL]!.text,
//           birthday: profile.birthday,
//           mainCity: mainCity);
//     } else {
//       //print("Data is the same");
//     }
//   }
//
//   void selectBirthday(BuildContext context) async {
//     DateTime? selectedDate = await DatePicker.selectDate(context,
//         initialDate: profile.birthday, mode: DatePickerType.pastOnly);
//
//     if (selectedDate != null) {
//       //TODO: надо ли эмиттить новый стейт?
//       controllers[Profile.BIRTHDAY]!.text =
//           DateFormat(DATE_FORMAT).format(selectedDate);
//
//       profile.birthday = selectedDate;
//     }
//   }
// }
