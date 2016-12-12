//
//  DynamicLabel.m
//  DynamicLabel
//
//  Created by henvy on 12/12/2016.
//  Copyright © 2016 henvy. All rights reserved.
//

#import "DynamicLabel.h"

@interface DynamicLabel()
@property(nonatomic, strong) UILabel* contentLabel;
@property(nonatomic, assign) BOOL isAnimation;
@end

@implementation DynamicLabel
- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        UILabel* contentLabel = [[UILabel alloc] init];
        [contentLabel sizeToFit];
        contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel = contentLabel;
    }
    return _contentLabel;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.contentLabel];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(layoutSubviews) name:UIApplicationWillEnterForegroundNotification object:[UIApplication sharedApplication]];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    CAShapeLayer* maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    self.layer.mask = maskLayer;
}

- (void)setText:(NSString *)text
{
    self.contentLabel.text = text;
    
    [self.contentLabel sizeToFit];
    
}

- (void)setFont:(UIFont *)font
{
    self.contentLabel.font = font;
    [self.contentLabel sizeToFit];
    
    CGRect frame = self.frame;
    if (frame.size.height < font.lineHeight) {
        frame.size.height = font.lineHeight;
        self.frame = frame;
    }
    
}

- (void)setTextColor:(UIColor *)textColor
{
    self.contentLabel.textColor = textColor;
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    
    [self addAnimation];
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.isAnimation) {
        [self addAnimation];
    }
}


- (void)addAnimation
{
    if (self.frame.size.width >= self.contentLabel.frame.size.width) {
        return;
    }
    
    [self.contentLabel.layer removeAllAnimations];
    
    CGFloat space = self.contentLabel.frame.size.width - self.frame.size.width;
    
    CAKeyframeAnimation* keyFrame = [CAKeyframeAnimation animation];
    keyFrame.keyPath = @"transform.translation.x";
    keyFrame.values = @[@(0), @(-space), @(0)];
    keyFrame.repeatCount = NSIntegerMax;
    keyFrame.duration = self.speed * self.contentLabel.text.length;
    keyFrame.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithControlPoints:0 :0 :0.5 :0.5]];
    keyFrame.delegate = self;
    
    [self.contentLabel.layer addAnimation:keyFrame forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.isAnimation = !flag;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
