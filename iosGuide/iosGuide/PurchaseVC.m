//
//  PurchaseVC.m
//  iosGuide
//
//  Created by Elijah Cobb on 2/26/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "PurchaseVC.h"
#import <Parse/Parse.h>

@interface PurchaseVC (){
    IBOutlet UIWebView *purchaseView;
    IBOutlet UIActivityIndicatorView *loaderView;
}

@end

@implementation PurchaseVC

-(IBAction)cancelButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate purchaseCompleteWithSuccess:NO block:self];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [purchaseView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[PFConfig currentConfig] objectForKey:@"proURL"]]]];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    loaderView.hidden = YES;
    if ([webView.request.URL.absoluteString containsString:@"cancel"]) {
        [self dismissViewControllerAnimated:YES completion:^{
            [self.delegate purchaseCompleteWithSuccess:NO block:self];
        }];
    } else if ([webView.request.URL.absoluteString containsString:@"success"]) {
        [self dismissViewControllerAnimated:YES completion:^{
            [self.delegate purchaseCompleteWithSuccess:YES block:self];
        }];
    }
}

@end
