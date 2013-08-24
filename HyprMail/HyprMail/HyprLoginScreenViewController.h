//
//  HyprLoginScreenViewController.h
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HyprLoginScreenViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UITextField *loginUser;
@property (strong, nonatomic) IBOutlet UITextField *loginPassword;
@property (strong, nonatomic) IBOutlet UIView *signincontainer;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinny;

@end
