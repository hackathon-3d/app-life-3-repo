//
//  HyprSettingsTextFieldViewController.h
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HyprSettingsTextFieldViewController;

@protocol HyprSettingsTextFieldProtocol <NSObject>

-(void)textDidChangeTo:(NSString *)text fromEditor:(HyprSettingsTextFieldViewController*)editor;

@end

@interface HyprSettingsTextFieldViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *textView;

@property(nonatomic,strong)id<HyprSettingsTextFieldProtocol>textDelegate;
@end
