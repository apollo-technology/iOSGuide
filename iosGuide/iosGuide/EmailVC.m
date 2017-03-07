//
//  EmailVC.m
//  iosGuide
//
//  Created by Elijah Cobb on 2/18/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "EmailVC.h"
#import "AccountCreator.h"

@interface EmailVC (){
    IBOutlet UITextField *emailField;
}

@end

@implementation EmailVC

-(void)viewDidAppear:(BOOL)animated{
    [emailField becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)waitFor:(float)length block:(void (^)())block{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, length * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (block) {
            block();
        }
    });
}


-(IBAction)next:(id)sender{
    [emailField resignFirstResponder];
    [[AccountCreator user] setEmail:emailField.text];
    UIViewController *nextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"nameVC"];
    [self waitFor:.5 block:^{
        [self.navigationController pushViewController:nextViewController animated:YES];
    }];
}

@end
