//
//  SessionManager.h
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "HyprUser.h"
#import "EmailList.h"
#import "HyprUserUser.h"

typedef void (^LoginResultBlock)(BOOL success, NSString *errorMessage);

@interface SessionManager : NSObject

@property(nonatomic,strong)AFHTTPClient *APIClient;

@property(nonatomic,strong)NSString*app_key;

@property(nonatomic,strong)HyprUser *currentUser;


+(SessionManager*)sharedSession;

-(void)attemptLoginWithUser:(NSString*)user password:(NSString*)password completion:(LoginResultBlock)completion;

-(void)switchToTemplatePicker;
-(void)uploadHtml:(NSString*)html toEmailList:(int)listID withSubject:(NSString*)subject moreAddresses:(NSString*)addresses completion:(LoginResultBlock)completion;
-(void)switchToLogin;

@end
