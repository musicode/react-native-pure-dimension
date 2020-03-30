
#import <React/RCTRootView.h>

#import "RNTDimension.h"

UIView *appView;

CGFloat getStatusBarHeight() {
    return UIApplication.sharedApplication.statusBarFrame.size.height;
}

NSDictionary* getScreenSize() {

    CGRect bounds = UIScreen.mainScreen.bounds;
    
    return @{
      @"width": @(bounds.size.width),
      @"height": @(bounds.size.height),
    };

}

NSDictionary* getSafeArea() {

    if (appView != nil) {
        if (@available(iOS 11.0, *)) {
            return @{
                @"top": @(appView.safeAreaInsets.top),
                @"bottom": @(appView.safeAreaInsets.bottom),
                @"left": @(appView.safeAreaInsets.left),
                @"right": @(appView.safeAreaInsets.right)
            };
        }
    }
    
    return @{
        @"top": @(0),
        @"bottom": @(0),
        @"left": @(0),
        @"right": @(0)
    };

}


@implementation RNTDimension

+ (void)bind:(RCTRootView *)rootView {
    appView = rootView;
}

- (dispatch_queue_t)methodQueue {
  return dispatch_get_main_queue();
}

- (NSDictionary *)constantsToExport {
    NSDictionary *screenSize = getScreenSize();
    NSDictionary *safeArea = getSafeArea();
    return @{
         @"STATUS_BAR_HEIGHT": @(getStatusBarHeight()),
         @"NAVIGATION_BAR_HEIGHT": @(0),
         @"SCREEN_WIDTH": screenSize[@"width"],
         @"SCREEN_HEIGHT": screenSize[@"height"],
         @"SAFE_AREA_TOP": safeArea[@"top"],
         @"SAFE_AREA_BOTTOM": safeArea[@"bottom"],
         @"SAFE_AREA_LEFT": safeArea[@"left"],
         @"SAFE_AREA_RIGHT": safeArea[@"right"],
     };
}

RCT_EXPORT_MODULE(RNTDimension);

RCT_EXPORT_METHOD(getStatusBarHeight:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {

    resolve(@{
      @"height": @(getStatusBarHeight()),
    });
  
}

RCT_EXPORT_METHOD(getNavigationBarHeight:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
    
    resolve(@{
      @"height": @(0),
    });
  
}

RCT_EXPORT_METHOD(getScreenSize:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
    
    resolve(getScreenSize());
  
}

RCT_EXPORT_METHOD(getSafeArea:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {

    resolve(getSafeArea());
  
}

@end
