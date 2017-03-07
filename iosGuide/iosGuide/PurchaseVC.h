//
//  PurchaseVC.h
//  iosGuide
//
//  Created by Elijah Cobb on 2/26/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PurchaseVC;
@protocol PurchaseDelegate<NSObject>
- (void)purchaseCompleteWithSuccess:(BOOL)success block:(PurchaseVC *)sender;
@end

@interface PurchaseVC : UIViewController <UIWebViewDelegate> {
    
}

@property (nonatomic, weak) id <PurchaseDelegate> delegate;

@end
