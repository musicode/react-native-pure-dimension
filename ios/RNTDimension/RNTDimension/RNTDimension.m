//
//  RNTDimension.m
//  RNTDimension
//
//  Created by zhujl on 2019/11/7.
//  Copyright © 2019 finstao. All rights reserved.
//

#import "RNTDimension.h"

@implementation RNTDimension

RCT_EXPORT_METHOD(getStatusBarHeight:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
  resolve(@{
    @"height": @(RCTSharedApplication().statusBarFrame.size.height),
  })
}

@end
