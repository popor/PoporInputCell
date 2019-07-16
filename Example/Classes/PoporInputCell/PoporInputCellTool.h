//
//  PoporInputCellTool.h
//  Masonry
//
//  Created by apple on 2019/1/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PoporInputCellTool : NSObject

// 据测试,只有iPhone6plus的x是20,其他都是15.
@property (nonatomic        ) float separatorInsetX;

+ (instancetype)share;

@end

NS_ASSUME_NONNULL_END
