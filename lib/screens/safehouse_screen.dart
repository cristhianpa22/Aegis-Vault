import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/safehouse.dart';

class SafehouseScreen extends StatelessWidget {
  final List<Safehouse> safehouses;

  const SafehouseScreen({super.key, required this.safehouses});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '< AEGIS SYSTEM />',
          style: GoogleFonts.orbitron(
            letterSpacing: 3.0,
            fontWeight: FontWeight.w900,
            color: theme.colorScheme.primary,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF05070B),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(
            color: theme.colorScheme.primary,
            height: 2,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.8,
          ),
          itemCount: safehouses.length,
          itemBuilder: (context, index) {
            return SafehouseCard(safehouse: safehouses[index]);
          },
        ),
      ),
    );
  }
}

class SafehouseCard extends StatelessWidget {
  final Safehouse safehouse;

  const SafehouseCard({super.key, required this.safehouse});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCompromised = safehouse.isCompromised;

    final cardColor = isCompromised 
        ? theme.colorScheme.errorContainer 
        : theme.cardColor;
        
    final accentColor = isCompromised 
        ? theme.colorScheme.error 
        : theme.colorScheme.primary;

    return Semantics(
      label: 'Refugio ${safehouse.codename}, ubicado en el sector ${safehouse.sector}, capacidad para ${safehouse.capacity} agentes',
      container: true,
      child: ExcludeSemantics(
        child: Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: accentColor,
              width: isCompromised ? 2.5 : 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: accentColor,
                blurRadius: isCompromised ? 12 : 6,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      isCompromised ? Icons.gpp_bad_outlined : Icons.gpp_good_outlined,
                      color: accentColor,
                      size: 22,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        safehouse.codename.toUpperCase(),
                        style: GoogleFonts.orbitron(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          letterSpacing: 1.0,
                          color: isCompromised ? theme.colorScheme.onErrorContainer : Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 1,
                  color: accentColor,
                ),
                const SizedBox(height: 10),
                
                Row(
                  children: [
                    Icon(Icons.layers_outlined, size: 14, color: theme.colorScheme.secondary),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'SEC: ${safehouse.sector}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                
                Row(
                  children: [
                    Icon(Icons.hourglass_empty, size: 14, color: theme.colorScheme.secondary),
                    const SizedBox(width: 6),
                    Text(
                      'CAP: ${safehouse.capacity} AGTS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.g_mobiledata, size: 14, color: Colors.white),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'LOC: ${safehouse.latitude}, ${safehouse.longitude}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const Spacer(),

                Center(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: isCompromised ? theme.colorScheme.error : theme.colorScheme.secondary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      isCompromised ? 'BREACH / COMPROMISED' : 'STATUS: SECURE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: isCompromised ? Colors.white : theme.colorScheme.primary,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}