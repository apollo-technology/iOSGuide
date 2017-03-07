//
//  NameVC.m
//  iosGuide
//
//  Created by Elijah Cobb on 2/18/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "NameVC.h"
#import "AccountCreator.h"

@interface NameVC (){
    IBOutlet UITextField *firstNameField;
    IBOutlet UITextField *lastNameField;
}

@end

@implementation NameVC

-(void)viewDidAppear:(BOOL)animated{
    [firstNameField becomeFirstResponder];
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
    [firstNameField resignFirstResponder];
    [lastNameField resignFirstResponder];
    [[AccountCreator user] setFirstName:firstNameField.text];
    [[AccountCreator user] setLastName:lastNameField.text];
    UIViewController *nextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"loadVC"];
    [self waitFor:.5 block:^{
        [self.navigationController pushViewController:nextViewController animated:YES];
    }];
}

@end
