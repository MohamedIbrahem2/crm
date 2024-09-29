// // assigned_users_state.dart
//
// part of 'assigned_users_cubit.dart';
//
//
//
// abstract class AssignedUsersState extends Equatable {
//   const AssignedUsersState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class AssignedUsersInitial extends AssignedUsersState {}
//
// class AssignedUsersLoading extends AssignedUsersState {}
//
// class AssignedUsersLoaded extends AssignedUsersState {
//   final List<int> assignedUsers; // Ensure this is defined
//
//   const AssignedUsersLoaded(this.assignedUsers); // Update constructor
//
//   @override
//   List<Object> get props => [assignedUsers];
// }
//
// class AssignedUsersError extends AssignedUsersState {
//   final String message;
//
//   const AssignedUsersError(this.message);
//
//   @override
//   List<Object> get props => [message];
// }
