//
//  HyprTextSettingsViewController.h
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FCColorPickerViewController.h"
#import "HyprSettingsTextFieldViewController.h"
#import "FontSelectorMenu.h"

@class HyprTextWidget;

@interface HyprTextSettingsViewController : UITableViewController<ColorPickerViewControllerDelegate, HyprSettingsTextFieldProtocol, FontSelectorDelegate>
{
    int indexBeingChanged;
}

@property(nonatomic,strong)HyprTextWidget *widget;
@property (strong, nonatomic) IBOutlet UIStepper *fontSizeStepper;

@end
