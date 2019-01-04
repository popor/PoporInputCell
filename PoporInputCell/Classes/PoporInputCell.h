//
//  PoporInputCell.h
//  PoporInputCell
//
//  Created by popor on 01/03/2019.
//  Copyright (c) 2019 popor. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, PoporInputCellType) {
    PoporInputCellTypeLBT      = 1 << 0, // 1
    PoporInputCellTypeLineView = 1 << 1, // 2
    PoporInputCellTypeRBT      = 1 << 2, // 4
};

typedef NS_ENUM(int, PoporInputTfType) {
    PoporInputTfTypePassword = 1,
    PoporInputTfTypePhone,
    PoporInputTfTypeMoneyInt,
    PoporInputTfTypeMoneyFloat,
    PoporInputTfTypeBank,
};

@class PoporInputCell;

typedef void(^PoporInputCellBlock)       (PoporInputCell * piCell);
typedef BOOL(^PoporInputBoolCellBlock)   (PoporInputCell * piCell); // 需要返回BOOL
typedef void(^PoporInputCellIntBlock)    (PoporInputCell * piCell, int intValue);
typedef void(^PoporInputCellStringBlock) (PoporInputCell * piCell, NSString * string);

@interface PoporInputCell : UITableViewCell

@property (nonatomic, strong) UIButton    * lBT;
@property (nonatomic, strong) UIView      * lineView;
@property (nonatomic, strong) UITextField * tf;
@property (nonatomic, strong) UIButton    * rBT;

@property (nonatomic        ) CGSize      lbtSize;
@property (nonatomic        ) CGSize      rbtSize;

@property (nonatomic        ) int         textGapUnit; //钱数字间隔,一般为3|4

@property (nonatomic        ) int         timerRecord; // 一个timer计时器

@property (nonatomic        ) PoporInputCellType cellType;
@property (nonatomic        ) PoporInputTfType   tfType;

// 是否允许编辑TFblock
@property (nonatomic, copy  ) PoporInputBoolCellBlock   editTFEnableBlock;

// TF编辑实时反馈block
@property (nonatomic, copy  ) PoporInputCellStringBlock editTFBlock;

// TF编辑清除block
@property (nonatomic, copy  ) PoporInputCellBlock       clearTFBlock;

@property (nonatomic, copy  ) PoporInputCellBlock       rbtActionBlock;

// 自定义block,方便开发
@property (nonatomic, copy  ) PoporInputCellBlock       customeBlock1;
@property (nonatomic, copy  ) PoporInputCellBlock       customeBlock2;
@property (nonatomic, copy  ) PoporInputCellBlock       customeBlock3;
@property (nonatomic, copy  ) PoporInputCellBlock       customeBlock4;
@property (nonatomic, copy  ) PoporInputCellBlock       customeBlock5;
@property (nonatomic, copy  ) PoporInputCellBlock       customeBlock6;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(PoporInputCellType)cellType lbtSize:(CGSize)lbtSize rbtSize:(CGSize)rbtSize;

- (void)setDefaultFetchCodeBT;
- (void)startTimerFrom:(int)max progress:(PoporInputCellIntBlock)progressBlock finish:(PoporInputCellBlock)finishBlock;
- (void)stopBTTimer;

- (void)setTfTypeNumber;
- (void)setTfTypePhone;
- (void)setTfTypeMoneyFloat;
- (void)setTfTypeMoneyInt;
- (void)setTfTypePassword;
- (void)setTfTypeBank;

// 最大输入数字限制
- (void)setMaxLength:(int)maxLength maxBlock:(PoporInputCellIntBlock)maxBlock;

@end
