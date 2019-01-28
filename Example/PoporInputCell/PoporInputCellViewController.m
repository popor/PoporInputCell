//
//  PoporInputCellViewController.m
//  PoporInputCell
//
//  Created by popor on 01/03/2019.
//  Copyright (c) 2019 popor. All rights reserved.
//

#import "PoporInputCellViewController.h"
#import <Masonry/Masonry.h>
#import "PoporInputCell.h"
#import <PoporUI/UITextField+format.h>
#import <PoporUI/UIViewController+TapEndEdit.h>

@interface PoporInputCellViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * infoTV;

@end

@implementation PoporInputCellViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self startMonitorTapEdit];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self stopMonitorTapEdit];
}

- (void)keyboardFrameChanged:(CGRect)rect duration:(CGFloat)duration show:(BOOL)show {
    if (show) {
        float height = rect.size.height;
        [UIView animateWithDuration:0.25 animations:^{
            [self.infoTV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, height, 0));
            }];
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            [self.infoTV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
            }];
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.infoTV = [self addTVs];
    
    [self addTapEndEditGRAction];
}

#pragma mark - UITableView
- (UITableView *)addTVs {
    UITableView * oneTV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    oneTV.delegate   = self;
    oneTV.dataSource = self;
    
    oneTV.allowsMultipleSelectionDuringEditing = YES;
    oneTV.directionalLockEnabled = YES;
    
    oneTV.estimatedRowHeight           = 0;
    oneTV.estimatedSectionHeaderHeight = 0;
    oneTV.estimatedSectionFooterHeight = 0;
    
    [self.view addSubview:oneTV];
    
    [oneTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    return oneTV;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * CellID = [NSString stringWithFormat:@"%li", indexPath.row];
    PoporInputCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    BOOL isInit = cell ? NO:YES;
    switch (indexPath.row) {
        case 0: {
            if (!cell) {
                cell = [[PoporInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID cellType:PoporInputCellTypeLBT + PoporInputCellTypeRBT + PoporInputCellTypeLineView lbtSize:CGSizeMake(100, 40) rbtSize:CGSizeMake(20, 40)];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                [cell.lBT setTitle:@"姓名" forState:UIControlStateNormal];
                cell.tf.placeholder = @"请输入";
                [cell.rBT setTitle:@"!" forState:UIControlStateNormal];
                
                [cell.lBT setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                cell.lineView.backgroundColor = [UIColor grayColor];
                [cell.rBT setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                
                
                cell.editTFBlock = ^(PoporInputCell *cell, NSString *text) {
                    // 设置text
                };
            }
            
            break;
        }
        case 1: {
            if (!cell) {
                cell = [[PoporInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID cellType:PoporInputCellTypeLBT + PoporInputCellTypeLineView  lbtSize:CGSizeMake(-100, 40) rbtSize:CGSizeZero];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.tf.textAlignment = NSTextAlignmentRight;
                
                [cell.lBT setTitle:@"手机号码" forState:UIControlStateNormal];
                cell.tf.placeholder = @"请输入";
                
                [cell.lBT setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                
                [cell setTfTypePhone]; // 设置手机号码类型
                cell.tf.text = @"11122223333";
                
                cell.editTFBlock = ^(PoporInputCell *cell, NSString *text) {
                    // 设置text
                };
            }
        
            [cell.tf formatChinaPhone];    
            break;
        }
        case 2: {
            if (!cell) {
                cell = [[PoporInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID cellType:PoporInputCellTypeLBT + PoporInputCellTypeRBT + PoporInputCellTypeLineView lbtSize:CGSizeMake(100, 40) rbtSize:CGSizeMake(100, 40)];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                [cell.lBT setTitle:@"验证码" forState:UIControlStateNormal];
                cell.tf.placeholder = @"请输入";

                [cell setDefaultFetchCodeBT];
                cell.rBT.titleLabel.font = [UIFont systemFontOfSize:12];
                
                cell.rbtActionBlock = ^(PoporInputCell *piCell) {
                    [piCell startTimerFrom:60 progress:^(PoporInputCell *piCell, int intValue) {
                        [piCell.rBT setTitle:[NSString stringWithFormat:@"(%is)后重新获取", intValue] forState:UIControlStateDisabled];
                    } finish:^(PoporInputCell *piCell) {
                        
                    }];
                };
                
            }
            break;
        }
        case 3: {
            if (!cell) {
                cell = [[PoporInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID cellType:PoporInputCellTypeLBT + PoporInputCellTypeRBT + PoporInputCellTypeLineView lbtSize:CGSizeMake(100, 40) rbtSize:CGSizeMake(20, 40)];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                [cell.lBT setTitle:@"密码" forState:UIControlStateNormal];
                cell.tf.placeholder = @"请输入";
                [cell.rBT setTitle:@"!" forState:UIControlStateNormal];
                
                [cell setTfTypePassword];
                cell.editTFBlock = ^(PoporInputCell *piCell, NSString *string) { };
            }
            
            break;
        }
        case 4: {
            if (!cell) {
                cell = [[PoporInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID cellType:PoporInputCellTypeLBT + PoporInputCellTypeRBT + PoporInputCellTypeLineView lbtSize:CGSizeMake(100, 40) rbtSize:CGSizeMake(20, 40)];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                [cell.lBT setTitle:@"禁止输入" forState:UIControlStateNormal];
                cell.tf.placeholder = @"请输入";
                [cell.rBT setTitle:@"!" forState:UIControlStateNormal];
                
                cell.editTFEnableBlock = ^BOOL(PoporInputCell *cell) {
                    //if (condition) {
                    //    statements
                    //}
                    return NO;
                };
            }
            break;
        }
        case 5: {
            if (!cell) {
                cell = [[PoporInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID cellType:PoporInputCellTypeLBT + PoporInputCellTypeRBT + PoporInputCellTypeLineView lbtSize:CGSizeMake(100, 40) rbtSize:CGSizeMake(20, 40)];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textGapUnit = 4;
                
                [cell.lBT setTitle:@"金额小数" forState:UIControlStateNormal];
                cell.tf.placeholder = @"请输入";
                [cell.rBT setTitle:@"!" forState:UIControlStateNormal];
                
                [cell setTfTypeMoneyFloat];
                cell.editTFBlock = ^(PoporInputCell *piCell, NSString *string) {
                    
                };
                cell.tf.text = @"100000.40";
                
            }
            
            [cell.tf formatMoneyUnit:4];
            
            break;
        }
        case 6: {
            if (!cell) {
                cell = [[PoporInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID cellType:PoporInputCellTypeLBT + PoporInputCellTypeRBT + PoporInputCellTypeLineView lbtSize:CGSizeMake(100, 40) rbtSize:CGSizeMake(20, 40)];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textGapUnit = 4;
                
                [cell.lBT setTitle:@"金额整数" forState:UIControlStateNormal];
                cell.tf.placeholder = @"请输入";
                [cell.rBT setTitle:@"!" forState:UIControlStateNormal];
                
                [cell setTfTypeMoneyInt];
                cell.editTFBlock = ^(PoporInputCell *piCell, NSString *string) {
                    
                };
                cell.tf.text = @"1000000";
                
            }
            
            [cell.tf formatMoneyUnit:4];
            
            break;
        }
        case 7: {
            if (!cell) {
                cell = [[PoporInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID cellType:PoporInputCellTypeLBT + PoporInputCellTypeRBT + PoporInputCellTypeLineView lbtSize:CGSizeMake(100, 40) rbtSize:CGSizeMake(20, 40)];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                [cell.lBT setTitle:@"最多5字节" forState:UIControlStateNormal];
                cell.tf.placeholder = @"请输入";
                [cell.rBT setTitle:@"!" forState:UIControlStateNormal];
                
                cell.editTFBlock = ^(PoporInputCell *piCell, NSString *string) {
                    
                };
                
                [cell setMaxLength:5 maxBlock:^(PoporInputCell *piCell, int intValue) {
                    //alert(@"some string");
                    NSLog(@"超多了最多 %i 字节", intValue);
                }];
                
            }
            
            [cell.tf formatMoneyUnit:4];
            
            break;
        }
        case 8: {
            if (!cell) {
                cell = [[PoporInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID cellType:PoporInputCellTypeLBT + PoporInputCellTypeRBT + PoporInputCellTypeLineView lbtSize:CGSizeMake(100, 40) rbtSize:CGSizeZero];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textGapUnit = 4;
                
                [cell.lBT setTitle:@"简单银行卡" forState:UIControlStateNormal];
                cell.tf.placeholder = @"请输入";
                [cell.rBT setTitle:@"!" forState:UIControlStateNormal];
                
                [cell setTfTypeBank];
                
                cell.editTFBlock = ^(PoporInputCell *piCell, NSString *string) {
                    
                };
                
            }
            
            [cell.tf formatBankUnit:4];
            
            break;
        }
        case 9: {
            if (!cell) {
                cell = [[PoporInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID cellType:PoporInputCellTypeLBT lbtSize:CGSizeMake(100, 40) rbtSize:CGSizeZero];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.tf.textAlignment = NSTextAlignmentRight;
                
                cell.textGapUnit = 4;
                
                [cell.lBT setTitle:@"简单银行卡" forState:UIControlStateNormal];
                cell.tf.placeholder = @"请输入";
                [cell.rBT setTitle:@"!" forState:UIControlStateNormal];
                
                [cell setTfTypeBank];
                
                cell.editTFBlock = ^(PoporInputCell *piCell, NSString *string) {
                    
                };
            }
            
            [cell.tf formatBankUnit:4];
            
            break;
        }
        case 10: {
            if (!cell) {
                cell = [[PoporInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID cellType:PoporInputCellTypeLBT lbtSize:CGSizeMake(0, 40) rbtSize:CGSizeZero];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.tf.textAlignment = NSTextAlignmentRight;
                
                cell.textGapUnit = 4;
                
                [cell.lBT setTitle:@"简单银行卡------" forState:UIControlStateNormal];
                cell.tf.placeholder = @"请输入123";
                
                [cell setTfTypeBank];
                
                cell.editTFBlock = ^(PoporInputCell *piCell, NSString *string) {
                    
                };
            }
            
            [cell.tf formatBankUnit:4];
            
            break;
        }
        default:{
            UITableViewCell * dcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
            dcell.textLabel.text = [NSString stringWithFormat:@"%li", indexPath.row];
            
            return dcell;
            break;
        }
    }
    if (isInit) {
        UILabel * oneL = ({
            UILabel * l = [UILabel new];
            l.frame              = CGRectMake(0, 0, 25, 50);
            l.backgroundColor    = [UIColor clearColor];
            l.font               = [UIFont systemFontOfSize:14];
            l.textColor          = [UIColor redColor];
      
            [cell addSubview:l];
            l;
        });
        oneL.text = [NSString stringWithFormat:@"%li", indexPath.row];
        
        [cell.lBT setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:1 alpha:0.5]];
        [cell.lBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        cell.tf.backgroundColor = [UIColor colorWithRed:0.5 green:0 blue:0.5 alpha:0.5];
        
        [cell.rBT setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:1 alpha:0.5]];
        [cell.rBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        cell.lineView.backgroundColor = [UIColor redColor];
    }

    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)phoneCodeAction:(PoporInputCell *)cell {
    
    
}

@end
