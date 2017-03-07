//
//  PhoneNumberVC.m
//  iosGuide
//
//  Created by Elijah Cobb on 2/18/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "PhoneNumberVC.h"
#import "AccountCreator.h"
#import <SinchVerification/SinchVerification.h>
#import <Parse/Parse.h>

@interface PhoneNumberVC (){
    IBOutlet UITextField *phoneField;
    id<SINVerification> verificationHandler;
    UITextField *codeField;
}

@end

@implementation PhoneNumberVC

-(void)viewDidAppear:(BOOL)animated{
    [phoneField becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(IBAction)next:(id)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Sending a Code\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = CGPointMake(130.5, 80);
    spinner.color = [UIColor grayColor];
    [spinner startAnimating];
    [alert.view addSubview:spinner];
    [self presentViewController:alert animated:YES completion:^{
        verificationHandler = [SINVerification SMSVerificationWithApplicationKey:@"e53ee320-4d09-49f2-a443-b9194b8e49fa" phoneNumber:phoneField.text];
        [verificationHandler initiateWithCompletionHandler:^(BOOL success, NSError *error) {
            if (success) {
                [self dismissViewControllerAnimated:YES completion:^{
                    [self showKeyPad];
                }];
            } else {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"We had a problem." message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:YES completion:^{
                    
                }];
            }
        }];
    }];
}

-(void)showKeyPad{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"We sent a code to %@. Please type in the code.",phoneField.text] message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"code";
        textField.text = @"";
        textField.returnKeyType = UIReturnKeyContinue;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        textField.secureTextEntry = NO;
        textField.autocorrectionType = UITextAutocorrectionTypeDefault;
        codeField = textField;
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Next" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self verifyCode];
    }]];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}

-(void)verifyCode{
    [verificationHandler verifyCode:codeField.text completionHandler:^(BOOL success, NSError* error) {
        if (success) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Loading\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
            UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            spinner.center = CGPointMake(130.5, 80);
            spinner.color = [UIColor grayColor];
            [spinner startAnimating];
            [alert.view addSubview:spinner];
            [self presentViewController:alert animated:YES completion:^{
                PFQuery *query = [PFUser query];
                [query whereKey:@"username" equalTo:phoneField.text];
                [query getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
                    if (object) {
                        NSLog(@"%@",object);
                        [PFUser logInWithUsernameInBackground:phoneField.text password:@"password" block:^(PFUser * _Nullable user, NSError * _Nullable error) {
                            UIViewController *nextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"launchVC"];
                            nextViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                            [self dismissViewControllerAnimated:YES completion:^{
                                [self.navigationController pushViewController:nextViewController animated:YES];
                            }];
                        }];
                    } else {
                        [[AccountCreator user] setPhoneNumber:phoneField.text];
                        UIViewController *nextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"emailVC"];
                        [self dismissViewControllerAnimated:YES completion:^{
                            [self.navigationController pushViewController:nextViewController animated:YES];
                        }];
                    }
                }];
            }];
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"You entered the wrong code." message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self showKeyPad];
            }]];
            [self presentViewController:alertController animated:YES completion:^{
                
            }];
        }
    }];

}

@end
