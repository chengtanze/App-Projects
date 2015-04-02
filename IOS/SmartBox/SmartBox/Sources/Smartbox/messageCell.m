//
//  messageCell.m
//  Smartbox
//
//  Created by Mesada on 14/12/27.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#define kMargin 10 //间隔
#define kIconWH 40 //头像宽高
#define kContentW 180 //内容宽度

#define kTimeMarginW 15 //时间文本与边框间隔宽度方向
#define kTimeMarginH 10 //时间文本与边框间隔高度方向

#define kContentTop 10 //文本内容与按钮上边缘间隔
#define kContentLeft 25 //文本内容与按钮左边缘间隔
#define kContentBottom 15 //文本内容与按钮下边缘间隔
#define kContentRight 10 //文本内容与按钮右边缘间隔

#define kTimeFont [UIFont systemFontOfSize:12] //时间字体
#define kContentFont [UIFont systemFontOfSize:16] //内容字体

#import "messageCell.h"

@implementation messageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMessage:(Message *)message
{
    // 1、设置时间
//    _timeLable.text = message.time;
    _timeLable.text = @"12345";
    // 2、设置头像
    _iconView.image = [UIImage imageNamed:message.icon];
    
    CGFloat buttonWidth = _contentBtn.frame.size.width;
    // 3、设置内容
    [_contentBtn setTitle:message.content forState:UIControlStateNormal];
    
    _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentLeft, kContentBottom, kContentRight);

    static UIImage *normal = nil;
    
    if (!normal) {
        normal = [UIImage imageNamed:@"4-4SMART-BOX-消息_框-ios.png"];
        
        normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(49, 35, 7, 20) resizingMode:UIImageResizingModeStretch];

    }
//    focused = [UIImage imageNamed:@"chatto_bg_focused.png"];
//    focused = [focused stretchableImageWithLeftCapWidth:focused.size.width * 0.5 topCapHeight:focused.size.height * 0.7];

    [_contentBtn setBackgroundImage:normal forState:UIControlStateNormal];
//    [_contentBtn setBackgroundImage:normal forState:UIControlStateHighlighted];
   NSLog(@"_contentBtn ContentSize.height=%f", _contentBtn.intrinsicContentSize.height);
//   [_contentBtn invalidateIntrinsicContentSize];
    NSLog(@"_contentBtn ContentSize.height=%f", _contentBtn.intrinsicContentSize.height);
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:message.content];
    
    NSRange allRange = [message.content rangeOfString:message.content];
    [attrStr addAttribute:NSFontAttributeName
                    value:_contentBtn.titleLabel.font
                    range:allRange];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor blackColor]
                    range:allRange];
    
    NSRange destRange = [message.content rangeOfString:message.content];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor blackColor]
                    range:destRange];
    
    
   NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading| NSStringDrawingUsesFontLeading
;
    CGSize btnSize = [attrStr boundingRectWithSize:CGSizeMake(buttonWidth-kContentLeft-kContentRight, 0)
                                        options:options
                                        context:nil].size;

    btnSize.height = ceil(btnSize.height);
    
   _btheightConstraint.constant = btnSize.height + kContentTop + kContentBottom;
    
//    _contentBtn.frame = CGRectMake(_contentBtn.frame.origin.x, _contentBtn.frame.origin.y, btnSize.width + kContentLeft + kContentRight, btnSize.height + kContentTop + kContentBottom);
    
    // 4、计算高度
    _cellHeight = MAX(_contentBtn.frame.origin.y+btnSize.height + kContentTop + kContentBottom, CGRectGetMaxY(_iconView.frame))  + kMargin;
}
@end
