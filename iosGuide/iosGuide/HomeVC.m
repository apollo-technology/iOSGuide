//
//  HomeVC.m
//  iosGuide
//
//  Created by Elijah Cobb on 2/19/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "HomeVC.h"
#import <Parse/Parse.h>
@interface HomeVC (){
    IBOutlet UILabel *welcomeLabel;
    IBOutlet UILabel *goProLabel;
}

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    welcomeLabel.text = [NSString stringWithFormat:welcomeLabel.text,[[PFUser currentUser] objectForKey:@"firstName"]];
    goProLabel.text = [NSString stringWithFormat:goProLabel.text,[[PFUser currentUser] objectForKey:@"firstName"]];
}

-(IBAction)goPro:(id)sender{
    PurchaseVC *purchaseVC = [self.storyboard instantiateViewControllerWithIdentifier:@"purchaseVC"];
    purchaseVC.delegate = self;
    [self presentViewController:purchaseVC animated:YES completion:nil];
}

-(void)purchaseCompleteWithSuccess:(BOOL)success block:(PurchaseVC *)sender{
    if (success) {
        NSLog(@"Purchased");
    } else {
        NSLog(@"Not Purchased");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
