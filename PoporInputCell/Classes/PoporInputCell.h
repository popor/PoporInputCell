//
//  PoporInputCell.h
//  PoporInputCell
//
//  Created by popor on 01/03/2019.
//  Copyright (c) 2019 popor. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PoporInputCellTool.h"

typedef NS_OPTIONS(NSUInteger, PoporInputCellType) {
    PoporInputCellTypeLBT      = 1 << 0,
    PoporInputCellTypeLineView = 1 << 1,
    PoporInputCellTypeRBT      = 1 << 2,
};

typedef NS_ENUM(int, PoporInputTfType) {
    PoporInputTfTypeNumberInt = 1, // 只限制数字输入,不进行format操作
    PoporInputTfTypeNumberFloat, // 只限制数字输入,不进行format操作
    PoporInputTfTypePassword,
    PoporInputTfTypePhone,// 采用888-8888-8888约束
    PoporInputTfTypeMoneyInt,// 采用100 0000,小数点为分界线
    PoporInputTfTypeMoneyFloat,// 采用100 0000.0001,小数点为分界线
    PoporInputTfTypeBank,// 采用6266 8888 8888 88,第一位为分界线
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

/*
 如果size.width <= 0,则设置为自动宽度;
 如果size.width <  0,则设置make.width.mas_lessThanOrEqualTo(-size.width);
 
 1. size.width == 0,适用于纯文本显示.假如用于文本输入输入框的可点击区域比较小,没有设置placeholder的话可能无法使用.
 
 */
@property (nonatomic        ) CGSize      lbtSize;
@property (nonatomic        ) CGSize      rbtSize;

@property (nonatomic        ) int         lGap; // 最左边元素到cell边界
@property (nonatomic        ) int         rGap; // 最右边元素到cell边界

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


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(PoporInputCellType)cellType lbtSize:(CGSize)lbtSize rbtSize:(CGSize)rbtSize;

/**
 *  设置个人信息
 *
 *  @param lGap 推荐使用 [PoporInputCellTool share].separatorInsetX
 *  @param rGap 习惯上lGap = rGap
 *
 *  @return id
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(PoporInputCellType)cellType lbtSize:(CGSize)lbtSize rbtSize:(CGSize)rbtSize lGap:(int)lGap rGap:(int)rGap;

- (void)setDefaultFetchCodeBT;
- (void)startTimerFrom:(int)max progress:(PoporInputCellIntBlock)progressBlock finish:(PoporInputCellBlock)finishBlock;
- (void)stopBTTimer;

// 普通数字
- (void)setTfTypeNumberInt;
- (void)setTfTypeNumberFloat;

- (void)setTfTypePhone;

// 金钱格式
- (void)setTfTypeMoneyFloat;
- (void)setTfTypeMoneyInt;

// 密码
- (void)setTfTypePassword;

// 银行卡格式
- (void)setTfTypeBank;

// 最大输入数字限制
- (void)setMaxLength:(int)maxLength maxBlock:(PoporInputCellIntBlock)maxBlock;

@end
