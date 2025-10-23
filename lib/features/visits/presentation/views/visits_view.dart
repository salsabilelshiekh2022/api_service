import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/features/visits/data/repos/visits_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../cubit/visits_cubit.dart';

import '../../../../core/components/widgets/should_login_widget.dart';
import '../../../../core/utils/user_cache_service.dart';
import '../../../reports/presentation/views/widgets/header_with_search_and_filter.dart'
    show HeaderWithSearchAndFilter;
import 'widgets/visits_list.dart';
import 'dart:async';

class VisitsView extends StatefulWidget {
  const VisitsView({super.key});

  @override
  State<VisitsView> createState() => _VisitsViewState();
}

class _VisitsViewState extends State<VisitsView> {
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
      context.read<VisitsCubit>().fetchVisits(search: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VisitsCubit(getIt<VisitsRepo>()),
      child: Scaffold(
        body: Column(
          children: [
            HeaderWithSearchAndFilter(
              isFromReports: false,
              title: context.visits,
              onSearchChanged: (value) => _onSearchChanged(context, value),
            ),
            16.verticalSizedBox,
            UserCacheService().currentUser == null
                ? const ShouldLoginWidget()
                : Expanded(child: VisitsList(search: _searchValue)),
          ],
        ),
      ),
    );
  }
}
