//
//  LaunchVC.m
//  iosGuide
//
//  Created by Elijah Cobb on 2/17/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "LaunchVC.h"
#import <Parse/Parse.h>

@interface LaunchVC ()

@end

@implementation LaunchVC

-(void)viewDidAppear:(BOOL)animated{
    PFUser *user = [PFUser currentUser];
    NSString *viewControllerId;
    UIModalTransitionStyle style;
    if (user) {
        viewControllerId = @"initialVC";
        style = UIModalTransitionStyleCrossDissolve;
    } else {
        viewControllerId = @"introVC";
        style = UIModalTransitionStyleFlipHorizontal;
    }
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:viewControllerId];
    viewController.modalTransitionStyle = style;
    [self presentViewController:viewController animated:YES completion:nil];
}

@end
