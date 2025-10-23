import 'dart:async';

import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/features/reports/data/repos/reports_repo.dart';
import 'package:elmohtaref/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:elmohtaref/features/reports/presentation/views/widgets/reports_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/widgets/should_login_widget.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/utils/user_cache_service.dart';
import 'widgets/header_with_search_and_filter.dart';

class ReportsView extends StatefulWidget {
  const ReportsView({super.key});

  @override
  State<ReportsView> createState() => _ReportsViewState();
}

class _ReportsViewState extends State<ReportsView> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String _searchValue = '';

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(BuildContext context, String value) {
    setState(() {
      _searchValue = value;
    });
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      context.read<ReportsCubit>().fetchReports(search: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportsCubit(
        getIt<ReportsRepo>(),
      ),
      child: Scaffold(
        body: Column(
          children: [
            HeaderWithSearchAndFilter(
              title: context.reports,
              isFromReports: true,
              onSearchChanged: (value) => _onSearchChanged(context, value),
            ),
            16.verticalSizedBox,
            UserCacheService().currentUser == null
                ? const ShouldLoginWidget()
                : Expanded(child: ReportsList(search: _searchValue)),
          ],
        ),
      ),
    );
  }
}
