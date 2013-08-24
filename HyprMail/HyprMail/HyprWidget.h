//
//  HyprWidget.h
//  HyprMail
//
//  Created by Brendan Lee on 8/23/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPUserResizableView.h"


@class HyprEditorViewController;

@interface HyprWidget : NSObject<SPUserResizableViewDelegate, UIGestureRecognizerDelegate, UIPopoverControllerDelegate>

@property(nonatomic,strong)SPUserResizableView *view;

@property(nonatomic,assign)int x;
@property(nonatomic,assign)int y;
@property(nonatomic,assign)int width;
@property(nonatomic,assign)int height;

@property(nonatomic,strong)NSString *UUID;
@property(nonatomic,strong)NSString *typeName;

@property(nonatomic,strong)NSString *link; //If nil, no link...therefore not clickable in the image map.

@property(nonatomic,strong)UITapGestureRecognizer *tapRecog;
@property(nonatomic,strong)UILongPressGestureRecognizer *settingsTapRecog;

@property(nonatomic,strong)UIPopoverController *popover;

@property(nonatomic,weak)HyprEditorViewController *editor;

-(id)initWithDocumentEditor:(HyprEditorViewController*)editor withInitialLocation:(CGRect)location;

-(void)beginResizing;
-(void)endResizing;
-(void)clearPopover;

@end
