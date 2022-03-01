<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

A beautiful SnackBar.

## Features

<img src="https://github.com/crayonxiaoxin/lx_tips/blob/main/example/assets/demo.gif" width="50%">

## Usage

```dart
Tips.of(context).show(content: "Normal String Tips.");
```

```dart
Tips.of(context).show(
    color: Colors.pink.withOpacity(0.5),
    content: Row(
      children: const [
        Icon(Icons.face, color: Colors.white),
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text("Custom Tips.",
            style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white)),
        )
      ],
    ));
```

