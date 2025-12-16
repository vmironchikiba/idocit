import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/features/document/domain/bloc/document_bloc.dart';
import 'package:idocit/features/document/domain/usecases/get_document_by_id.dart';
import 'package:idocit/features/document/models/enums/doc_type.dart';
import 'package:idocit/idocit/lib/api.dart';
import 'package:idocit/injection_container.dart';

class DocumentScreen extends StatefulWidget {
  static const routeName = '/document';
  final String documentId;

  const DocumentScreen({super.key, required this.documentId});

  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  @override
  initState() {
    super.initState();
    locator<GetDocumentById>().call(GetDocumentPayload(documentId: widget.documentId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      builder: (context, state) {
        final html = state.documentResponse?.document.properties.html ?? '';
        final text = state.documentResponse?.document.properties.text ?? '';
        final docType = (state.documentResponse?.document.properties.docType ?? '').toDocType();

        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(title: SvgPicture.asset(ImageConstants.igIdocIt, height: 56, width: 56)),
          body: docType != DocType.md
              ? LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: constraints.maxWidth),
                        child: docType == DocType.web ? Html(data: html) : Text(text),
                      ),
                    );
                  },
                )
              : Markdown(data: text, selectable: true),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
