//
//  NSData+NSData_AES.h
//  Canary
//
//  Created by Brendan Lee on 12/1/12.
//
//

#import <Foundation/Foundation.h>

@interface NSData (NSData_AES)
- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;

@end
