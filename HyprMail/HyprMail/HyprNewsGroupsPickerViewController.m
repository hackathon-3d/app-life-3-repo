//
//  HyprNewsGroupsPickerViewController.m
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "HyprNewsGroupsPickerViewController.h"

#import "SessionManager.h"
#import "MBProgressHUD.h"

@interface HyprNewsGroupsPickerViewController ()

@end

@implementation HyprNewsGroupsPickerViewController

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
    
    self.title = @"Select News Group";
    
    self.templatesContainer.frame = CGRectMake((self.scrollView.frame.size.width-self.templatesContainer.frame.size.width)/2.0, 60.0, 600.0, self.templatesContainer.frame.size.height);
    
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.templatesContainer.frame.size.height+60.0)];
    
    [self.scrollView addSubview:self.templatesContainer];
    
    self.scrollView.frame = CGRectMake(0, 0, 1024, 704);
    
    [self.view addSubview:self.scrollView];
    
    UIImage *coralIm = [[UIImage imageNamed:@"buttonCoral.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    UIImage *greyIm = [[UIImage imageNamed:@"buttonGrey.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    
    [self.makeItHappenButton setBackgroundImage:coralIm forState:UIControlStateNormal];
    [self.editEmailButton setBackgroundImage:greyIm forState:UIControlStateNormal];

    //Setup buttons
    
    NSArray * emailLists = [[[SessionManager sharedSession] currentUser] emailLists];
    
    if (emailLists.count>=1) {
        
        EmailList *currentList = emailLists[0];
        
        self.group1Label.text = currentList.listName;
        self.group1Button.hidden = NO;
        self.group1Label.hidden = NO;
    }
    else
    {
        self.group1Button.hidden = YES;
        self.group1Label.hidden = YES;
    }
    
    if (emailLists.count>=2) {
        
        EmailList *currentList = emailLists[1];
        
        self.group2Label.text = currentList.listName;
        self.group2Button.hidden = NO;
        self.group2Label.hidden = NO;
    }
    else
    {
        self.group2Button.hidden = YES;
        self.group2Label.hidden = YES;
    }
    
    if (emailLists.count>=3) {
        
        EmailList *currentList = emailLists[2];
        
        self.group3Label.text = currentList.listName;
        self.group3Button.hidden = NO;
        self.group3Label.hidden = NO;
    }
    else
    {
        self.group3Button.hidden = YES;
        self.group3Label.hidden = YES;
    }
    
    if (emailLists.count>=4) {
        
        EmailList *currentList = emailLists[3];
        
        self.group4Label.text = currentList.listName;
        self.group4Button.hidden = NO;
        self.group4Label.hidden = NO;
    }
    else
    {
        self.group4Button.hidden = YES;
        self.group4Label.hidden = YES;
    }
    
    if (emailLists.count>=5) {
        
        EmailList *currentList = emailLists[4];
        
        self.group5Label.text = currentList.listName;
        self.group5Button.hidden = NO;
        self.group5Label.hidden = NO;
    }
    else
    {
        self.group5Button.hidden = YES;
        self.group5Label.hidden = YES;
    }
    
    
}

-(IBAction)selectGroup:(UIButton*)sender
{
    self.group1Button.backgroundColor = [UIColor clearColor];
    self.group2Button.backgroundColor = [UIColor clearColor];
    self.group3Button.backgroundColor = [UIColor clearColor];
    self.group4Button.backgroundColor = [UIColor clearColor];
    self.group5Button.backgroundColor = [UIColor clearColor];
    
    sender.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
    
    if (sender==self.group1Button) {
        self.activeList = [[[SessionManager sharedSession] currentUser] emailLists][0];
    }
    
    if (sender==self.group2Button) {
        self.activeList = [[[SessionManager sharedSession] currentUser] emailLists][1];
    }
    
    if (sender==self.group3Button) {
        self.activeList = [[[SessionManager sharedSession] currentUser] emailLists][2];
    }
    
    if (sender==self.group4Button) {
        self.activeList = [[[SessionManager sharedSession] currentUser] emailLists][3];
    }
    
    if (sender==self.group5Button) {
        self.activeList = [[[SessionManager sharedSession] currentUser] emailLists][4];
    }
}

-(IBAction)sendEmail:(id)sender
{
    if (!self.activeList) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You must select a mailing group." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    self.templatesContainer.userInteractionEnabled = NO;
//    [self.spinny startAnimating];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.labelText = @"Sending Email";
    [self.view addSubview:hud];
    [hud show:YES];
    
    [[SessionManager sharedSession] uploadHtml:self.htmlContent toEmailList:[self.activeList.emailListId intValue]  withSubject:@"Hackathon 3D" moreAddresses:self.additionalEmailsField.text completion:^(BOOL success, NSString *errorMessage) {
       
        if (success) {
            [hud hide:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [hud hide:YES];
            self.templatesContainer.userInteractionEnabled = YES;
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
        
    }];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //Prep animation
    
    self.scrollView.frame = CGRectMake(0, 768, 1024, 704);
    
}

-(void)viewDidAppear:(BOOL)animated
{
    //Run animation
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.scrollView.frame = CGRectMake(0, 0.0, 1024, 704);
    } completion:^(BOOL finished) {
        
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
