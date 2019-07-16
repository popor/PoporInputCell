//
//  PoporLabelCell.m
//  PoporInputCell_Example
//
//  Created by apple on 2019/7/16.
//  Copyright © 2019 popor. All rights reserved.
//

#import "PoporLabelCell.h"

@implementation PoporLabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setMasBlockButton:(BlockPoporLabelCell)masBlockButton masBlockLabel:(BlockPoporLabelCell)masBlockLabel {
    self.button = ({
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.contentView addSubview:button];
        
        button;
    });
    self.label = ({
        UILabel * l = [UILabel new];
        l.numberOfLines = 0;
        [self.contentView addSubview:l];
        
        l;
    });
    
    self.button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.button mas_makeConstraints:masBlockButton];
    [self.label mas_makeConstraints:masBlockLabel];
}

@end
