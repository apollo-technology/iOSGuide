//
//  LoadVC.m
//  iosGuide
//
//  Created by Elijah Cobb on 2/18/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "LoadVC.h"
#import "AccountCreator.h"
#import <Parse/Parse.h>

@interface LoadVC ()

@end

@implementation LoadVC

-(void)viewDidAppear:(BOOL)animated{
    PFUser *user = [PFUser user];
    user.email = [[AccountCreator user] email];
    user.username = [[AccountCreator user] phoneNumber];
    user.password = @"password";
    user[@"firstName"] = [[AccountCreator user] firstName];
    user[@"lastName"] = [[AccountCreator user] lastName];
    user[@"isPro"] = @(NO);
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        UIViewController *initial = [self.storyboard instantiateInitialViewController];
        initial.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:initial animated:YES completion:nil];
    }];
}

@end
