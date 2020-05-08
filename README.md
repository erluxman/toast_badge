# Toast Like Message Badge Widget

[![Pub](https://img.shields.io/pub/v/toast_badge.svg)](https://pub.dev/packages/toast_badge)


![](arts/toast_badge.gif)


## What does it do?

With toast_badge we can simply call 

    ToastBadge.show("Hello world");
From anywhere in the app and it will show Toast like shown in the Image Above.

While also being able to place it right in the place where you want it.

## How to use it?

1. Add **toast_badge** to **pubspec.yml**
   
   `toast_badge: ^0.1`


2. Import Toast Wiget
    `import 'package:toast_badge/toast_badge.dart';`

3. Now wrap your widget inside Toast Widget
   
   a. Just Wrap any Widget with **ToastWidget()** like this 

        child: ToastBadge(
            child: SettingPage(),
        ),

    b. You can also use the extension method `.enableBadge()` on any Widget:

        child: SettingPage().enableBadge(),


4. Finally, call `ToastBadge.show()` from anywhere in the app.
    
    a.  Just Show Text :

        ToastBadge.show("Hello Toast");
    
    b. Show Toast with additional setting: 

        ToastBadge.show(
        "Hello Toast",
        mode: ToastMode.INFO,
        duration: Duration(milliseconds: 500)
        );


Parameter info : 

### Mode

    mode:

    // ToastMode.INF0 - Green Background
    // ToastMode.DEBUG - Blue Background
    // ToastMode.ERROR - Red Background



### Duration
    duration:

    // Give Duration for how long do you want the toast to show and disappear itself.

    // User can also click the 'X' icon on the Toast to close.
