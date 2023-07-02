import 'package:employee_manager/database/employeeCrude.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AllListState {}

class InitAllListState extends AllListState {}

class IsEmptyState extends AllListState {}

class IsNotEmptyState extends AllListState {}

class IsErrorState extends AllListState {}

class AllListCubit extends Cubit<AllListState> {
  AllListCubit() : super(InitAllListState());

  final crud = EmployeeCrud();

  Future fetch() async {
    final response = await crud.getAllEmployees();
    print(response);
    if (response.isEmpty)
      emit(IsEmptyState());
    else if (response.isNotEmpty)
      emit(IsNotEmptyState());
    else
      emit(IsEmptyState());
  }
}
