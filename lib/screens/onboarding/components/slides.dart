import 'package:Bankify/models/slides.dart';
import 'package:Bankify/screens/auth/login/login.dart';
import 'package:Bankify/screens/onboarding/components/slides_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'animated_bar.dart';

class OnBoardingBody extends StatefulWidget {
  final List<Slides> slides;

  const OnBoardingBody({@required this.slides});

  @override
  _OnBoardingBodyState createState() => _OnBoardingBodyState();
}

class _OnBoardingBodyState extends State<OnBoardingBody>
    with SingleTickerProviderStateMixin {
  PageController _controller;
  AnimationController _animController;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _animController = AnimationController(vsync: this);

    // Inital launch
    final Slides initalSlide = widget.slides.first;
    nextSlide(slide: initalSlide, animate: false);

    // Status listener for incrementing current index by 1
    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animController.stop();
        _animController.reset();
        setState(() {
          if (_index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          }
          if (_index + 1 < widget.slides.length) {
            _index += 1;
            nextSlide(slide: widget.slides[_index]);
          } else {
            _index = 0;
            nextSlide(slide: widget.slides[_index]);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Slides slides = widget.slides[_index];

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTapDown: (tapInfo) => slidePressed(tapInfo, slides),
        child: Stack(
          children: <Widget>[
            PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: _controller,
              itemCount: widget.slides.length,
              itemBuilder: (context, i) {
                final Slides slide = widget.slides[i];

                return Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: slide.url,
                      fit: BoxFit.cover,
                    ),
                    SlidesInfo(
                      slide: slides,
                      index: _index,
                    )
                  ],
                );
              },
            ),
            Positioned(
              top: 50,
              left: 10,
              right: 10,
              child: Column(
                children: <Widget>[
                  Row(
                    children: widget.slides
                        .asMap()
                        .map((i, e) {
                          return MapEntry(
                            i,
                            SlidesBar(
                              animController: _animController,
                              position: i,
                              index: _index,
                            ),
                          );
                        })
                        .values
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Handle slide pressed
  void slidePressed(TapDownDetails tapInfo, Slides slides) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double xPos = tapInfo.globalPosition.dx;

    if (xPos < screenWidth / 3) {
      setState(() {
        if (_index - 1 >= 0) {
          _index -= 1;
          nextSlide(slide: widget.slides[_index]);
        }
      });
    } else if (xPos > 2 * screenWidth / 3) {
      setState(() {
        if (_index + 1 < widget.slides.length) {
          _index += 1;
          nextSlide(slide: widget.slides[_index]);
        }
      });
    } else {
      _index = 0;
      nextSlide(slide: widget.slides[_index]);
    }
  }

  void nextSlide({Slides slide, bool animate = true}) {
    _animController.stop();
    _animController.reset();
    _animController.duration = slide.duration;
    _animController.forward();

    if (animate) {
      _controller.animateToPage(
        _index,
        duration: const Duration(microseconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }
}
