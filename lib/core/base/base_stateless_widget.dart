// ignore_for_file: must_be_immutable
import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injector/injection_container.dart';
import '../utils/dialogs.dart';
import '../utils/logs.dart';
import '../events/base_event.dart';
import './states/general_state.dart';

class BaseStatelessWidget<T extends Equatable, B extends Bloc<IBaseEvent, GeneralState<T>>> extends StatelessWidget {
  late BuildContext _buildContext;
  bool isLoading = false;

  BaseStatelessWidget({Key? key}) : super(key: key);

  BuildContext get context => _buildContext;

  Color get backgroundColor => Colors.transparent;

  bool get wrappingWithScaffold => true;

  bool get extendBodyBehindAppBar => false;

  @override
  StatelessElement createElement() {
    viewWillLoad();
    return super.createElement();
  }

  void viewWillLoad() {}

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: onCreate(context),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: _buildBaseView(context),
      ),
    );
  }

  Widget _buildBaseView(BuildContext context) {
    return BlocListener<B, GeneralState<T>>(
      listener: _onListener,
      child: BlocBuilder<B, GeneralState<T>>(builder: (c, s) {
        _buildContext = c;
        return _builder(c, s);
      }),
    );
  }

  Widget _builder(BuildContext c, GeneralState<T> s) {
    Widget widget = buildScreen(c, s);
    if (wrappingWithScaffold) {
      return Scaffold(
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        appBar: buildAppBar(c, s),
        backgroundColor: backgroundColor,
        body: widget,
      );
    }
    return widget;
  }

  /// To be overriden and called upon creation of inheriting widgets to provide
  /// corresponding Bloc to screen
  @mustCallSuper
  B onCreate(BuildContext context) {
    return sl<B>();
  }

  @protected
  Widget buildScreen(BuildContext context, GeneralState<T> state) {
    throw UnimplementedError();
  }

  @protected
  void _onListener(context, GeneralState<T> state) {
    printLog('[BaseState:$B] onListener $state');
    if (state.isLoading) {
      isLoading = true;
      onLoadingListener(state);
    } else if (state.isSuccess) {
      isLoading = false;
      onSuccessListener(state);
    } else if (state.isException) {
      isLoading = false;
      onExceptionListener(state);
    }
  }

  void onSuccessListener(GeneralState<T> state) {}

  void onLoadingListener(GeneralState<T> state) {}

  void onExceptionListener(GeneralState<T> exception) {
    if (exception.exception != null) {
      showErrorIconNotification(exception.exception!);
    }
  }

  void showErrorIconNotification(String message) => CustomDialog.showErrorIconNotification(
        context: _buildContext,
        title: message,
        ltr: true,
        asset: const Icon(
          Icons.error_outline,
          color: Colors.white,
          size: 32,
        ),
        enableSlideOff: true,
      );

  AppBar? buildAppBar(BuildContext context, GeneralState<T> s) => AppBar(
        backgroundColor: Colors.white,
      );

  void broadcastEvent(IBaseEvent event) {
    if (!isLoading) {
      BlocProvider.of<B>(_buildContext).add(
        event,
      );
    }
  }
}
