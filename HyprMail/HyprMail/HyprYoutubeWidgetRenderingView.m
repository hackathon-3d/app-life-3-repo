//
//  HyprYoutubeWidgetRenderingView.m
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "HyprYoutubeWidgetRenderingView.h"
#import "HyprYoutubeWidget.h"
#import <QuartzCore/QuartzCore.h>

@implementation HyprYoutubeWidgetRenderingView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        imageView.image = [UIImage imageNamed:@"play.png"];
        imageView.contentMode = UIViewContentModeCenter;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:imageView];
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    [[UIColor blackColor] set];
    CGContextFillRect(UIGraphicsGetCurrentContext(), rect);
    
    [self.widget.youTubeImage drawInRect:rect];
    
    
}

-(void)layoutSubviews
{
    [self setNeedsDisplay];
}



@end
