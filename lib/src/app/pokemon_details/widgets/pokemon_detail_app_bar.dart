import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PokemonDetailSliverAppBar extends StatelessWidget {
  final Color appBarColor;
  final double collapedHight;
  final double expandedHeight;
  final bool floating;
  final Image pokemonPhoto;

  const PokemonDetailSliverAppBar({
    Key key,
    this.appBarColor,
    this.collapedHight,
    this.expandedHeight,
    this.floating = false,
    this.pokemonPhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: PokemonDetailSliverAppBarDelegate(
        expandedHeight: expandedHeight,
        collapedHight: collapedHight,
        appBarColor: appBarColor,
        pokemonPhoto: pokemonPhoto,
        floating: floating,
      ),
    );
  }
}

class PokemonDetailSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Color appBarColor;
  final double collapedHight;
  final double expandedHeight;
  final bool floating;
  final Image pokemonPhoto;

  PokemonDetailSliverAppBarDelegate({
    this.appBarColor,
    this.collapedHight,
    this.expandedHeight,
    this.floating,
    this.pokemonPhoto,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final currentExtent = math.max(minExtent, maxExtent - shrinkOffset);
    final sliverOffset = (currentExtent - shrinkOffset).round();
    final pokemonOpacity =
        sliverOffset > 0 ? sliverOffset / currentExtent.round() : 0.0;

    final appBar = FlexibleSpaceBar.createSettings(
      minExtent: minExtent,
      maxExtent: maxExtent,
      currentExtent: currentExtent,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AppBar(
            backgroundColor: appBarColor ?? Theme.of(context).primaryColor,
          ),
          Positioned(
            child: Opacity(
              opacity: pokemonOpacity,
              child: pokemonPhoto,
            ),
          )
        ],
      ),
    );

    return floating ? _FloatingAppBar(child: appBar) : appBar;
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => collapedHight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate != this;
  }
}

class _FloatingAppBar extends StatefulWidget {
  const _FloatingAppBar({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  _FloatingAppBarState createState() => _FloatingAppBarState();
}

// A wrapper for the widget created by _SliverAppBarDelegate that starts and
// stops the floating app bar's snap-into-view or snap-out-of-view animation.
class _FloatingAppBarState extends State<_FloatingAppBar> {
  ScrollPosition _position;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_position != null)
      _position.isScrollingNotifier.removeListener(_isScrollingListener);
    _position = Scrollable.of(context)?.position;
    if (_position != null)
      _position.isScrollingNotifier.addListener(_isScrollingListener);
  }

  @override
  void dispose() {
    if (_position != null)
      _position.isScrollingNotifier.removeListener(_isScrollingListener);
    super.dispose();
  }

  RenderSliverFloatingPersistentHeader _headerRenderer() {
    return context
        .findAncestorRenderObjectOfType<RenderSliverFloatingPersistentHeader>();
  }

  void _isScrollingListener() {
    if (_position == null) return;

    // When a scroll stops, then maybe snap the appbar into view.
    // Similarly, when a scroll starts, then maybe stop the snap animation.
    final RenderSliverFloatingPersistentHeader header = _headerRenderer();
    if (_position.isScrollingNotifier.value)
      header?.maybeStopSnapAnimation(_position.userScrollDirection);
    else
      header?.maybeStartSnapAnimation(_position.userScrollDirection);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
