import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/components/widgets/empty_widget.dart';
import '../../../data/models/tickets_model.dart';
import '../../cubit/tech_support_cubit.dart';
import '../../cubit/tech_support_state.dart';
import 'ticket_item.dart';

class TicketsList extends StatefulWidget {
  const TicketsList({super.key});

  @override
  State<TicketsList> createState() => _TicketsListState();
}

class _TicketsListState extends State<TicketsList> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    context.read<TechSupportCubit>().getTicketsList();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<TechSupportCubit>().loadMoreTickets();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9); // Trigger at 90% scroll
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TechSupportCubit, TechSupportState>(
      builder: (context, state) {
        bool isInitialLoading =
            state.isGetTicketsListLoading && state.ticketsList.isEmpty;
        if (state.isGetTicketsListSuccess && state.ticketsList.isEmpty) {
          return EmptyWidget(
            imagePath: AppAssets.imagesEmptyImage,
            title: context.noComplaint,
            description: context.noComplaint,
          );
        }

        return RefreshIndicator(
          onRefresh: () => context.read<TechSupportCubit>().refreshTickets(),
          child: ListView.separated(
            controller: _scrollController,
            padding: EdgeInsets.only(bottom: 16.h),
            itemBuilder: (_, index) {
              if (isInitialLoading) {
                return Skeletonizer(
                  enabled: true,
                  child: TicketItem(ticket: dummyTicket),
                );
              }

              // Show actual ticket items
              if (index < state.ticketsList.length) {
                return TicketItem(ticket: state.ticketsList[index]);
              }

              // Show loading indicator at bottom when loading more
              if (state.isGetTicketsListLoadingMore) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return const SizedBox.shrink();
            },
            separatorBuilder: (_, index) {
              return 12.verticalSpace;
            },
            itemCount: isInitialLoading
                ? 3
                : state.ticketsList.length +
                    (state.isGetTicketsListLoadingMore || state.hasReachedMax
                        ? 1
                        : 0),
          ),
        );
      },
    );
  }
}
