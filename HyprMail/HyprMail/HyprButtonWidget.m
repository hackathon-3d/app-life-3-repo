//
//  HyprButtonWidget.m
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "HyprButtonWidget.h"
#import "HyprButtonWidgetRenderingView.h"
#import "HyprButtonCustomizerPopoverViewController.h"

@implementation HyprButtonWidget

-(id)initWithDocumentEditor:(HyprEditorViewController*)editor withInitialLocation:(CGRect)location initialText:(NSString*)text initialColor:(UIColor*)color initialFont:(UIFont*)font initialButtonColor:(UIColor*)buttonColor
{
    self = [super initWithDocumentEditor:editor withInitialLocation:location initialText:text initialColor:color initialFont:font];
    
    if (self) {
        self.buttonColor = buttonColor;
        
        HyprButtonWidgetRenderingView *render = [[HyprButtonWidgetRenderingView alloc] initWithFrame:location];
        render.widget = self;
        render.backgroundColor = [UIColor clearColor];
        render.opaque = NO;
        self.view.contentView = render;
        
        self.typeName = @"Button";
        
    }
    
    return self;
}

-(void)openSettings
{
    HyprButtonCustomizerPopoverViewController *customizer = [[HyprButtonCustomizerPopoverViewController alloc] initWithNibName:@"HyprButtonCustomizerPopoverViewController" bundle:nil];
    customizer.widget = self;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:customizer];
    
    [self clearPopover];
    
    self.popover = [[UIPopoverController alloc] initWithContentViewController:nav];
    self.popover.delegate = self;
    [self.popover presentPopoverFromRect:self.view.frame inView:self.view.superview permittedArrowDirections:UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight animated:YES];
}
@end
