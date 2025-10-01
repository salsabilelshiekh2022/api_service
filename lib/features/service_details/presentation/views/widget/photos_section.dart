import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/service_details_cubit.dart';
import 'clickable_photo_grid.dart';

class PhotosSection extends StatelessWidget {
  const PhotosSection({super.key});

  @override
  Widget build(BuildContext context) {
    final photos = [
      "https://i.pinimg.com/736x/88/55/8c/88558c1c940a62e387ed13712834357b.jpg",
      'https://i.pinimg.com/736x/d6/00/ac/d600ac12c472970ce9761ab976634cf1.jpg',
      'https://i.pinimg.com/736x/c0/0c/78/c00c78a21a728f47646c813f207996a2.jpg',
    ];
    return BlocBuilder<ServiceDetailsCubit, ServiceDetailsState>(
      builder: (context, state) {
        bool isLoading = state.status == ServiceDetailsStateStatus.loading;
        return ClickablePhotoGrid(
          photos: isLoading
              ? photos
              : state.serviceDetailsResponse!.data.images
                  .map((x) => x.filePath)
                  .toList(),
        );
      },
    );
  }
}
