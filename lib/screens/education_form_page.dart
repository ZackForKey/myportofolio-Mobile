import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myportofolio_mobile/palette.dart';
import 'package:myportofolio_mobile/widgets/portfolio_drawer.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _programController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  static const List<String> _degreeOptions = [
    'Diploma',
    "Bachelor's degree",
    "Master's degree",
    'Doctoral degree',
    'Other',
  ];

  String? _degree;

  @override
  void dispose() {
    _institutionController.dispose();
    _programController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const PortfolioDrawer(currentPage: PortfolioPage.education),
      appBar: AppBar(title: const Text('Add Education')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [PiratePalette.softPaper, PiratePalette.parchment],
          ),
        ),
        child: SafeArea(
          top: false,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final horizontalPadding = constraints.maxWidth < 400
                  ? 16.0
                  : 24.0;

              return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  20,
                  horizontalPadding,
                  32,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 640),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildIntroCard(),
                          const SizedBox(height: 22),
                          const Text(
                            'Education Details',
                            style: TextStyle(
                              color: PiratePalette.deepNavy,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _institutionController,
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,
                            maxLength: 80,
                            decoration: _fieldDecoration(
                              label: 'Institution',
                              hint: 'e.g. Universitas Indonesia',
                              icon: Icons.account_balance_outlined,
                            ),
                            validator: (value) => _requiredText(
                              value,
                              fieldName: 'Institution',
                              maxLength: 80,
                            ),
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _programController,
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,
                            maxLength: 80,
                            decoration: _fieldDecoration(
                              label: 'Program or major',
                              hint: 'e.g. Computer Science',
                              icon: Icons.menu_book_outlined,
                            ),
                            validator: (value) => _requiredText(
                              value,
                              fieldName: 'Program or major',
                              maxLength: 80,
                            ),
                          ),
                          const SizedBox(height: 14),
                          DropdownButtonFormField<String>(
                            initialValue: _degree,
                            isExpanded: true,
                            decoration: _fieldDecoration(
                              label: 'Degree level',
                              hint: 'Choose a degree level',
                              icon: Icons.workspace_premium_outlined,
                            ),
                            items: _degreeOptions
                                .map(
                                  (degree) => DropdownMenuItem<String>(
                                    value: degree,
                                    child: Text(degree),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() => _degree = value);
                            },
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please choose a degree level.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _yearController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                            decoration: _fieldDecoration(
                              label: 'Graduation year',
                              hint: 'e.g. 2027',
                              icon: Icons.event_available_outlined,
                            ),
                            validator: _validateGraduationYear,
                          ),
                          const SizedBox(height: 22),
                          SizedBox(
                            height: 54,
                            child: FilledButton.icon(
                              onPressed: _saveEducation,
                              icon: const Icon(Icons.save_outlined),
                              label: const Text('Simpan'),
                              style: FilledButton.styleFrom(
                                backgroundColor: PiratePalette.deepNavy,
                                foregroundColor: Colors.white,
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildIntroCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: PiratePalette.deepNavy,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: PiratePalette.deepNavy.withValues(alpha: 0.14),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: const Row(
        children: [
          Icon(
            Icons.school_rounded,
            color: PiratePalette.treasureGold,
            size: 30,
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chart a learning voyage',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Add an education milestone to your journal.',
                  style: TextStyle(
                    color: PiratePalette.parchment,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _fieldDecoration({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    final outline = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: PiratePalette.treasureGold.withValues(alpha: 0.65),
      ),
    );

    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: PiratePalette.oceanBlue),
      filled: true,
      fillColor: PiratePalette.softPaper,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: outline,
      enabledBorder: outline,
      focusedBorder: outline.copyWith(
        borderSide: const BorderSide(color: PiratePalette.oceanBlue, width: 2),
      ),
      errorBorder: outline.copyWith(
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: outline.copyWith(
        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      ),
    );
  }

  String? _requiredText(
    String? value, {
    required String fieldName,
    required int maxLength,
  }) {
    final trimmedValue = value?.trim() ?? '';
    if (trimmedValue.isEmpty) {
      return '$fieldName is required.';
    }
    if (trimmedValue.length > maxLength) {
      return '$fieldName must be at most $maxLength characters.';
    }
    return null;
  }

  String? _validateGraduationYear(String? value) {
    final yearText = value?.trim() ?? '';
    if (yearText.isEmpty) {
      return 'Graduation year is required.';
    }
    if (yearText.length != 4) {
      return 'Enter the year using four digits.';
    }

    final year = int.tryParse(yearText);
    final latestAllowedYear = DateTime.now().year + 10;
    if (year == null || year < 1900 || year > latestAllowedYear) {
      return 'Enter a year between 1900 and $latestAllowedYear.';
    }
    return null;
  }

  void _saveEducation() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Education summary'),
          content: SingleChildScrollView(
            child: Text(
              'Institution: ${_institutionController.text.trim()}\n'
              'Program or major: ${_programController.text.trim()}\n'
              'Degree level: $_degree\n'
              'Graduation year: ${_yearController.text.trim()}',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }
}
