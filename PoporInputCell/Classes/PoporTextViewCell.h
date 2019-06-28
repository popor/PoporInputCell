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

@property (nonatomic, strong) UIButton * button;
@property (nonatomic, strong) UIPlaceHolderTextView * textView;

@property (nonatomic, strong) UIView * view1;
@property (nonatomic, strong) UIView * view2;
@property (nonatomic, strong) UIView * view3;
@property (nonatomic, strong) UIView * view4;

- (void)setMasBlockButton:(BlockPoporTextViewCell)masBlockButton masBlockTextView:(BlockPoporTextViewCell)masBlockTextView;

@end

NS_ASSUME_NONNULL_END
