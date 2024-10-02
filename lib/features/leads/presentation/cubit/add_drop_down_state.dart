

import '../../data/models/add_drop_down_model.dart';

abstract class DropdownState {}

class DropdownInitial extends DropdownState {}

class DropdownLoading extends DropdownState {}

class DropdownLoaded extends DropdownState {
  final List<DropdownItem> dropdownItems;
  DropdownLoaded(this.dropdownItems);
}
class StatusDropdownLoaded extends DropdownState {
  final List<DropdownItem> dropdownItems;
  StatusDropdownLoaded(this.dropdownItems);
}
class SourceDropdownLoaded extends DropdownState {
  final List<DropdownItem> dropdownItems;
  SourceDropdownLoaded(this.dropdownItems);
}
class CountryDropdownLoaded extends DropdownState {
  final List<DropdownItem> dropdownItems;
  CountryDropdownLoaded(this.dropdownItems);
}
class ProductDropdownLoaded extends DropdownState {
  final List<DropdownItem> dropdownItems;
  ProductDropdownLoaded(this.dropdownItems);
}
class ProductTypeDropdownLoaded extends DropdownState {
  final List<DropdownItem> dropdownItems;
  ProductTypeDropdownLoaded(this.dropdownItems);
}
class AssignedDropdownLoaded extends DropdownState {
  final List<DropdownItem> dropdownItems;
  AssignedDropdownLoaded(this.dropdownItems);
}

class DropdownError extends DropdownState {
  final String error;
  DropdownError(this.error);
}
