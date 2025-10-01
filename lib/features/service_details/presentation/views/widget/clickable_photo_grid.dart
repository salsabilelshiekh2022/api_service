import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// شاشة عرض الصور بشكل كامل
class PhotoViewerScreen extends StatefulWidget {
  const PhotoViewerScreen({
    super.key,
    required this.photos,
    this.initialIndex = 0,
    this.isFromNetwork = true,
  });

  final List<String> photos;
  final int initialIndex;
  final bool isFromNetwork;

  @override
  State<PhotoViewerScreen> createState() => _PhotoViewerScreenState();
}

class _PhotoViewerScreenState extends State<PhotoViewerScreen> {
  late PageController _pageController;
  late int _currentIndex;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);

    // إخفاء شريط الحالة للحصول على تجربة أفضل
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    _pageController.dispose();
    // إعادة إظهار شريط الحالة
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // عارض الصور
          PageView.builder(
            controller: _pageController,
            itemCount: widget.photos.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: _toggleVisibility,
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 3.0,
                  child: Center(
                    child: !widget.isFromNetwork
                        ? Image.file(
                            File(widget.photos[index]),
                            fit: BoxFit.contain,
                          )
                        : Image.network(
                            widget.photos[index],
                            fit: BoxFit.contain,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                  color: Colors.white,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: Colors.white,
                                      size: 64,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'فشل في تحميل الصورة',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ),
              );
            },
          ),

          // الشريط العلوي
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            top: _isVisible ? 0 : -100,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Spacer(),
                  Text(
                    '${_currentIndex + 1} من ${widget.photos.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.share, color: Colors.white),
                    onPressed: () {
                      // مشاركة الصورة
                      _sharePhoto();
                    },
                  ),
                ],
              ),
            ),
          ),

          // الشريط السفلي مع المؤشرات
          if (widget.photos.length > 1)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              bottom: _isVisible ? 0 : -100,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 16,
                  top: 16,
                  left: 16,
                  right: 16,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.photos.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _currentIndex == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _sharePhoto() {
    // يمكنك إضافة كود المشاركة هنا
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('مشاركة الصورة...'),
        backgroundColor: Colors.grey,
      ),
    );
  }
}

// شاشة عرض جميع الصور في شبكة
class PhotoGridScreen extends StatelessWidget {
  const PhotoGridScreen({
    super.key,
    required this.photos,
    this.isFromNetwork = true,
  });

  final List<String> photos;
  final bool isFromNetwork;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الصور (${photos.length})'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PhotoViewerScreen(
                      photos: photos,
                      initialIndex: index,
                      isFromNetwork: isFromNetwork),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: isFromNetwork
                  ? Image.network(
                      photos[index],
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.error_outline,
                            color: Colors.grey,
                          ),
                        );
                      },
                    )
                  : Image.file(
                      File(photos[index]),
                      fit: BoxFit.cover,
                    ),
            ),
          );
        },
      ),
    );
  }
}

// تطبيق الكود في الـ Photo Grid الخاص بك
class ClickablePhotoGrid extends StatelessWidget {
  const ClickablePhotoGrid({
    super.key,
    required this.photos,
    this.spacing = 8.0,
    this.borderRadius = 12.0,
    this.height = 200.0,
  });

  final List<String> photos;
  final double spacing;
  final double borderRadius;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (photos.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      height: height,
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // الصورة الكبيرة على اليسار
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PhotoViewerScreen(
                      photos: photos,
                      initialIndex: 0,
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Image.network(
                  photos[0],
                  fit: BoxFit.cover,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child:
                          const Icon(Icons.image, size: 50, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
          ),

          SizedBox(width: spacing),

          // العمود الأيمن
          Expanded(
            flex: 1,
            child: Column(
              children: [
                // الصورة العلوية
                Expanded(
                  child: GestureDetector(
                    onTap: photos.length > 1
                        ? () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PhotoViewerScreen(
                                  photos: photos,
                                  initialIndex: 1,
                                ),
                              ),
                            );
                          }
                        : null,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(borderRadius),
                      child: photos.length > 1
                          ? Image.network(
                              photos[1],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.image,
                                      size: 30, color: Colors.grey),
                                );
                              },
                            )
                          : Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.add_photo_alternate,
                                  size: 30, color: Colors.grey),
                            ),
                    ),
                  ),
                ),

                SizedBox(height: spacing),

                // الصورة السفلية
                Expanded(
                  child: GestureDetector(
                    onTap: photos.length > 2
                        ? () {
                            if (photos.length > 3) {
                              // فتح شاشة عرض جميع الصور
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PhotoGridScreen(photos: photos),
                                ),
                              );
                            } else {
                              // فتح الصورة الثالثة مباشرة
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PhotoViewerScreen(
                                    photos: photos,
                                    initialIndex: 2,
                                  ),
                                ),
                              );
                            }
                          }
                        : null,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(borderRadius),
                      child: photos.length > 2
                          ? Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  photos[2],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[300],
                                      child: const Icon(Icons.image,
                                          size: 30, color: Colors.grey),
                                    );
                                  },
                                ),
                                if (photos.length > 3)
                                  Container(
                                    color: Colors.black.withOpacity(0.6),
                                    child: Center(
                                      child: Text(
                                        '+${photos.length - 3}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            )
                          : Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.add_photo_alternate,
                                  size: 30, color: Colors.grey),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
