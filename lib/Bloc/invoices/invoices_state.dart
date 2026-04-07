part of 'invoices_bloc.dart';

@immutable
sealed class InvoicesState {}

final class InvoicesInitial extends InvoicesState {}

final class InvoicesLoading extends InvoicesState {}

final class InvoicesSuccess extends InvoicesState {
  final dynamic data;
  InvoicesSuccess(this.data);
}

final class InvoicesError extends InvoicesState {
  final String message;
  InvoicesError(this.message);
}
