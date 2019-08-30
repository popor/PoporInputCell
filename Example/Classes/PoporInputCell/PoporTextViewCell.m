//
//  PoporTextViewCell.m
//  Masonry
//
//  Created by apple on 2019/6/26.
//

#import "PoporTextViewCell.h"

@implementation PoporTextViewCell

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
        [self addViews];
    }
    return self;
}

- (void)addViews {
    self.button = ({
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.contentView addSubview:button];
        
        button;
    });
    self.textView = ({
        UITextView_pPlaceHolder * tv = [UITextView_pPlaceHolder new];
        
        [self.contentView addSubview:tv];
        
        tv;
    });
    
    self.button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
}

- (void)setMasBlockButton:(BlockPoporTextViewCell)masBlockButton masBlockTextView:(BlockPoporTextViewCell)masBlockTextView {
    
    [self.button mas_makeConstraints:masBlockButton];
    [self.textView mas_makeConstraints:masBlockTextView];
}

@end
