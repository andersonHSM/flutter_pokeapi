import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_pokeapi/src/models/pokemon.dart';

class PokemonDetailSliverAppBar extends StatelessWidget {
  final Color appBarColor;
  final double collapsedHeight;
  final double expandedHeight;
  final bool floating;
  final Pokemon pokemon;

  const PokemonDetailSliverAppBar({
    Key key,
    this.appBarColor,
    this.collapsedHeight,
    this.expandedHeight,
    this.floating = false,
    this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: floating,
      delegate: PokemonDetailSliverAppBarDelegate(
        expandedHeight: expandedHeight,
        collapsedHeight: collapsedHeight,
        appBarColor: appBarColor,
        floating: floating,
        pokemon: pokemon,
      ),
    );
  }
}

class PokemonDetailSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Color appBarColor;
  final double collapsedHeight;
  final double expandedHeight;
  final bool floating;
  final Pokemon pokemon;

  PokemonDetailSliverAppBarDelegate({
    this.appBarColor,
    this.collapsedHeight,
    this.expandedHeight,
    this.floating,
    this.pokemon,
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
        alignment: Alignment.bottomCenter,
        children: [
          AppBar(
            elevation: 0,
            backgroundColor: appBarColor ?? Theme.of(context).primaryColor,
            title: Text(pokemon.name),
          ),
          Positioned(
            bottom: 00,
            child: Opacity(
                opacity: pokemonOpacity,
                child: _PokemonPhoto(pokemon: pokemon)),
          )
        ],
      ),
    );

    return floating ? _FloatingAppBar(child: appBar) : appBar;
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => collapsedHeight;

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

    final RenderSliverFloatingPersistentHeader header = _headerRenderer();

    if (_position.isScrollingNotifier.value)
      header?.maybeStopSnapAnimation(_position.userScrollDirection);
    else
      header?.maybeStartSnapAnimation(_position.userScrollDirection);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _PokemonPhoto extends StatelessWidget {
  const _PokemonPhoto({
    Key key,
    @required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      pokemon.img,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }

        return CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes
              : null,
        );
      },
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        return AnimatedOpacity(
          child: child,
          opacity: frame == null ? 0 : 1,
          duration: const Duration(seconds: 1),
          curve: Curves.easeOut,
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          'lib/assets/pokeball-transparent.png',
          scale: 4,
        );
      },
    );
  }
}
