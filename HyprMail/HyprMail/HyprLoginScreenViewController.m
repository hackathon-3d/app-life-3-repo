//
//  HyprLoginScreenViewController.m
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "HyprLoginScreenViewController.h"
#import "SessionManager.h"

@interface HyprLoginScreenViewController ()

@end

@implementation HyprLoginScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.loginButton setBackgroundImage:[[UIImage imageNamed:@"buttonCoral.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
}

-(IBAction)attemptLogin:(id)sender
{
    self.signincontainer.userInteractionEnabled = NO;
    [self.loginPassword resignFirstResponder];
    [self.loginUser resignFirstResponder];
    
    [self.spinny startAnimating];
    
    [[SessionManager sharedSession] attemptLoginWithUser:self.loginUser.text password:self.loginPassword.text completion:^(BOOL success, NSString *errorMessage) {
        if (success) {
            
            //First, let's animate out our stuff.
            [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{

                    int pick = arc4random() %2;
                    
                    self.signincontainer.center = CGPointMake(self.signincontainer.center.x, self.view.bounds.size.height+(self.signincontainer.frame.size.height/1.5));
                    self.signincontainer.transform = CGAffineTransformMakeRotation((pick==0 ? -(M_PI_4/2.0) : (M_PI_4/2.0)));
                
                
            } completion:^(BOOL finished) {
                
                //Now session manager should be notified to continue
                [[SessionManager sharedSession] switchToTemplatePicker];
            }];

            
            NSLog(@"Login Success");
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
            self.signincontainer.userInteractionEnabled = YES;
            [self.spinny stopAnimating];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
