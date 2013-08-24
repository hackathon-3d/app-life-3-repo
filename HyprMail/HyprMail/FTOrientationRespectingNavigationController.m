//
//  OrientationRespectingFTOrientationRespectingNavigationController.m


#import "FTOrientationRespectingNavigationController.h"

@interface FTOrientationRespectingNavigationController ()

@end

@implementation FTOrientationRespectingNavigationController

-(BOOL)shouldAutorotate
{
    return [self.visibleViewController shouldAutorotate];
}

-(NSUInteger)supportedInterfaceOrientations
{
    return [self.visibleViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.visibleViewController preferredInterfaceOrientationForPresentation];
}


@end
