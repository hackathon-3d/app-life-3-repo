//
//  HyprUser.h
//  
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HyprUserUser;

@interface HyprUser : NSObject <NSCoding> {
    NSArray *emailLists;
    HyprUserUser *user;
}

@property (nonatomic, copy) NSArray *emailLists;
@property (nonatomic, strong) HyprUserUser *user;

+ (HyprUser *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
