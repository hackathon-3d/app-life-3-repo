//
//  HyprTextWidget.m
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "HyprTextWidget.h"
#import "HyprTextWidgetRenderingView.h"
#import "HyprTextSettingsViewController.h"

@implementation HyprTextWidget

-(id)initWithDocumentEditor:(HyprEditorViewController*)editor withInitialLocation:(CGRect)location initialText:(NSString*)text initialColor:(UIColor*)color initialFont:(UIFont *)font
{
    self = [super initWithDocumentEditor:editor withInitialLocation:location];
    
    if (self) {
        self.text = text;
        self.color = color;
        self.font = font;
        self.textAlign = NSTextAlignmentLeft;
        
        HyprTextWidgetRenderingView *renderView = [[HyprTextWidgetRenderingView alloc] initWithFrame:location];
        renderView.widget = self;
        renderView.opaque = NO;
        renderView.backgroundColor = [UIColor clearColor];
        
        self.view.contentView = renderView;
        
        self.typeName = @"Text";

    }

    return self;
}

-(void)openSettings
{
    HyprTextSettingsViewController *customizer = [[HyprTextSettingsViewController alloc] initWithNibName:@"HyprTextSettingsViewController" bundle:nil];
    customizer.widget = self;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:customizer];
    
    [self clearPopover];
    
    self.popover = [[UIPopoverController alloc] initWithContentViewController:nav];
    self.popover.delegate = self;
    [self.popover presentPopoverFromRect:self.view.frame inView:self.view.superview permittedArrowDirections:UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight animated:YES];
}

@end
