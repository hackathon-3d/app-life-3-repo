//
//  NSURL+DictionaryURLValue.m
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "NSURL+DictionaryURLValue.h"

@implementation NSURL (DictionaryURLValue)

-(NSDictionary *)dictionaryValue
{
    NSString *string =  [[self.absoluteString stringByReplacingOccurrencesOfString:@"+" withString:@" "]
                         stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSScanner *scanner = [NSScanner scannerWithString:string];
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"&?"]];
    
    NSString *temp;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [scanner scanUpToString:@"?" intoString:nil];       //ignore the beginning of the string and skip to the vars
    while ([scanner scanUpToString:@"&" intoString:&temp])
    {
        NSArray *parts = [temp componentsSeparatedByString:@"="];
        if([parts count] == 2)
        {
            [dict setObject:[parts objectAtIndex:1] forKey:[parts objectAtIndex:0]];
        }
    }
    
    return dict;
}

@end
