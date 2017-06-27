//
//  JZGCarStyleView.m
//  JingZhenGu
//
//  Created by Mars on 15/12/28.
//  Copyright © 2015年 Mars. All rights reserved.
//

#import "JZGCarStyleView.h"
#define kBrandViewWidth 70

@interface JZGCarStyleView(){
    
}

@property (weak, nonatomic) UIImageView *lineImageView;

@property (assign, nonatomic) CGFloat lineWidth;
@property (assign, nonatomic) CGFloat toggleWidth;

@end

@implementation JZGCarStyleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *bImage = [UIImage imageNamed:@"re_product_pan_b"];
        self.lineWidth = bImage.size.width;
        UIImageView *bImageView = [[UIImageView alloc] initWithImage:bImage];
        CGRect bImageFrame = CGRectMake(13.5, 0, bImage.size.width, self.bounds.size.height);
        bImageView.frame = bImageFrame;
        bImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.lineImageView = bImageView;
        [self addSubview:bImageView];
        
        UIImage *image = [UIImage imageNamed:@"re_prduct_pan_toggle"];
        self.toggleWidth = image.size.width;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        CGFloat y = (self.bounds.size.height - image.size.height)/2.0;
        imageView.frame = CGRectMake(0, y, image.size.width, image.size.height);
        _toggleView = imageView;
        [self addSubview:imageView];
        
//        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
//        [self addGestureRecognizer:pan];
    }
    return self;
}

- (void)setLineAndToggle
{
    UIImage *bImage = [UIImage imageNamed:@"re_product_pan_b"];
    CGRect bImageFrame = CGRectMake(13.5, 0, bImage.size.width, self.bounds.size.height);
    _lineImageView.frame = bImageFrame;
    
    UIImage *image = [UIImage imageNamed:@"re_prduct_pan_toggle"];
    CGFloat y = (self.bounds.size.height - image.size.height)/2.0;
    _toggleView.frame = CGRectMake(0, y, image.size.width, image.size.height);
    _toggleView.image = image;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    UIImageView *img = _toggleView;
    CGFloat y = (self.bounds.size.height - img.image.size.height)/2.0;
    img.frame = CGRectMake(0, y, img.image.size.width, img.image.size.height);
}

+ (JZGCarStyleView *)initializeCarStyleView:(UIView *)carStyleView
{
    JZGCarStyleView *carStyle = [[JZGCarStyleView alloc] init];
    carStyle.carStyleView = carStyleView;
    
    return carStyle;
}

-(void)show{
    [self hideContent:NO];
}

-(void)hide{
    [self hideContent:YES];
}

- (void)showAndHidden
{
    [UIView animateWithDuration:0.3 animations:^{
        _carStyleView.transform = CGAffineTransformIdentity;
        _toggleView.transform = CGAffineTransformIdentity;
        _lineImageView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        // 加载车系数据
//        _carStyleView.transform = CGAffineTransformMakeTranslation((kScreenWidth - kBrandViewWidth), 0);
//        _toggleView.transform = CGAffineTransformMakeTranslation(0, 0);
//        _lineImageView.transform = CGAffineTransformMakeTranslation(((kScreenWidth - kBrandViewWidth)), 0);
    }];

}

- (void)hiddenAndShow
{
    [UIView animateWithDuration:0.3 animations:^{
        _carStyleView.transform = CGAffineTransformIdentity;
        _toggleView.transform = CGAffineTransformIdentity;
        _lineImageView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        // 加载车系数据
        _carStyleView.transform = CGAffineTransformMakeTranslation(-(kScreenWidth - kBrandViewWidth), 0);
        _toggleView.transform = CGAffineTransformMakeTranslation(-(kScreenWidth - kBrandViewWidth), 0);
        _lineImageView.transform = CGAffineTransformMakeTranslation(-(kScreenWidth - kBrandViewWidth) , 0);
    }];
}

-(void)pan:(UIPanGestureRecognizer *)gestureRecognizer
{
    
    
    CGPoint location = [gestureRecognizer locationInView:self.superview];
    CGFloat x = location.x;
    NSLog(@"x ===== %f",x);
    UIGestureRecognizerState state = gestureRecognizer.state;
    
    BOOL animated = NO;
    if (state == UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateCancelled) {
        
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat maxX = kBrandViewWidth + (maxWidth - kBrandViewWidth)/2.0;
        
        if (x <= maxX) {
            x = kBrandViewWidth;
        } else {
            x = self.superview.bounds.size.width;
        }
        animated = YES;
        
    } else if (state == UIGestureRecognizerStateChanged) {
        CGFloat offset = x - kBrandViewWidth;;
        if (offset < 0) {
            x = x - offset/2.0;
        } else {
            animated = YES;
        }
    }

    if (animated) {
        [self hiddenAndShow];
    }else
        [self showAndHidden];
    
}

/*
-(void)pan:(UIPanGestureRecognizer *)gestureRecognizer{
    CGPoint location = [gestureRecognizer locationInView:self.superview];
    CGFloat x = location.x;
    
    UIGestureRecognizerState state = gestureRecognizer.state;
    
    BOOL animated = NO;
    if (state == UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateCancelled) {
        
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat maxX = kBrandViewWidth + (maxWidth - kBrandViewWidth)/2.0;
        
        if (x <= maxX) {
            x = kBrandViewWidth;
        } else {
            x = self.superview.bounds.size.width;
        }
        animated = YES;
        
    } else if (state == UIGestureRecognizerStateChanged) {
        CGFloat offset = x - kBrandViewWidth;;
        if (offset < 0) {
            x = x - offset/2.0;
        } else {
            animated = YES;
        }
    }
    
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.center = CGPointMake(x- self.bounds.size.width/2.0, self.center.y);
            
            CGRect rect =  _carStyleView.frame;
            rect.origin.x = x;
            _carStyleView.frame = rect;
            _toggleView.X = 0;
            _lineImageView.X = _toggleView.X + 13.5;
            
            [self hiddenAndShow];

        }];
        return;
    }
    self.center = CGPointMake(x, self.center.y);
    
    CGRect rect =  _carStyleView.frame;
    rect.origin.x = CGRectGetMaxX(self.frame);
    _carStyleView.frame = rect;
}
 */

- (void)hideContent:(BOOL)hidden {
    CGRect frame =  _carStyleView.frame;
    CGRect hideFrame = frame;
    
    CGRect showFrame = frame;
    
    hideFrame.origin.x = self.superview.bounds.size.width;
    showFrame.origin.x = kBrandViewWidth;
    
    if (hidden) {
        [UIView animateWithDuration:0.2 animations:^{
            _carStyleView.frame = hideFrame;
            _carStyleView.backgroundColor = [UIColor redColor];
            _toggleView.x = kScreenWidth - kBrandViewWidth;
            _lineImageView.x = _toggleView.x+13.5;
          
            
        } completion:^(BOOL finished) {
//            _carStyleView.hidden = hidden;
//            self.hidden = hidden;
            
        }];
    } else {
        BOOL animateRightContentView = !CGRectEqualToRect(showFrame,  _carStyleView.frame);
        
        CGRect rect =  self.frame;
        rect.origin.x = CGRectGetMinX(showFrame) - rect.size.width;
        BOOL animatePan = !CGRectEqualToRect(rect, self.frame);
        if (!animatePan && !animateRightContentView) {
            return;
        }
        _carStyleView.frame = hideFrame;
        _carStyleView.hidden = NO;
        self.hidden = NO;
        [UIView animateWithDuration:0.2 animations:^{
            if (animateRightContentView) {
                _carStyleView.frame = showFrame;
                _toggleView.x = 0;
                _lineImageView.x = 13.5;
            }
            if (animatePan) {
                self.frame = rect;
            }
        } completion:nil];
    }
    
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    CGRect frame = _toggleView.frame;
    frame = CGRectInset(frame, - 5, 0);
    return  CGRectContainsPoint(frame, point);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
