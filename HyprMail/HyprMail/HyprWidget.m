//
//  HyprWidget.m
//  HyprMail
//
//  Created by Brendan Lee on 8/23/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "HyprWidget.h"
#import "HyprEditorViewController.h"

@implementation HyprWidget

-(id)initWithDocumentEditor:(HyprEditorViewController*)editor withInitialLocation:(CGRect)location
{
    self = [self init];
    
    if(self)
    {
        self.view = [[SPUserResizableView alloc] initWithFrame:location];
        self.view.delegate = self;
        //Gestures for double tapping in the content view
        
        self.tapRecog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizerDidActiveate:)];
        self.tapRecog.numberOfTapsRequired = 2;
        self.tapRecog.delegate = self;
        self.tapRecog.delaysTouchesBegan = NO;
        self.tapRecog.delaysTouchesEnded = NO;
        self.tapRecog.cancelsTouchesInView = YES;
        
        self.settingsTapRecog = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(openSettings)];
        self.settingsTapRecog.delegate = self;
        self.settingsTapRecog.delaysTouchesBegan = NO;
        self.settingsTapRecog.delaysTouchesEnded = NO;
        self.settingsTapRecog.cancelsTouchesInView = YES;
        
        self.x = location.origin.x;
        self.y = location.origin.y;
        self.width = location.size.width;
        self.height = location.size.height;
        
        self.UUID = [[NSUUID UUID] UUIDString];
        
        [self.view addGestureRecognizer:self.tapRecog];
        [self.view addGestureRecognizer:self.settingsTapRecog];

    }
    
    return self;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}

-(void)gestureRecognizerDidActiveate:(UIGestureRecognizer*)gesture
{
    //This can only activate while drag handles are active....so we should disable them.
    if(self.view.canResize)
    {
        [self endResizing];
    }
    else
    {
        [self beginResizing];
    }
}

-(void)dealloc
{
    [self.view removeGestureRecognizer:self.tapRecog];
    self.view.delegate = nil;
    self.tapRecog = nil;
    self.view.contentView = nil;
    self.view = nil;
}

// Called when the resizable view receives touchesBegan: and activates the editing handles.
- (void)userResizableViewDidBeginEditing:(SPUserResizableView *)userResizableView
{
    NSLog(@"Now editing %@: %@", self.typeName, self.UUID);
}

// Called when the resizable view receives touchesEnded: or touchesCancelled:
- (void)userResizableViewDidEndEditing:(SPUserResizableView *)userResizableView
{
    CGRect globalFrame = [self.view.superview convertRect:self.view.contentView.frame fromView:self.view];
    
    self.x  = globalFrame.origin.x;
    self.y = globalFrame.origin.y;
    self.width = globalFrame.size.width;
    self.height = globalFrame.size.height;
    
    
    NSLog(@"Done editing %@: %@", self.typeName, self.UUID);
}

-(void)beginResizing
{
    self.view.canResize = YES;
    [self.view showEditingHandles];
}

-(void)endResizing
{
    self.view.canResize = NO;
    [self.view hideEditingHandles];
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [self clearPopover];
}

-(void)clearPopover
{
    if (self.popover) {
        if (self.popover.isPopoverVisible) {
            [self.popover dismissPopoverAnimated:NO];
        }
        self.popover.delegate = nil;
        self.popover = nil;
    }
}

-(void)openSettings
{
    NSLog(@"Override this implementation!");
}

@end
