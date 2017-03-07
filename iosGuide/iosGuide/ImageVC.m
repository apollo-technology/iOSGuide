//
//  ImageVC.m
//  iosGuide
//
//  Created by Elijah Cobb on 2/22/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "ImageVC.h"

@interface ImageVC (){
    IBOutlet UIProgressView *progressView;
    NSMutableData *dataToDownload;
    float downloadSize;
    IBOutlet UIImageView *imageView;
}

@end

@implementation ImageVC

@synthesize imageURL;

-(IBAction)back:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithURL:imageURL];
    [dataTask resume];
    imageView.hidden = YES;
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    completionHandler(NSURLSessionResponseAllow);
    
    progressView.progress = 0.0f;
    downloadSize = [response expectedContentLength];
    dataToDownload = [NSMutableData new];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [dataToDownload appendData:data];
    progressView.progress = (dataToDownload.length/downloadSize);
    if (progressView.progress == 1) {
        imageView.image = [UIImage imageWithData:dataToDownload];
        progressView.hidden = YES;
        imageView.hidden = NO;
    }
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
