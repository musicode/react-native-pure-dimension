
#import <React/RCTRootView.h>

#import "RNTDimension.h"

static UIView *appView = nil;

@implementation RNTDimension

- (dispatch_queue_t)methodQueue {
  return dispatch_get_main_queue();
}

+ (void)bind:(RCTRootView *)rootView {
    appView = rootView;
}

RCT_EXPORT_MODULE(RNTDimension);

RCT_EXPORT_METHOD(getStatusBarHeight:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
    
    resolve(@{
      @"height": @(RCTSharedApplication().statusBarFrame.size.height),
    });
  
}

RCT_EXPORT_METHOD(getNavigationBarInfo:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
    
    resolve(@{
      @"height": @(0),
      @"visible": @(FALSE),
    });
  
}

RCT_EXPORT_METHOD(getScreenSize:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
    
    CGRect bounds = UIScreen.mainScreen.bounds;
    
    resolve(@{
      @"width": @(bounds.size.width),
      @"height": @(bounds.size.height),
    });
  
}

RCT_EXPORT_METHOD(getSafeArea:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
    
    if (appView != nil) {
        if (@available(iOS 11.0, *)) {
            resolve(@{
                @"top": @(appView.safeAreaInsets.top),
                @"bottom": @(appView.safeAreaInsets.bottom),
                @"left": @(appView.safeAreaInsets.left),
                @"right": @(appView.safeAreaInsets.right)
            });
            return;
        }
    }
    
    resolve(@{
        @"top": @(0),
        @"bottom": @(0),
        @"left": @(0),
        @"right": @(0)
    });
  
}

@end
