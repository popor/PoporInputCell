//
//  PoporInputCell.m
//  PoporInputCell
//
//  Created by popor on 01/03/2019.
//  Copyright (c) 2019 popor. All rights reserved.
//

#import "PoporInputCell.h"
#import <Masonry/Masonry.h>
#import <PoporFoundation/NSString+Tool.h>
#import <PoporUI/UITextField+format.h>

static NSString * PicMoneyNumbers      = @"0123456789.";
static NSString * PicPhoneNumbers      = @"0123456789";

@interface PoporInputCell () <UITextFieldDelegate>

@property (nonatomic        ) int maxLength;
@property (nonatomic, copy  ) PoporInputCellIntBlock maxBlock;

@end

@implementation PoporInputCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier cellType:0 lbtSize:CGSizeZero rbtSize:CGSizeZero lGap:15 rGap:15];
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(PoporInputCellType)cellType lbtSize:(CGSize)lbtSize rbtSize:(CGSize)rbtSize {
    
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier cellType:cellType lbtSize:lbtSize rbtSize:rbtSize lGap:15 rGap:15];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(PoporInputCellType)cellType lbtSize:(CGSize)lbtSize rbtSize:(CGSize)rbtSize lGap:(int)lGap rGap:(int)rGap {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.cellType    = cellType;
        self.lbtSize     = lbtSize;
        self.rbtSize     = rbtSize;
        self.lGap        = lGap;
        self.rGap        = rGap;
        
        self.textGapUnit = 4;
        
        [self addViews];
        [self layoutSubviewsCustom];
    }
    return self;
}

- (void)layoutSubviewsCustom {
    
    __weak typeof(self) weakSelf = self;
    BOOL isLBT  = self.cellType & PoporInputCellTypeLBT;
    BOOL isLine = self.cellType & PoporInputCellTypeLineView;
    BOOL isRBT  = self.cellType & PoporInputCellTypeRBT;
    
    int gap = 3;
    [self.lBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lGap);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(weakSelf.lbtSize);
        weakSelf.lBT.tag = isLBT ? gap: -gap;
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.lBT.mas_right).offset(gap + weakSelf.lBT.tag);
        if (isLine) {
            make.width.mas_equalTo(1);
            weakSelf.lineView.tag = gap;
            if (isLBT) {
                make.centerY.mas_equalTo(0);
                make.height.mas_equalTo(weakSelf.lBT.mas_height);
            }else{
                make.top.mas_equalTo(gap);
                make.bottom.mas_equalTo(-gap);
            }
        }else{
            make.width.mas_equalTo(0);
            weakSelf.lineView.tag = -gap;
        }
    }];
    
    [self.rBT mas_makeConstraints:^(MASConstraintMaker *make) {
        if (isRBT) {
            make.size.mas_equalTo(weakSelf.rbtSize);
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-self.lGap);
        }else{{
            make.size.mas_equalTo(CGSizeZero);
        }}
    }];
    
    [self.tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.lineView.mas_right).offset(gap + weakSelf.lineView.tag);
        make.top.mas_equalTo(0);
        //make.centerY.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        if (!isRBT) {
            make.right.mas_equalTo(-self.lGap);
        }else{
            make.right.mas_equalTo(weakSelf.rBT.mas_left).offset(-gap);
        }
    }];
}

- (void)addViews {
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.userInteractionEnabled = NO;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:button];
        
        [button addTarget:self action:@selector(btAction) forControlEvents:UIControlEventTouchUpInside];
        
        self.lBT = button;
    }
    {
        UIView * oneV = [UIView new];
        oneV.backgroundColor = [UIColor colorWithRed:231 green:231 blue:231 alpha:1];
        [self addSubview:oneV];
        
        self.lineView = oneV;
    }
    {
        UITextField * oneTF = [UITextField new];
        
        oneTF.backgroundColor = [UIColor clearColor];
        oneTF.textAlignment = NSTextAlignmentLeft;
        oneTF.delegate = self;
        
        [self addSubview:oneTF];
        self.tf = oneTF;
    }
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:button];
        [button addTarget:self action:@selector(btAction) forControlEvents:UIControlEventTouchUpInside];
        
        self.rBT = button;
    }
}

- (void)btAction {
    if (self.rbtActionBlock) {
        self.rbtActionBlock(self);
    }
}

- (void)setDefaultFetchCodeBT {
    if (self.rBT) {
        self.rBT.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.rBT.backgroundColor = [UIColor clearColor];
        self.rBT.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.rBT setTitleColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1] forState:UIControlStateNormal];
        
        [self.rBT setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

- (void)startTimerFrom:(int)max progress:(PoporInputCellIntBlock)progressBlock finish:(PoporInputCellBlock)finishBlock {
    
    __weak typeof(self) weakSelf = self;
    weakSelf.timerRecord = max;
    //全局队列    默认优先级
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //定时器模式  事件源
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    //NSEC_PER_SEC是秒，＊1是每秒
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), NSEC_PER_SEC * 1, 0);
    //设置响应dispatch源事件的block，在dispatch源指定的队列上运行
    dispatch_source_set_event_handler(timer, ^{
        //回调主线程，在主线程中操作UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakSelf.timerRecord >= 0) {
                weakSelf.rBT.enabled = NO;
                weakSelf.timerRecord --;
                
                if (progressBlock) {
                    if (progressBlock) {
                        progressBlock(self, weakSelf.timerRecord);
                    }
                }else{
                    [weakSelf.rBT setTitle:[NSString stringWithFormat:@"(%is)后重新获取", weakSelf.timerRecord] forState:UIControlStateDisabled];
                }
                
            } else {
                //这句话必须写否则会出问题
                dispatch_source_cancel(timer);
                weakSelf.rBT.enabled = YES;
                
                if (finishBlock) {
                    finishBlock(self);
                }
            }
        });
    });
    //启动源
    dispatch_resume(timer);
}

- (void)stopBTTimer {
    self.timerRecord = 1;
}

#pragma mark - tf事件类型
- (void)setTfTypeNumber {
    self.tf.secureTextEntry = NO;
    self.tf.keyboardType    = UIKeyboardTypeNumberPad;
}

- (void)setTfTypePhone {
    self.tfType = PoporInputTfTypePhone;
    self.tf.secureTextEntry = NO;
    //self.tf.clearButtonMode = UITextFieldViewModeAlways;
    //self.tf.keyboardType    = UIKeyboardTypePhonePad; // 系统的电话键盘
    self.tf.keyboardType    = UIKeyboardTypeNumberPad;  // 系统或第三方的数字键盘
}

- (void)setTfTypeMoneyFloat {
    self.tfType = PoporInputTfTypeMoneyFloat;
    self.tf.secureTextEntry = NO;
    self.tf.keyboardType    = UIKeyboardTypeDecimalPad;  // 系统或第三方的数字键盘
}

- (void)setTfTypeMoneyInt{
    self.tfType = PoporInputTfTypeMoneyInt;
    self.tf.secureTextEntry = NO;
    self.tf.keyboardType    = UIKeyboardTypeNumberPad;  // 系统或第三方的数字键盘
}

- (void)setTfTypePassword {
    self.tfType = PoporInputTfTypePassword;
    self.tf.secureTextEntry = YES;
    self.tf.keyboardType    = UIKeyboardTypeDefault;
}

- (void)setTfTypeBank {
    self.tfType = PoporInputTfTypeBank;
    self.tf.secureTextEntry = NO;
    self.tf.keyboardType    = UIKeyboardTypeNumberPad;  // 系统或第三方的数字键盘
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.editTFEnableBlock) {
        return self.editTFEnableBlock(self);
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    //    __weak typeof(self) weakSelf = self;
    //    __weak typeof(textField) weakTF = textField;
    
    NSCharacterSet *cs;
    switch (self.tfType) {
        case PoporInputTfTypePassword:{
            NSString * tempString=string;
            tempString=[NSString replaceString:tempString withREG:@" " withNewString:@""];
            if (![tempString isEqualToString:string]) {
                return NO;
            }
            break;
        }
        case PoporInputTfTypePhone:{
            cs = [[NSCharacterSet characterSetWithCharactersInString:PicPhoneNumbers] invertedSet];
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            BOOL basicTest = [string isEqualToString:filtered];
            if(!basicTest){
                return NO;
            }
            if ([textField.text stringByReplacingCharactersInRange:range withString:string].length>11) {
                return NO;
            }
            // 使用延迟事件会在切换TF的时候 出现异常
            dispatch_async(dispatch_get_main_queue(), ^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [textField formatChinaPhone];
                });
            });
            break;
        }
        case PoporInputTfTypeMoneyInt:{
            cs = [[NSCharacterSet characterSetWithCharactersInString:PicPhoneNumbers] invertedSet];
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            BOOL basicTest = [string isEqualToString:filtered];
            if(!basicTest){
                return NO;
            }
            // 使用延迟事件会在切换TF的时候 出现异常
            dispatch_async(dispatch_get_main_queue(), ^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [textField formatMoneyUnit:self.textGapUnit];
                });
            });
            break;
        }
        case PoporInputTfTypeMoneyFloat:{
            cs = [[NSCharacterSet characterSetWithCharactersInString:PicMoneyNumbers] invertedSet];
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            BOOL basicTest = [string isEqualToString:filtered];
            if(!basicTest){
                return NO;
            }
            NSString * tString = [textField.text stringByReplacingCharactersInRange:range withString:string];
            
            if ([tString countOccurencesOfString:@"."]>1) {
                return NO;
            }
            // 使用延迟事件会在切换TF的时候 出现异常
            dispatch_async(dispatch_get_main_queue(), ^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [textField formatMoneyUnit:self.textGapUnit];
                });
            });
            break;
        }
        case PoporInputTfTypeBank:{
            cs = [[NSCharacterSet characterSetWithCharactersInString:PicPhoneNumbers] invertedSet];
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            BOOL basicTest = [string isEqualToString:filtered];
            if(!basicTest){
                return NO;
            }
            //// 使用延迟事件会在切换TF的时候 出现异常
            dispatch_async(dispatch_get_main_queue(), ^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [textField formatBankUnit:self.textGapUnit];
                });
            });
            break;
        }
        default:
            break;
    }
    
    if (self.maxLength > 0) {
        if ([textField.text stringByReplacingCharactersInRange:range withString:string].length>self.maxLength) {
            if (self.maxBlock) {
                self.maxBlock(self, self.maxLength);
            }
            return NO;
        }
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.editTFBlock) {
            self.editTFBlock(self, textField.text);
        }
    });
    return YES;
}

// 最大输入数字限制
- (void)setMaxLength:(int)maxLength maxBlock:(PoporInputCellIntBlock)maxBlock {
    self.maxLength = maxLength;
    self.maxBlock  = maxBlock;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.editTFBlock) {
        self.editTFBlock(self, textField.text);
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if (self.clearTFBlock) {
        self.clearTFBlock(self);
    }
    return YES;
}

@end
