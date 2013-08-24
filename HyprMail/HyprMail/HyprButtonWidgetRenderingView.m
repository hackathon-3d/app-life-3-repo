//
//  HyprButtonWidgetRenderingView.m
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "HyprButtonWidgetRenderingView.h"
#import "HyprButtonWidget.h"
#import <QuartzCore/QuartzCore.h>

@implementation HyprButtonWidgetRenderingView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self.widget.buttonColor set];
    
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5.0] fill];
    //CGContextFillRect(UIGraphicsGetCurrentContext(), rect);
    
    [self.widget.color set];
    
    CGSize textSize = [self.widget.text sizeWithFont:self.widget.font constrainedToSize:rect.size lineBreakMode:NSLineBreakByWordWrapping];
    
    //Now we can draw this in a calculated rect, vertically centered.
    [self.widget.text drawInRect:CGRectMake(rect.origin.x+((rect.size.width-textSize.width)/2.0), rect.origin.y+((rect.size.height - textSize.height)/2.0), textSize.width, textSize.height) withFont:self.widget.font lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
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
