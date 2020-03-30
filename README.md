# react-native-pure-dimension

This is a module which help you get screen dimension info.

## Installation

```
npm i react-native-pure-dimension
// link below 0.60
react-native link react-native-pure-dimension
```

## Setup

### iOS

modify `AppDelegate.m`

```oc
#import <RNTDimension.h>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  ...
  // add this line
  [RNTDimension bind:rootView];
  return YES;
}
```

### Android

nothing to do.

## Usage

```js
import dimension, {
  STATUS_BAR_HEIGHT,
  NAVIGATION_BAR_HEIGHT,
  SCREEN_WIDTH,
  SCREEN_HEIGHT,
  SAFE_AREA_TOP,
  SAFE_AREA_BOTTOM,
  SAFE_AREA_LEFT,
  SAFE_AREA_RIGHT,
} from 'react-native-pure-dimension'

// If the size stays the same(such as you don't rotate your phone), you can use the constants.
// Otherwise, you should get the latest size by the methods below.

dimension.getStatusBarHeight().then(data => {
  data.height
})

dimension.getNavigationBarHeight().then(data => {
  data.height
})

dimension.getScreenSize().then(data => {
  data.width
  data.height
})

dimension.getSafeArea().then(data => {
  data.top
  data.right
  data.bottom
  data.left
})
```