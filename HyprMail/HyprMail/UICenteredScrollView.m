//
//  UICenteredScrollView.m
//  


#import "UICenteredScrollView.h"

@implementation UICenteredScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

//-(void)addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
//{
//    [super addGestureRecognizer:gestureRecognizer];
//    
//    if([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]])
//    {
//        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer*)gestureRecognizer;
//        pan.minimumNumberOfTouches = 2;
////        pan.maximumNumberOfTouches = 2;
//    }
//}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    
//    if ([NSStringFromClass([touch.view class]) isEqualToString:@"MKAnnotationContainerView"] || [NSStringFromClass([touch.view class]) isEqualToString:@"UIWebBrowserView"]) {
//        return NO;
//    }
//    
//    return YES;
//}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return YES;
//}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(viewForZoomingInScrollView:)])
    {
        UIView *tileContainerView = [self.delegate viewForZoomingInScrollView:self];
        
        // center the image as it becomes smaller than the size of the screen
        CGSize boundsSize = self.bounds.size;
        CGRect frameToCenter = tileContainerView.frame;
        
        // center horizontally
        if (frameToCenter.size.width < boundsSize.width)
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
        else
            frameToCenter.origin.x = 0;
        
        // center vertically
        if (frameToCenter.size.height < boundsSize.height)
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
        else
            frameToCenter.origin.y = 0;
        
        tileContainerView.frame = frameToCenter;
    }
}


@end
