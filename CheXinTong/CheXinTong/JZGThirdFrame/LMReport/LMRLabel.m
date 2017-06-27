//
//  LMRLabel.m
//
//  Created by Chenly on 15/2/27.
//  Copyright (c) 2015年 Chenly. All rights reserved.
//

#import "LMRLabel.h"

@implementation LMRLabel

- (void)drawRect:(CGRect)rect {
    
    if (self.image) {        
        self.clipsToBounds = YES;
        [self.image drawInRect:rect];
        return;
    }
    if (self.text.length > 0) {
        NSMutableAttributedString *multableAttributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        NSRange range = NSMakeRange(0, multableAttributedText.length);
        [multableAttributedText addAttribute:NSUnderlineStyleAttributeName
                                       value:(self.underline ? @(NSUnderlineStyleSingle) : @(NSUnderlineStyleNone))
                                       range:range];
        [multableAttributedText addAttribute:NSUnderlineColorAttributeName
                                       value:self.textColor
                                       range:range];
        
        if (self.text.length <= 20) {
            //字条串是否包含有\n
            if ([self.text rangeOfString:@"\n"].location == NSNotFound) {
//                NSLog(@"string 不存在 martin");
            } else {
                NSRange range1;
                range1 = [self.text rangeOfString:@"\n"];
                [multableAttributedText addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(range1.location + range1.length, range.length - range1.length - range1.location )];
            }
        } else {
        //字条串是否包含有\n
        if ([self.text rangeOfString:@"\n"].location == NSNotFound) {
            NSLog(@"string 不存在 martin");
        } else {
            //分割字符串
            NSArray *arr = [self.text componentsSeparatedByString:@"\n"];
            //                self.text = arr[0];
            //第1个DetailLabel
            UILabel *detailLabel = [[UILabel alloc] init];
            detailLabel.frame = CGRectMake(0,5, self.width, 30);
            //更改10.08.10
//            detailLabel.frame = CGRectMake(0,self.height/2 - 15, self.width, 13);
//            detailLabel.numberOfLines = 1;
            detailLabel.text = arr[0];
            detailLabel.font = FONT_SIZE(12);
            detailLabel.textAlignment = NSTextAlignmentLeft;
            detailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            detailLabel.numberOfLines = 0;
            [self addSubview:detailLabel];
            //第2个DetailLabel
            UILabel *detailLabel2 = [[UILabel alloc] init];
            detailLabel2.frame = CGRectMake(0,self.height/2, self.width, 30);
            //更改10.08.10
//            detailLabel2.frame = CGRectMake(0,self.height/2 + 2, self.width, 13);
//            detailLabel2.numberOfLines = 1;

            detailLabel2.text = arr[1];
            detailLabel2.textAlignment = NSTextAlignmentLeft;
            detailLabel2.textColor = [UIColor lightGrayColor];
            detailLabel2.numberOfLines = 0;
            detailLabel2.font = FONT_SIZE(12);
            [self addSubview:detailLabel2];
        }
        }
        self.attributedText = [multableAttributedText copy];
    }


    [super drawRect:rect];
}

- (void)heightToFit {
    if (self.text.length == 0) {
        return;
    }
    else {
        CGFloat height = [self.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.bounds), 0)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{
                                                           NSFontAttributeName: self.font,
                                                           NSUnderlineColorAttributeName: @(self.underline)
                                                           }
                                                 context:nil].size.height;
        if (height > CGRectGetHeight(self.frame)) {
            CGRect rect = self.frame;
            rect.size.height = roundf(height + 0.5f);
            self.frame = rect;
        }        
    }
}

@end
