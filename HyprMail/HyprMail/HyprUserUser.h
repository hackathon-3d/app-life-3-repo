//
//  HyprUserUser.h
//  
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HyprUserUser : NSObject <NSCoding> {
    NSString *appKey;
    NSString *emailAddress;
    NSString *hyprUserUserId;
    NSString *passwordHash;
    NSString *reginstrationTime;
}

@property (nonatomic, copy) NSString *appKey;
@property (nonatomic, copy) NSString *emailAddress;
@property (nonatomic, copy) NSString *hyprUserUserId;
@property (nonatomic, copy) NSString *passwordHash;
@property (nonatomic, copy) NSString *reginstrationTime;

+ (HyprUserUser *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
