//
//  SessionManager.m
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "SessionManager.h"
#import "AppDelegate.h"
#import "HyprTemplateSelectionViewController.h"
static SessionManager *sharedSession;

@implementation SessionManager

+(SessionManager*)sharedSession
{
    if (!sharedSession) {
        sharedSession = [[self alloc] init];
    }
    
    return sharedSession;
}

-(id)init
{
    self = [super init];
    
    if (self) {
        self.APIClient = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://ec2-54-224-138-99.compute-1.amazonaws.com/"]];
        self.APIClient.operationQueue.maxConcurrentOperationCount = 7;
    }
    
    return self;
}

-(void)attemptLoginWithUser:(NSString*)user password:(NSString*)password completion:(LoginResultBlock)completion
{
    
    AFJSONRequestOperation *loginRequest = [AFJSONRequestOperation JSONRequestOperationWithRequest:[self.APIClient requestWithMethod:@"POST" path:@"log_in.php" parameters:@{@"email": user, @"password": password}] success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSDictionary* result = (NSDictionary*)JSON;
        
        if (result && [result[@"status"] isEqualToString:@"Good"]) {
            
            //Save data
            self.app_key = result[@"app_key"];
            
            AFJSONRequestOperation *getUserData = [AFJSONRequestOperation JSONRequestOperationWithRequest:[self.APIClient requestWithMethod:@"POST" path:@"load_user_information.php" parameters:@{@"app_key" : self.app_key}] success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                
                NSDictionary* result = (NSDictionary*)JSON;

                if (result && result[@"user"]) {
                    
                    self.currentUser = [HyprUser instanceFromDictionary:result];
                    
                    if (completion) {
                        completion(YES, nil);
                    }
                }
                else
                {
                    if (completion) {
                        completion(NO, result[@"message"]);
                    }
                }
                
                
                
            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                if (completion) {
                    completion(NO, error.localizedDescription);
                }
            }];
            
            getUserData.JSONReadingOptions = NSJSONReadingAllowFragments;
            
            [self.APIClient enqueueHTTPRequestOperation:getUserData];
            
        }
        else
        {
            if (completion) {
                completion(NO, result[@"message"]);
            }
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        if (completion) {
            completion(NO, error.localizedDescription);
        }
    }];
    
    [self.APIClient enqueueHTTPRequestOperation:loginRequest];
    
}

-(void)uploadHtml:(NSString*)html toEmailList:(int)listID withSubject:(NSString*)subject moreAddresses:(NSString*)addresses completion:(LoginResultBlock)completion
{
    NSDictionary *dictionary = @{@"app_key": self.app_key,
                                 @"email_list_id" : [NSString stringWithFormat:@"%d", listID],
                                 @"email_html" : html,
                                 @"extra_addresses" : addresses};
    
    NSData *JSON = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:nil];
    
    //NSLog([[NSString alloc] initWithData:JSON encoding:NSUTF8StringEncoding]);
    NSMutableURLRequest *request = [self.APIClient requestWithMethod:@"POST" path:@"send_emails.php" parameters:nil];
    
    [request setHTTPBody:JSON];
    
    AFJSONRequestOperation *htmlUpload = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSDictionary *result = (NSDictionary*)JSON;
        
        if (result && [result[@"status"] isEqualToString:@"Good"]) {
            if (completion) {
                completion(YES, nil);
            }
        }
        else
        {
            if (completion) {
                completion(NO, result[@"message"]);
            }
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"%@", error.localizedDescription);
        
        if (completion) {
            completion(NO, error.localizedDescription);
        }
    }];
    
    [self.APIClient enqueueHTTPRequestOperation:htmlUpload];
    
}

-(void)switchToTemplatePicker
{
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    HyprTemplateSelectionViewController *templates = [[HyprTemplateSelectionViewController alloc] initWithNibName:@"HyprTemplateSelectionViewController" bundle:nil];
    
    del.window.rootViewController = templates;
    
    
}
@end
