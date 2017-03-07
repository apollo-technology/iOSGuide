//
//  ListTableVC.h
//  iosGuide
//
//  Created by Elijah Cobb on 2/7/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableVC : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    NSArray *tutorials;
    NSString *selectedApp;
}

@property NSArray *tutorials;
@property NSString *selectedApp;

@end
