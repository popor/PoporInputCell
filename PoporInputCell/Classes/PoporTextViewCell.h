//
//  PoporTextViewCell.h
//  Masonry
//
//  Created by apple on 2019/6/26.
//

#import <UIKit/UIKit.h>

#import <PoporUI/UIPlaceHolderTextView.h>
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BlockPoporTextViewCell) (MASConstraintMaker * make);

@interface PoporTextViewCell : UITableViewCell

//@property (nonatomic, copy  ) BlockPoporTextViewCell masBlockButton;
//@property (nonatomic, copy  ) BlockPoporTextViewCell masBlockTextView;

@property (nonatomic, strong) UIButton * button;
@property (nonatomic, strong) UIPlaceHolderTextView * textView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setMasBlockButton:(BlockPoporTextViewCell)masBlockButton masBlockTextView:(BlockPoporTextViewCell)masBlockTextView;


@end

NS_ASSUME_NONNULL_END
