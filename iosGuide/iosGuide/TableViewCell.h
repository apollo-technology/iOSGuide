//
//  TableViewCell.h
//  iosGuide
//
//  Created by Elijah Cobb on 2/7/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property IBOutlet UILabel *appLabel;
@property IBOutlet UIImageView *appImageView;

@property IBOutlet UILabel *tutorialName;
@property IBOutlet UILabel *tutorialDescription;

@end

@interface SectionImageCell : UITableViewCell

@end

@interface SectionNormalCell : UITableViewCell

@property IBOutlet UILabel *titleLabel;
@property IBOutlet UILabel *contentLabel;

@end
