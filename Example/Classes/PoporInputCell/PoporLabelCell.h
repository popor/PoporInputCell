//
//  PoporLabelCell.h
//  PoporInputCell_Example
//
//  Created by apple on 2019/7/16.
//  Copyright © 2019 popor. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BlockPoporLabelCell) (MASConstraintMaker * make);

@interface PoporLabelCell : UITableViewCell

@property (nonatomic, strong) UIButton * button;
@property (nonatomic, strong) UILabel * label;

@property (nonatomic, strong) UIView * view1;
@property (nonatomic, strong) UIView * view2;
@property (nonatomic, strong) UIView * view3;
@property (nonatomic, strong) UIView * view4;

- (void)setMasBlockButton:(BlockPoporLabelCell)masBlockButton masBlockLabel:(BlockPoporLabelCell)masBlockLabel;


@end

NS_ASSUME_NONNULL_END
