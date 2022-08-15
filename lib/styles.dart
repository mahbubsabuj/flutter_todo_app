import 'package:flutter/material.dart';

const InputDecoration searchFieldDecoration = InputDecoration(
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.blue),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.blue,
    ),
  ),
  prefixIcon: Icon(
    Icons.search,
    color: Colors.blue,
  ),
  hintText: "Search todo",
  hintStyle: TextStyle(
    color: Colors.blue,
  ),
);

const TextStyle todoTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  overflow: TextOverflow.ellipsis,
);
