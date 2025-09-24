import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herbtrace_app/generated/app_localizations.dart';

class SupplyChainOverviewPage extends ConsumerStatefulWidget {
  const SupplyChainOverviewPage({super.key});

  @override
  ConsumerState<SupplyChainOverviewPage> createState() =>
      _SupplyChainOverviewPageState();
}

class _SupplyChainOverviewPageState
    extends ConsumerState<SupplyChainOverviewPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<double>(begin: -50.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SizedBox(height: 20),

          FadeTransition(
            opacity: _fadeAnimation,
            child: Text(
              localizations.supply_chain_journey,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
          ),

          const SizedBox(height: 16),

          FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                localizations.supply_chain_subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildSupplyChainStep(
                    icon: Icons.agriculture,
                    title: localizations.farmer_wild_collector,
                    subtitle: "Harvest & Collect",
                    color: Colors.green.shade400,
                    delay: 0,
                  ),
                  _buildArrow(),
                  _buildSupplyChainStep(
                    icon: Icons.local_shipping,
                    title: localizations.transporter,
                    subtitle: "Transport Safely",
                    color: Colors.blue.shade400,
                    delay: 200,
                  ),
                  _buildArrow(),
                  _buildSupplyChainStep(
                    icon: Icons.factory,
                    title: localizations.processor,
                    subtitle: "Process & Refine",
                    color: Colors.orange.shade400,
                    delay: 400,
                  ),
                  _buildArrow(),
                  _buildSupplyChainStep(
                    icon: Icons.science,
                    title: localizations.laboratory,
                    subtitle: "Quality Testing",
                    color: Colors.purple.shade400,
                    delay: 600,
                  ),
                  _buildArrow(),
                  _buildSupplyChainStep(
                    icon: Icons.precision_manufacturing,
                    title: localizations.manufacturer,
                    subtitle: "Create Products",
                    color: Colors.red.shade400,
                    delay: 800,
                  ),
                  _buildArrow(),
                  _buildSupplyChainStep(
                    icon: Icons.inventory_2,
                    title: localizations.packer,
                    subtitle: "Package & Ship",
                    color: Colors.teal.shade400,
                    delay: 1000,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupplyChainStep({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required int delay,
  }) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_slideAnimation.value, 0),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(icon, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildArrow() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white.withOpacity(0.8),
              size: 24,
            ),
          ),
        );
      },
    );
  }
}
