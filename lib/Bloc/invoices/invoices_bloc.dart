import 'package:bloc/bloc.dart';
import 'package:cab_zing/core/repo/invoices_repo.dart';
import 'package:meta/meta.dart';

part 'invoices_event.dart';
part 'invoices_state.dart';

class InvoicesBloc extends Bloc<InvoicesEvent, InvoicesState> {
  
  InvoicesBloc() : super(InvoicesInitial()) {
    on<GetInvoices>(getInvoicesList);
  }
  Future<void> getInvoicesList(
      GetInvoices event,
      Emitter<InvoicesState> emit,
    ) async {
      try {
        emit(InvoicesLoading());
        final result = await InvoicesRepo().getInvoices();
        if (result.isSuccess) {
          emit(InvoicesSuccess(result));
        } else {
          emit(InvoicesError('Invoices failed'));
        }
      } catch (e) {
        print('Error occured: $e');
        emit(InvoicesError(e.toString()));
      }
    }
}
