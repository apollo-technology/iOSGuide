//
//  AccountCreator.h
//  iosGuide
//
//  Created by Elijah Cobb on 2/18/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountCreator : NSObject

@property NSString *phoneNumber;
@property NSString *email;
@property NSString *firstName;
@property NSString *lastName;

+(instancetype)user;

@end
