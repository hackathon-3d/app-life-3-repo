//
//  NSMutableArray+Convenience.m
//  Snap Sign
//
//  Created by Brendan Lee on 7/23/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "NSMutableArray+Convenience.h"

@implementation NSMutableArray (Convenience)

- (void)moveObjectAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    id object = [self objectAtIndex:fromIndex];
    [self removeObjectAtIndex:fromIndex];
    [self insertObject:object atIndex:toIndex];
}


@end
