//
//  HyprUserUser.m
//  
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "HyprUserUser.h"

@implementation HyprUserUser

@synthesize appKey;
@synthesize emailAddress;
@synthesize hyprUserUserId;
@synthesize passwordHash;
@synthesize reginstrationTime;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.appKey forKey:@"appKey"];
    [encoder encodeObject:self.emailAddress forKey:@"emailAddress"];
    [encoder encodeObject:self.hyprUserUserId forKey:@"hyprUserUserId"];
    [encoder encodeObject:self.passwordHash forKey:@"passwordHash"];
    [encoder encodeObject:self.reginstrationTime forKey:@"reginstrationTime"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.appKey = [decoder decodeObjectForKey:@"appKey"];
        self.emailAddress = [decoder decodeObjectForKey:@"emailAddress"];
        self.hyprUserUserId = [decoder decodeObjectForKey:@"hyprUserUserId"];
        self.passwordHash = [decoder decodeObjectForKey:@"passwordHash"];
        self.reginstrationTime = [decoder decodeObjectForKey:@"reginstrationTime"];
    }
    return self;
}

+ (HyprUserUser *)instanceFromDictionary:(NSDictionary *)aDictionary
{

    HyprUserUser *instance = [[HyprUserUser alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary
{

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    self.appKey = [aDictionary objectForKey:@"app_key"];
    self.emailAddress = [aDictionary objectForKey:@"email_address"];
    self.hyprUserUserId = [aDictionary objectForKey:@"id"];
    self.passwordHash = [aDictionary objectForKey:@"password_hash"];
    self.reginstrationTime = [aDictionary objectForKey:@"reginstration_time"];

}

- (NSDictionary *)dictionaryRepresentation
{

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.appKey) {
        [dictionary setObject:self.appKey forKey:@"appKey"];
    }

    if (self.emailAddress) {
        [dictionary setObject:self.emailAddress forKey:@"emailAddress"];
    }

    if (self.hyprUserUserId) {
        [dictionary setObject:self.hyprUserUserId forKey:@"hyprUserUserId"];
    }

    if (self.passwordHash) {
        [dictionary setObject:self.passwordHash forKey:@"passwordHash"];
    }

    if (self.reginstrationTime) {
        [dictionary setObject:self.reginstrationTime forKey:@"reginstrationTime"];
    }

    return dictionary;

}

@end
