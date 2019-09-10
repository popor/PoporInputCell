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
#import <PoporUI/UITextField+pFormat.h>
#import <PoporUI/UIViewController+pTapEndEdit.h>

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
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= 21) {
        return 160;
    }
    return 50;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 21) {
//        return 160;
//    }
//    return 50;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < 21) {
        NSString * CellID = [NSString stringWithFormat:@"%li", indexPath.row];
        PoporInputCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        BOOL isInit = cell ? NO:YES;
        int cellH = 70;
        int tfH = cellH-20;
        switch (indexPath.row) {
            case 0: {
                if (!cell) {
                    //cell = [[PoporInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID cellType:PoporInputCellTypeLBT + PoporInputCellTypeRBT + PoporInputCellTypeLineView lbtSize:CGSizeMake(100, 40) rbtSize:CGSizeMake(20, 40)];
                    
                    cell = [[PoporInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID cellType:PoporInputCellTypeLBT + PoporInputCellTypeRBT + PoporInputCellTypeLineView lbtSize:CGSizeMake(100, 40) rbtSize:CGSizeMake(20, 40) lGap:16 rGap:16 cellH:cellH tfH:tfH];
                    
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
                    cell = [[PoporInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID cellType:PoporInputCellTypeLBT + PoporInputCellTypeLineView  lbtSize:CGSizeMake(-100, 40) rbtSize:CGSizeZero lGap:16 rGap:16 cellH:cellH tfH:tfH];
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
                    cell = [[PoporInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID cellType:PoporInputCellTypeLBT + PoporInputCellTypeRBT + PoporInputCellTypeLineView lbtSize:CGSizeMake(100, 40) rbtSize:CGSizeMake(100, 40) lGap:16 rGap:16 cellH:cellH tfH:tfH];
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
                    cell = [[PoporInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID cellType:PoporInputCellTypeLBT + PoporInputCellTypeRBT + PoporInputCellTypeLineView lbtSize:CGSizeMake(100, 40) rbtSize:CGSizeMake(20, 40) lGap:16 rGap:16 cellH:cellH tfH:tfH];
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
                    cell = [[PoporInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID cellType:PoporInputCellTypeLBT + PoporInputCellTypeRBT + PoporInputCellTypeLineView lbtSize:CGSizeMake(100, 40) rbtSize:CGSizeMake(20, 40) lGap:16 rGap:16 cellH:cellH tfH:tfH];
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
                    cell = [[PoporInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID cellType:PoporInputCellTypeLBT + PoporInputCellTypeRBT + PoporInputCellTypeLineView lbtSize:CGSizeMake(100, 40) rbtSize:CGSizeMake(20, 40) lGap:16 rGap:16 cellH:cellH tfH:tfH];
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
                    cell = [[PoporInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID cellType:PoporInputCellTypeLBT + PoporInputCellTypeRBT + PoporInputCellTypeLineView lbtSize:CGSizeMake(100, 40) rbtSize:CGSizeMake(20, 40) lGap:16 rGap:16 cellH:cellH tfH:tfH];
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
                    cell = [[PoporInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID cellType:PoporInputCellTypeLBT + PoporInputCellTypeRBT + PoporInputCellTypeLineView lbtSize:CGSizeMake(100, 40) rbtSize:CGSizeMake(20, 40) lGap:16 rGap:16 cellH:cellH tfH:tfH];
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
                    cell = [[PoporInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID cellType:PoporInputCellTypeLBT + PoporInputCellTypeRBT + PoporInputCellTypeLineView lbtSize:CGSizeMake(100, 40) rbtSize:CGSizeZero lGap:16 rGap:16 cellH:cellH tfH:tfH];
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
                    cell = [[PoporInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID cellType:PoporInputCellTypeLBT lbtSize:CGSizeMake(100, 40) rbtSize:CGSizeZero lGap:16 rGap:16 cellH:cellH tfH:tfH];
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
                    cell = [[PoporInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID cellType:PoporInputCellTypeLBT lbtSize:CGSizeMake(0, 40) rbtSize:CGSizeZero lGap:16 rGap:16 cellH:cellH tfH:tfH];
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
            case 11: {
                if (!cell) {
                    cell = [[PoporInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID cellType:PoporInputCellTypeLBT lbtSize:CGSizeMake(100, 40) rbtSize:CGSizeZero lGap:16 rGap:16 cellH:cellH tfH:tfH];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    isInit = YES;
                    
                    [cell.lBT setTitle:@"车牌号" forState:UIControlStateNormal];
                    [cell.lBT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    
                    cell.view1 = ({
                        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                        [button setTitle:@"京 ▼" forState:UIControlStateNormal];
                        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        [button setBackgroundColor:[UIColor whiteColor]];
                        
                        button.titleLabel.font = [UIFont systemFontOfSize:13];
                        button.layer.cornerRadius = 4;
                        button.layer.borderColor = [UIColor redColor].CGColor;
                        button.layer.borderWidth = 0.5;
                        button.clipsToBounds = YES;
                        
                        [cell addSubview:button];
                        
                        button;
                    });
                    
                    [cell.view1 mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.mas_equalTo(cell.lBT.mas_centerY);
                        make.left.mas_equalTo(cell.lineView.mas_right).mas_offset(11);
                        make.width.mas_equalTo(50);
                    }];
                    
                    [cell.tf mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(cell.view1.mas_right).mas_offset(11);
                        
                        make.top.mas_equalTo(0);
                        make.bottom.mas_equalTo(0);
                        make.right.mas_equalTo(-cell.rGap);
                    }];
                    
                    cell.tf.placeholder = @"请输入";
                    cell.editTFBlock = ^(PoporInputCell * _Nonnull piCell, NSString * _Nonnull string) {
                        
                    };
                }
                
                break;
            }
            case 12: {
                if (!cell) {
                    cell = [[PoporInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID cellType:PoporInputCellTypeLBT lbtSize:CGSizeMake(100, 40) rbtSize:CGSizeZero lGap:16 rGap:16 cellH:cellH tfH:tfH];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.tf.textAlignment = NSTextAlignmentLeft;
                    
                    cell.textGapUnit = 4;
                    
                    [cell.lBT setTitle:@"身份证" forState:UIControlStateNormal];
                    cell.tf.placeholder = @"请输入身份证";
                    cell.tf.text = @"11111111111111117X";
                    [cell setTfTypeIdcard];
                    
                    cell.editTFBlock = ^(PoporInputCell *piCell, NSString *string) {
                        
                    };
                }
                [cell.tf formatChinaIdcardGapWidth:cell.textGapUnit];
                
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
    }else{
        NSString * CellID = [NSString stringWithFormat:@"%li", indexPath.row];
        
        //BOOL isInit = NO ;// = cell ? NO:YES;
        switch (indexPath.row) {
            case 21: {
                PoporTextViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID];
                if (!cell) {
                    cell = [[PoporTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    __weak typeof(cell) weakCell = cell;
                    [cell setMasBlockButton:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(10);
                        make.left.mas_equalTo(16);
                        //make.bottom.mas_equalTo(-20);
                        make.right.mas_equalTo(-16);
                        make.height.mas_equalTo(20);
                        
                    } masBlockTextView:^(MASConstraintMaker *make) {
                        
                        make.top.mas_equalTo(weakCell.button.mas_bottom).mas_offset(0);
                        make.left.mas_equalTo(weakCell.button.mas_left).mas_offset(-6);
                        make.bottom.mas_equalTo(-20);
                        make.right.mas_equalTo(weakCell.button.mas_right).mas_offset(6);
                        
                        make.height.mas_greaterThanOrEqualTo(140);
                    }];
                }
                [cell.button setTitle:@"备注21" forState:UIControlStateNormal];
                [cell.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                cell.textView.placeholder = @"2019年6月26日讯，华为轮值董事长胡厚崑今日在上海2019MWC会上说，截至目前，华为已在全球发货15万个5G基站，年底达到50万个5G基站。华为50个全球5G合同中，有28个来自欧洲。近期华为 Mate X 5G手机会正式上市。";
                
                return cell;
            }
            case 22: {
                PoporLabelCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID];
                if (!cell) {
                    cell = [[PoporLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    __weak typeof(cell) weakCell = cell;
                    [cell setMasBlockButton:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(10);
                        make.left.mas_equalTo(16);
                        //make.bottom.mas_equalTo(-20);
                        make.right.mas_equalTo(-16);
                        make.height.mas_equalTo(20);
                        
                    } masBlockLabel:^(MASConstraintMaker *make) {
                        
                        make.top.mas_equalTo(weakCell.button.mas_bottom).mas_offset(0);
                        make.left.mas_equalTo(weakCell.button);
                        make.bottom.mas_equalTo(-10);
                        make.right.mas_equalTo(weakCell.button);
                        //make.height.mas_greaterThanOrEqualTo(140);
                    } ];
                    
                    cell.label.font = [UIFont systemFontOfSize:16];
                }
                [cell.button setTitle:@"备注22" forState:UIControlStateNormal];
                [cell.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                cell.label.text = @"2019年6月26日讯，华为轮值董事长胡厚崑今日在上海2019MWC会上说，截至目前，华为已在全球发货15万个5G基站，年底达到50万个5G基站。华为50个全球5G合同中，有28个来自欧洲。近期华为 Mate X 5G手机会正式上市。";
                
                return cell;
            }
            case 23: {
                PoporLabelCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID];
                if (!cell) {
                    cell = [[PoporLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    __weak typeof(cell) weakCell = cell;
                    [cell setMasBlockButton:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(10);
                        make.left.mas_equalTo(16);
                        //make.bottom.mas_equalTo(-20);
                        make.width.mas_equalTo(90);
                        make.height.mas_equalTo(20);
                        
                    } masBlockLabel:^(MASConstraintMaker *make) {
                        
                        make.top.mas_equalTo(weakCell.button);
                        make.left.mas_equalTo(weakCell.button.mas_right).mas_offset(5);
                        make.bottom.mas_equalTo(-10);
                        make.right.mas_equalTo(-16);
                        //make.height.mas_greaterThanOrEqualTo(140);
                    } ];
                    
                    cell.label.font = [UIFont systemFontOfSize:16];
                }
                [cell.button setTitle:@"备注23" forState:UIControlStateNormal];
                [cell.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                cell.label.text = @"2019年6月26日讯，华为轮值董事长胡厚崑今日在上海2019MWC会上说，截至目前，华为已在全球发货15万个5G基站，年底达到50万个5G基站。华为50个全球5G合同中，有28个来自欧洲。近期华为 Mate X 5G手机会正式上市。";
                
                return cell;
            }
            default:{
                UITableViewCell * dcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
                dcell.textLabel.text = [NSString stringWithFormat:@"%li", indexPath.row];
                
                return dcell;
                break;
            }
        }
        
        
    }
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)phoneCodeAction:(PoporInputCell *)cell {
    
    
}

@end
