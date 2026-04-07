part of 'invoices_bloc.dart';

@immutable
sealed class InvoicesEvent {}

class GetInvoices extends InvoicesEvent {
  final int page;
  GetInvoices({this.page = 1});
}
