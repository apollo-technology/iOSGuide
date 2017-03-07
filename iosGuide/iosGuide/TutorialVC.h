//
//  TutorialVC.h
//  iosGuide
//
//  Created by Elijah Cobb on 2/7/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"

@interface TutorialVC : UIViewController <UITableViewDataSource, UITableViewDelegate> {
     DBTutorial *tutorial;
}

@property DBTutorial *tutorial;

@end
