//
//  ImageVC.h
//  iosGuide
//
//  Created by Elijah Cobb on 2/22/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageVC : UIViewController <NSURLSessionDataDelegate, NSURLSessionDelegate, NSURLSessionTaskDelegate>{
    NSURL *imageURL;
}

@property NSURL *imageURL;

@end
