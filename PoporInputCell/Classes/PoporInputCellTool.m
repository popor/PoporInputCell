//
//  PoporInputCellTool.m
//  Masonry
//
//  Created by apple on 2019/1/17.
//

#import "PoporInputCellTool.h"
#import <UIKit/UIKit.h>

@implementation PoporInputCellTool

+ (instancetype)share {
    static dispatch_once_t once;
    static PoporInputCellTool * instance;
    dispatch_once(&once, ^{
        instance = [self new];
        
        instance.separatorInsetX = 15;
        if ([[UIScreen mainScreen] bounds].size.width == 414) {
            instance.separatorInsetX = 20;
        }
    });
    return instance;
}

@end
