
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomTextInput extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final bool enabled;
  final int maxLines;

  final bool obscureText;
  final VoidCallback? onToggleVisibility;

  const CustomTextInput({
    super.key,
    required this.hintText,
    this.isPassword = false,
    required this.controller,
    this.maxLines = 1,
    this.enabled = true,
    required this.label,
    this.obscureText = false,
    this.onToggleVisibility,

  });

  @override
  Widget build(BuildContext context) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
          fontSize: 14,
          color: Colors.black,
          )
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          controller: controller,
          obscureText: isPassword ? obscureText : false,
          enabled: enabled,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey[400],
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: onToggleVisibility,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}