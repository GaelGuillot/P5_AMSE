 
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: const Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                  child: AboutContent(),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class AboutContent extends StatelessWidget {
  const AboutContent({super.key});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      ...[
        Text('About', style: Theme.of(context).textTheme.headlineMedium),
        const TextField(
          maxLines: 3,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: "This app was made by Gaël Guillot, using the \"navigation_and_routing\" sample app from the flutter github page as a base.",
            border: InputBorder.none,
          ),
        ),
        const Text('IMT Nord Europe, AMSE'),
        Link(
          uri: Uri.parse('https://github.com/GaelGuillot/P5_AMSE/tree/main/TPFlutter/tp1_music_database'),
          target: LinkTarget.blank,
          builder:
              (context, followLink) => TextButton(
                onPressed: followLink,
                child: const Text('GitHub page'),
              ),
        ),
        
      ].map((w) => Padding(padding: const EdgeInsets.all(8), child: w)),
      
    ],
  );
}
