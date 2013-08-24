//
//  HyprEditorViewController.h
//  HyprMail
//
//  Created by Brendan Lee on 8/23/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "FCColorPickerViewController.h"


@class HyprImageWidget;
@class HyprTextWidget;
@class HyprButtonWidget;
@class HyprWidget;

@interface HyprEditorViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, UIActionSheetDelegate, ColorPickerViewControllerDelegate, UIPopoverControllerDelegate>
{
    int documentPropertiesAlter;
}

//Temp operations for dragging
@property(nonatomic,strong)UIImageView *tempDragImageView;
@property(nonatomic,assign)BOOL tempDrawWasLastInTableView;
@property(nonatomic,assign)int tempDragIndex;
@property(nonatomic,assign)BOOL tempDragActive;

@property(nonatomic,strong)NSMutableArray *availableWidgets;
@property(nonatomic,strong)NSMutableArray *onscreenWidgets;

@property (strong, nonatomic) IBOutlet UITableView *widgetTableView;
@property (strong, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property(nonatomic,strong)UIView *pageTopIllusionView;
@property(nonatomic,strong)UIView *pageBottomIllusionView;

@property(nonatomic,strong)NSDictionary *theme;

@property(nonatomic,strong)UIColor *pageColor;
@property(nonatomic,strong)UIColor *documentColor;

@property(nonatomic,strong)UIPopoverController *popover;
@property (strong, nonatomic) IBOutlet UIButton *pageSettignsButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withThemePack:(NSDictionary*)theme;
-(void)deleteWidget:(HyprWidget*)widget;

@end
