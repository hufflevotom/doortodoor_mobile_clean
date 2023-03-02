part of 'folios_bloc.dart';

abstract class FoliosState extends Equatable {
  const FoliosState();

  @override
  List<Object> get props => [];
}

class FoliosInitial extends FoliosState {}

class FoliosLoading extends FoliosState {}

class FoliosError extends FoliosState {
  const FoliosError(this.message);
  final String message;
}
