//
//  CESUser.h
//  Random-Users-Objective-C
//
//  Created by Seschwan on 11/13/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

@interface CESUser : NSObject

@property (nonatomic)NSString *firstName;
@property (nonatomic)NSString *lastName;
@property (nonatomic)NSString *phone;
@property (nonatomic)NSString *email;
@property (nonatomic)NSString *image;

- (instancetype)initWithName:(NSString *)aFirstName lastName:(NSString *)aLastName phone:(NSString *)phone email:(NSString *)email image:(NSString *)image;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


#pragma mark - KVO Objects

@property (nonatomic)NSString *KVOPhone;
@property (nonatomic)NSString *KVOEmail;
@property (nonatomic)NSString *KVOImage;

- (instancetype)initWithKVOPhone:(NSString *)kvoPhone kvoEmail:(NSString *)kvoEmail kvoImage:(NSString *)kvoImage;

@end

//NS_ASSUME_NONNULL_END
