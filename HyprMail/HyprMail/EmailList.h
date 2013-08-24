//
//  EmailList.h
//  
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmailList : NSObject <NSCoding> {
    NSString *emailListId;
    NSString *listName;
    NSString *userId;
}

@property (nonatomic, copy) NSString *emailListId;
@property (nonatomic, copy) NSString *listName;
@property (nonatomic, copy) NSString *userId;

+ (EmailList *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
