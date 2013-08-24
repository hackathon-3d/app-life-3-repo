//
//  HyprUser.m
//  
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "HyprUser.h"

#import "EmailList.h"
#import "HyprUserUser.h"

@implementation HyprUser

@synthesize emailLists;
@synthesize user;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.emailLists forKey:@"emailLists"];
    [encoder encodeObject:self.user forKey:@"user"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.emailLists = [decoder decodeObjectForKey:@"emailLists"];
        self.user = [decoder decodeObjectForKey:@"user"];
    }
    return self;
}

+ (HyprUser *)instanceFromDictionary:(NSDictionary *)aDictionary
{

    HyprUser *instance = [[HyprUser alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary
{

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }


    NSArray *receivedEmailLists = [aDictionary objectForKey:@"email_lists"];
    if ([receivedEmailLists isKindOfClass:[NSArray class]]) {

        NSMutableArray *populatedEmailLists = [NSMutableArray arrayWithCapacity:[receivedEmailLists count]];
        for (NSDictionary *item in receivedEmailLists) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [populatedEmailLists addObject:[EmailList instanceFromDictionary:item]];
            }
        }

        self.emailLists = populatedEmailLists;

    }
    self.user = [HyprUserUser instanceFromDictionary:[aDictionary objectForKey:@"user"]];

}

- (NSDictionary *)dictionaryRepresentation
{

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.emailLists) {
        [dictionary setObject:self.emailLists forKey:@"emailLists"];
    }

    if (self.user) {
        [dictionary setObject:self.user forKey:@"user"];
    }

    return dictionary;

}

@end
