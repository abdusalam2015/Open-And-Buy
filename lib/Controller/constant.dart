import 'package:flutter/material.dart';
const ACCEPTED = 'Accepted';
const REJECTED = 'Rejected';
const CANCEL = 'Cancel';

const textInputDecoration = InputDecoration(
      fillColor: Colors.white,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white,width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.deepPurple,width: 2.0),
      ),
    );