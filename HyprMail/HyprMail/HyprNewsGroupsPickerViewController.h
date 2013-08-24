//
//  HyprNewsGroupsPickerViewController.h
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SessionManager.h"

@interface HyprNewsGroupsPickerViewController : UIViewController

@property(nonatomic,strong)NSString *htmlContent;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *templatesContainer;
@property (strong, nonatomic) IBOutlet UIButton *group1Button;
@property (strong, nonatomic) IBOutlet UIButton *group2Button;
@property (strong, nonatomic) IBOutlet UIButton *group3Button;
@property (strong, nonatomic) IBOutlet UIButton *group4Button;
@property (strong, nonatomic) IBOutlet UIButton *group5Button;
@property (strong, nonatomic) IBOutlet UITextField *additionalEmailsField;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinny;
@property (strong, nonatomic) IBOutlet UIButton *editEmailButton;
@property (strong, nonatomic) IBOutlet UIButton *makeItHappenButton;

@property (strong, nonatomic) IBOutlet UILabel *group1Label;
@property (strong, nonatomic) IBOutlet UILabel *group2Label;
@property (strong, nonatomic) IBOutlet UILabel *group3Label;
@property (strong, nonatomic) IBOutlet UILabel *group4Label;
@property (strong, nonatomic) IBOutlet UILabel *group5Label;

@property(nonatomic,strong)EmailList *activeList;
@end
