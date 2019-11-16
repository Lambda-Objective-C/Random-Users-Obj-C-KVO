//
//  CESUser.m
//  Random-Users-Objective-C
//
//  Created by Seschwan on 11/13/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

#import "CESUser.h"

@implementation CESUser

- (instancetype)initWithName:(NSString *)aFirstName lastName:(NSString *)aLastName phone:(nullable NSString *)aPhone email:(nullable NSString *)aEmail image:(nullable NSString *)aImage;
{
    if (self = [super init])
    {
        _firstName = aFirstName.copy;
        _lastName = aLastName.copy;
        _phone = aPhone.copy;
        _email = aEmail.copy;
        _image = aImage.copy;
        
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *firstName = dictionary[@"name"][@"first"];
    NSString *lastName = dictionary[@"name"][@"last"];
    NSString *phone = dictionary[@"phone"];
    NSString *email = dictionary[@"email"];
    NSString *image = dictionary[@"picture"][@"large"];
    
    return [self initWithName:firstName lastName:lastName phone:phone email:email image:image];
}

- (instancetype)initWithKVOPhone:(NSString *)kvoPhone kvoEmail:(NSString *)kvoEmail kvoImage:(NSString *)kvoImage
{
    if (self = [super init])
    {
        _KVOPhone = kvoPhone.copy;
        _KVOEmail = kvoEmail.copy;
        _KVOImage = kvoImage.copy;
        
        NSLog(@" KVO Objects in INIT: %@, %@, %@", kvoPhone, kvoEmail, kvoImage);
    }
    return self;
}



@end
