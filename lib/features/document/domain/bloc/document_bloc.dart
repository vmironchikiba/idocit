import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/utils/date_time.dart';
import 'package:idocit/idocit/lib/api.dart';

part 'document_events.dart';
part 'document_state.dart';

class DocumentBloc extends Bloc<DocumentBlocEvent, DocumentState> {
  DocumentBloc(super.initialState) {
    on<SetSelectedDateEvent>((event, emit) => emit(state.update(selectedDate: event.date)));

    on<SetIsInProcess>((event, emit) => emit(state.update(isInProcess: event.isInProcess)));

    on<SetDocumentResponseEvent>((event, emit) {
      LoggerService.logDebug('ChatBloc SetSuggestionsResponseEvent ${event.documentResponse.toString().trimLines()}');
      emit(state.update(documentResponse: event.documentResponse));
    });

    on<SignOutIdocItEvent>((event, emit) {
      emit(DocumentState.initial());
    });
  }

  @override
  void onEvent(DocumentBlocEvent event) {
    super.onEvent(event);
    LoggerService.logDebug('IdocItBloc -> onEvent(): ${event.runtimeType}');
  }
}

extension StringTrimmed on String {
  String trimLines({int firstCount = 10, int lastCount = 10, String separator = '\n...........................\n'}) {
    // Разделяем текст на строки
    List<String> lines = split('\n');
    int total = lines.length;

    // Если строк меньше или равно сумме первых и последних, возвращаем всё
    if (total <= firstCount + lastCount) {
      return this;
    }

    // Берём первые firstCount строк
    List<String> firstLines = lines.take(firstCount).toList();
    // Берём последние lastCount строк
    List<String> lastLines = lines.skip(total - lastCount).toList();

    // Склеиваем с разделителем
    return '${firstLines.join('\n')}$separator${lastLines.join('\n')}';
  }
}
