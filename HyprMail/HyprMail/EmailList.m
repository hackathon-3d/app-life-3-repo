//
//  EmailList.m
//  
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "EmailList.h"

@implementation EmailList

@synthesize emailListId;
@synthesize listName;
@synthesize userId;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.emailListId forKey:@"emailListId"];
    [encoder encodeObject:self.listName forKey:@"listName"];
    [encoder encodeObject:self.userId forKey:@"userId"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.emailListId = [decoder decodeObjectForKey:@"emailListId"];
        self.listName = [decoder decodeObjectForKey:@"listName"];
        self.userId = [decoder decodeObjectForKey:@"userId"];
    }
    return self;
}

+ (EmailList *)instanceFromDictionary:(NSDictionary *)aDictionary
{

    EmailList *instance = [[EmailList alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary
{

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    self.emailListId = [aDictionary objectForKey:@"id"];
    self.listName = [aDictionary objectForKey:@"list_name"];
    self.userId = [aDictionary objectForKey:@"user_id"];

}

- (NSDictionary *)dictionaryRepresentation
{

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.emailListId) {
        [dictionary setObject:self.emailListId forKey:@"emailListId"];
    }

    if (self.listName) {
        [dictionary setObject:self.listName forKey:@"listName"];
    }

    if (self.userId) {
        [dictionary setObject:self.userId forKey:@"userId"];
    }

    return dictionary;

}

@end
