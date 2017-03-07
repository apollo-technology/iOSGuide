//
//  IntroVC.m
//  iosGuide
//
//  Created by Elijah Cobb on 2/18/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "IntroVC.h"

@interface IntroVC ()

@end

@implementation IntroVC

-(IBAction)nextStep:(id)sender{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"introComplete"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"phoneNumberVC"];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
