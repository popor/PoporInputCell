//
//  PoporInputCell.m
//  PoporInputCell
//
//  Created by popor on 01/03/2019.
//  Copyright (c) 2019 popor. All rights reserved.
//

#import "PoporInputCell.h"
#import <Masonry/Masonry.h>
#import <PoporFoundation/NSString+pTool.h>
#import <PoporFoundation/NSString+pIDCard.h>
#import <PoporUI/UITextField+pFormat.h>

static NSString * PicMoneyNumbers  = @"0123456789.";
static NSString * PicPhoneNumbers  = @"0123456789";
static NSString * PicIdcardNumbers = @"0123456789Xx";

@interface PoporInputCell () <UITextFieldDelegate>

@property (nonatomic        ) int maxLength;
@property (nonatomic, copy  ) PoporInputCellIntBlock maxBlock;

@end

@implementation PoporInputCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier cellType:0 lbtSize:CGSizeZero rbtSize:CGSizeZero];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(PoporInputCellType)cellType lbtSize:(CGSize)lbtSize rbtSize:(CGSize)rbtSize {
    
    float x = [PoporInputCellTool share].separatorInsetX;
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier cellType:cellType lbtSize:lbtSize rbtSize:rbtSize lGap:x rGap:x];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(PoporInputCellType)cellType lbtSize:(CGSize)lbtSize rbtSize:(CGSize)rbtSize lGap:(int)lGap rGap:(int)rGap {
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier cellType:cellType lbtSize:lbtSize rbtSize:rbtSize lGap:lGap rGap:rGap cellH:-1 tfH:-1];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(PoporInputCellType)cellType lbtSize:(CGSize)lbtSize rbtSize:(CGSize)rbtSize lGap:(int)lGap rGap:(int)rGap cellH:(int)cellH tfH:(int)tfH{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.cellType    = cellType;
        self.lbtSize     = lbtSize;
        self.rbtSize     = rbtSize;
        self.lGap        = lGap;
        self.rGap        = rGap;
        self.cellH       = cellH;
        self.tfH         = tfH;
        
        self.textGapUnit = 4;
        
        [self addViews];
        [self layoutSubviewsCustom];
    }
    return self;
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
        button.userInteractionEnabled = NO;
        
        [self addSubview:button];
        [button addTarget:self action:@selector(btAction) forControlEvents:UIControlEventTouchUpInside];
        
        self.rBT = button;
    }
}

- (void)layoutSubviewsCustom {
    BOOL isLBT  = self.cellType & PoporInputCellTypeLBT;
    BOOL isLine = self.cellType & PoporInputCellTypeLineView;
    BOOL isRBT  = self.cellType & PoporInputCellTypeRBT;
    
    int gap = PoporInputInnerGap;
    if (isLBT) {
        if (self.lbtSize.width <= 0) {
            [self.lBT.titleLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
            
            [self.lBT mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.lGap);
                
                if (self.cellH > self.lbtSize.height && self.lbtSize.height > 0) {
                    float gap = (self.cellH-self.lbtSize.height)/2.0f;
                    
                    make.top.mas_equalTo(gap);
                    //make.height.mas_equalTo(self.lbtSize.height);
                    make.bottom.mas_equalTo(-gap);
                    
                }else{
                    make.centerY.mas_equalTo(0);
                }
                
                if (self.lbtSize.width < 0) {
                    make.width.mas_lessThanOrEqualTo(-self.lbtSize.width);
                }
            }];
        }else{
            [self.lBT mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.lGap);
                
                if (self.cellH > self.lbtSize.height && self.lbtSize.height > 0) {
                    float gap = (self.cellH-self.lbtSize.height)/2.0f;
                    
                    make.top.mas_equalTo(gap);
                    //make.height.mas_equalTo(self.lbtSize.height);
                    make.bottom.mas_equalTo(-gap);
                    
                }else{
                    make.centerY.mas_equalTo(0);
                }
                
                make.width.mas_equalTo(self.lbtSize.width);
            }];
        }
    }else{
        [self.lBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.lGap);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeZero);
        }];
    }
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (isLine) {
            make.left.mas_equalTo(self.lBT.mas_right).offset(gap);
            make.width.mas_equalTo(1);
            if (isLBT) {
                make.centerY.mas_equalTo(0);
                make.height.mas_equalTo(self.lBT.mas_height);
            }else{
                make.top.mas_equalTo(gap);
                make.bottom.mas_equalTo(-gap);
            }
        }else{
            make.left.mas_equalTo(self.lBT.mas_right);
            make.width.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            make.height.mas_equalTo(0);
        }
    }];
    
    if (isRBT) {
        if (self.rbtSize.width <= 0) {
            [self.rBT.titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            self.rBT.titleLabel.numberOfLines = 0;
            [self.rBT mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.right.mas_equalTo(-self.rGap);
                
                if (self.cellH>self.rbtSize.height && self.rbtSize.height>0) {
                    float gap = (self.cellH-self.rbtSize.height)/2.0f;
                    
                    make.top.mas_equalTo(gap);
                    //make.height.mas_equalTo(self.rbtSize.height);
                    make.bottom.mas_equalTo(-gap);
                    
                }else{
                    make.centerY.mas_equalTo(0);
                }
                
                if (self.rbtSize.width < 0) {
                    make.width.mas_lessThanOrEqualTo(-self.rbtSize.width);
                }
            }];
        }else{
            [self.rBT mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.right.mas_equalTo(-self.rGap);
                
                if (self.cellH>self.rbtSize.height && self.rbtSize.height>0) {
                    float gap = (self.cellH-self.rbtSize.height)/2.0f;
                    
                    make.top.mas_equalTo(gap);
                    //make.height.mas_equalTo(self.rbtSize.height);
                    make.bottom.mas_equalTo(-gap);
                    
                }else{
                    make.centerY.mas_equalTo(0);
                }
                
                make.width.mas_equalTo(self.rbtSize.width);
            }];
        }
    }else{
        [self.rBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-self.rGap);
            make.size.mas_equalTo(CGSizeZero);
        }];
    }
    
    [self.tf setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lBT.mas_right).offset(PoporInputLbtTfGap);
        
        if (self.cellH>self.tfH && self.tfH>0) {
            float gap = (self.cellH-self.tfH)/2.0f;
            make.top.mas_equalTo(gap);
            //make.height.mas_equalTo(self.tfH);
            make.bottom.mas_equalTo(-gap);
            
        } else {
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }
        
        if (isRBT) {
            make.right.mas_equalTo(self.rBT.mas_left).offset(-gap);
        }else{
            make.right.mas_equalTo(-self.rGap);
        }
    }];
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
                        progressBlock(weakSelf, weakSelf.timerRecord);
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
- (void)setTfTypeNumberInt {
    self.tf.secureTextEntry = NO;
    self.tf.keyboardType    = UIKeyboardTypeNumberPad;
    self.tfType             = PoporInputTfTypeNumberInt;
}

- (void)setTfTypeNumberFloat {
    self.tf.secureTextEntry = NO;
    self.tf.keyboardType    = UIKeyboardTypeDecimalPad;
    self.tfType             = PoporInputTfTypeNumberFloat;
}

- (void)setTfTypeNumber {
    
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

// 省份证格式
- (void)setTfTypeIdcard {
    self.tfType = PoporInputTfTypeIdcard;
    self.tf.secureTextEntry = NO;
    self.tf.keyboardType    = UIKeyboardTypeNumberPad;  // 系统或第三方的数字键盘
    self.maxLength          = 18;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.editTFEnableBlock) {
        return self.editTFEnableBlock(self);
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *cs;
    switch (self.tfType) {
        case PoporInputTfTypeNumberInt: {
            cs = [[NSCharacterSet characterSetWithCharactersInString:PicPhoneNumbers] invertedSet];
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            BOOL basicTest = [string isEqualToString:filtered];
            if(!basicTest){
                return NO;
            }
            break;
        }
        case PoporInputTfTypeNumberFloat: {
            cs = [[NSCharacterSet characterSetWithCharactersInString:PicMoneyNumbers] invertedSet];
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            BOOL basicTest = [string isEqualToString:filtered];
            if(!basicTest){
                return NO;
            }
            
            NSString * tString = [textField.text stringByReplacingCharactersInRange:range withString:string];
            // 只允许一个小数点
            if ([tString countOccurencesOfString:@"."]>1) {
                return NO;
            }
            
            break;
        }
        case PoporInputTfTypePassword:{
            NSString * tempString=string;
            tempString = [tempString replaceWithREG:@" " newString:@""];
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
            // 只允许一个小数点
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
            // 使用延迟事件会在切换TF的时候 出现异常
            dispatch_async(dispatch_get_main_queue(), ^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [textField formatBankUnit:self.textGapUnit];
                });
            });
            break;
        }
        case PoporInputTfTypeIdcard: {
            cs = [[NSCharacterSet characterSetWithCharactersInString:PicIdcardNumbers] invertedSet];
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            BOOL basicTest = [string isEqualToString:filtered];
            if(!basicTest){
                return NO;
            }
            
            // 使用延迟事件会在切换TF的时候 出现异常
            dispatch_async(dispatch_get_main_queue(), ^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (self.tf.text.length == 17 && string.length>0) {
                        if ([[self.tf.text chinaIdcardLastCode] isEqualToString:@"X"]) {
                            self.tf.text = [NSString stringWithFormat:@"%@X", self.tf.text];
                        }
                    }
                    [textField formatChinaIdcardGapWidth:self.textGapUnit];
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
