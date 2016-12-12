//
//  DynamicLabel.h
//  DynamicLabel
//
//  Created by henvy on 12/12/2016.
//  Copyright © 2016 henvy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicLabel : UIView
@property(nonatomic, copy) NSString* text;
@property(nonatomic, strong) UIColor* textColor;
@property(nonatomic, strong) UIFont* font;
@property(nonatomic, assign) CGFloat speed;
@end
