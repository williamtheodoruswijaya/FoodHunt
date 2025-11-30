import 'package:flutter/material.dart';
import 'package:client/features/restaurant/data/restaurant_model.dart';

class RestaurantSwipePage extends StatefulWidget {
  final List<RestaurantModel> allRestaurants;
  final int initialIndex;

  const RestaurantSwipePage({
    super.key,
    required this.allRestaurants,
    this.initialIndex = 0,
  });

  @override
  State<RestaurantSwipePage> createState() => _RestaurantSwipePageState();
}

class _RestaurantSwipePageState extends State<RestaurantSwipePage>
    with SingleTickerProviderStateMixin {
  bool expanded = false;
  int currentIndex = 0;
  double dragOffset = 0;
  double animationOffset = 0;
  bool isAnimating = false;
  String swipeDirection = "left";

  late AnimationController _controller;
  late Animation<double> _animation;

  final List<_FloatingIcon> floatingIcons = [];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _spawnFloatingIcon(String type) {
    final icon = _FloatingIcon(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: type,
    );
    setState(() => floatingIcons.add(icon));

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() => floatingIcons.removeWhere((e) => e.id == icon.id));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final restaurant = widget.allRestaurants[currentIndex];
    final screenHeight = MediaQuery.of(context).size.height;

    final total = widget.allRestaurants.length;
    final nextIndex =
        swipeDirection == "left"
            ? (currentIndex + 1) % total
            : (currentIndex - 1 + total) % total;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (isAnimating) return;
          setState(() {
            dragOffset += details.delta.dx;
            swipeDirection = dragOffset < 0 ? "left" : "right";
          });
        },
        onHorizontalDragEnd: (details) => _handleSwipe(details),
        child: Stack(
          children: [
            // background image
            Positioned.fill(
              child: Image.network(
                widget.allRestaurants[nextIndex].imageUrl ??
                    "https://via.placeholder.com/600",
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),

            // main image with swipe translate
            Transform.translate(
              offset: Offset(dragOffset + animationOffset, 0),
              child: Image.network(
                restaurant.imageUrl ??
                    "https://via.placeholder.com/600?text=No+Image",
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                height: expanded ? screenHeight * 0.75 : screenHeight * 0.9,
                width: double.infinity,
              ),
            ),

            // floating heart/dislike effect
            ...floatingIcons.map(
              (icon) => _FloatingIconWidget(type: icon.type),
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),

            // bottom expandable card
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                height: expanded ? screenHeight * 0.62 : screenHeight * 0.22,
                width: double.infinity,
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurant.name,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              restaurant.description,
                              style: TextStyle(
                                color: Colors.grey[700],
                                height: 1.4,
                                fontSize: 13.5,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // expand animation
                            AnimatedCrossFade(
                              duration: const Duration(milliseconds: 250),
                              crossFadeState:
                                  expanded
                                      ? CrossFadeState.showSecond
                                      : CrossFadeState.showFirst,
                              firstChild: const SizedBox.shrink(),
                              secondChild: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _infoRow(restaurant),
                                  const SizedBox(height: 10),

                                  // location
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.redAccent,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          restaurant.address,
                                          style: const TextStyle(
                                            fontSize: 13.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // expand button
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () => setState(() => expanded = !expanded),
                          icon: Icon(
                            expanded
                                ? Icons.keyboard_arrow_down_rounded
                                : Icons.keyboard_arrow_up_rounded,
                            color: Colors.pinkAccent,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(RestaurantModel r) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(50),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 18),
        const SizedBox(width: 4),
        Text("-", style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(width: 12),
        const Icon(Icons.attach_money, color: Colors.black87, size: 18),
        Text(
          r.price != null ? "\$" * r.price! : "-",
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );

  void _handleSwipe(DragEndDetails details) {
    const threshold = 120.0;

    if (dragOffset.abs() > threshold) {
      final direction = dragOffset > 0 ? "right" : "left";
      _spawnFloatingIcon(direction == "right" ? "heart" : "dislike");

      isAnimating = true;
      final target = direction == "left" ? -400.0 : 400.0;

      _animation = Tween<double>(
        begin: dragOffset,
        end: target,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

      _controller.forward(from: 0).then((_) {
        setState(() {
          currentIndex =
              direction == "left"
                  ? (currentIndex + 1) % widget.allRestaurants.length
                  : (currentIndex - 1 + widget.allRestaurants.length) %
                      widget.allRestaurants.length;

          dragOffset = 0;
          animationOffset = 0;
          isAnimating = false;
        });
      });

      _animation.addListener(() {
        setState(() => animationOffset = _animation.value);
      });
    } else {
      setState(() => dragOffset = 0);
    }
  }
}

class _FloatingIcon {
  final String id;
  final String type;
  _FloatingIcon({required this.id, required this.type});
}

class _FloatingIconWidget extends StatefulWidget {
  final String type;
  const _FloatingIconWidget({required this.type});

  @override
  State<_FloatingIconWidget> createState() => _FloatingIconWidgetState();
}

class _FloatingIconWidgetState extends State<_FloatingIconWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _translateY;
  late double randomX;

  @override
  void initState() {
    super.initState();

    randomX = ([-80, 0, 80]..shuffle()).first.toDouble();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    _opacity = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _translateY = Tween<double>(
      begin: 0,
      end: -180,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.translate(
            offset: Offset(randomX, _translateY.value),
            child: Center(
              child: Image.asset(
                widget.type == 'heart'
                    ? 'assets/icons/heart.png'
                    : 'assets/icons/dislike.png',
                width: 90,
                height: 90,
                color:
                    widget.type == 'heart'
                        ? Colors.pinkAccent.withOpacity(0.9)
                        : Colors.redAccent.withOpacity(0.9),
              ),
            ),
          ),
        );
      },
    );
  }
}
