import 'package:flutter/material.dart';
import 'package:flutter_cv/features/cv/domain/entities/experience.dart';
import 'package:flutter_cv/features/cv/presentation/utils/link_utils.dart'
    show launchLink;
import 'package:flutter_cv/features/cv/presentation/widgets/cv_section_card.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class ExperienceSection extends StatefulWidget {
  final List<Experience> experience;

  const ExperienceSection({super.key, required this.experience});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.experience.length,
      vsync: this,
    );
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _scaleAnimation = Tween<double>(begin: 0.99, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _currentIndex = _tabController.index;
        });
        _animationController.forward(from: 0.0);
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CvSectionCard(
      title: 'Experience',
      child: LayoutBuilder(
        builder: (_, constraints) {
          return Column(
            children: [
              TabBar(
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                tabs:
                    widget.experience
                        .map((e) => Tab(text: '${e.yearFrom}–${e.yearTo}'))
                        .toList(),
              ),
              SizedBox(
                height:
                    constraints.maxWidth < 800
                        ? 300
                        : 200, // Adjust height as needed
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: IndexedStack(
                      index: _currentIndex,
                      children:
                          widget.experience
                              .map((e) => _ExperienceTabContent(experience: e))
                              .toList(),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ExperienceTabContent extends StatelessWidget {
  final Experience experience;

  const _ExperienceTabContent({required this.experience});

  @override
  Widget build(BuildContext context) {
    final descriptionLines = experience.description.split(r'\n');

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${experience.position} at ${experience.company}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (experience.reference.trim().isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Linkify(
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                linkStyle: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.blue[600]),
                text: 'Reference: ${experience.reference}',
                onOpen: launchLink,
              ),
            ),
          const SizedBox(height: 8),
          ...descriptionLines.map((line) {
            final textStyle = Theme.of(context).textTheme.bodyMedium;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• ', style: textStyle),
                  Expanded(
                    child: Linkify(
                      text: line.trim(),
                      style: textStyle,
                      linkStyle: textStyle?.copyWith(
                        color: Colors.blue[600],
                        decoration: TextDecoration.none,
                      ),
                      onOpen: launchLink,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
