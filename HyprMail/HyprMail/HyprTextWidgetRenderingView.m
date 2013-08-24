//
//  HyprTextWidgetRenderingView.m
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "HyprTextWidgetRenderingView.h"
#import "HyprTextWidget.h"

#import <QuartzCore/QuartzCore.h>

@implementation HyprTextWidgetRenderingView


-(void)drawRect:(CGRect)rect
{
    [[UIColor clearColor] set];
    CGContextFillRect(UIGraphicsGetCurrentContext(), rect);
    
    [self.widget.color set];
    [self.widget.text drawInRect:rect withFont:self.widget.font lineBreakMode:NSLineBreakByWordWrapping alignment:self.widget.textAlign];
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self setNeedsDisplay];
}

-(void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    
    [self setNeedsDisplay];
}

@end
