//
//  CounselingVC.m
//  iosGuide
//
//  Created by Elijah Cobb on 2/17/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "CounselingVC.h"
#import <Parse/Parse.h>

@interface CounselingVC (){
    IBOutlet UILabel *messageLabel;
}

@end

@implementation CounselingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    messageLabel.text = [NSString stringWithFormat:@"With counseling, you can communicate with a skilled helper.\n\nAsk any questions about your device and they will help you with to the best of their abilities.\n\nTap the button below and someone from our organization will contact you via the email you provided when you signed up. We will email you at %@.",[[PFUser currentUser] objectForKey:@"email"]];
}

-(IBAction)requestCouseling:(id)sender{
    
}

@end
