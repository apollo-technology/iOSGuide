//
//  TutorialVC.m
//  iosGuide
//
//  Created by Elijah Cobb on 2/7/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "TutorialVC.h"
#import "ImageVC.h"
#import "TableViewCell.h"

@interface TutorialVC (){
    IBOutlet UITableView *sectionsTableView;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *overviewLabel;
    IBOutlet UILabel *authorLabel;
}

@end

@implementation TutorialVC

@synthesize tutorial;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    sectionsTableView.delegate = self;
    sectionsTableView.dataSource = self;
    sectionsTableView.estimatedRowHeight = 68.0;
    sectionsTableView.rowHeight = UITableViewAutomaticDimension;
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@ Tutorial",tutorial.app];
    
    nameLabel.text = [NSString stringWithFormat:@"%@",tutorial.title];
    overviewLabel.text = [NSString stringWithFormat:@"%@",tutorial.overview];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"MMM d, yyyy"];
    authorLabel.text = [NSString stringWithFormat:@"Created by %@ on %@",tutorial.author,[dateFormatter stringFromDate:tutorial.date]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tutorial.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex{
    DBSection *section = [tutorial.sections objectAtIndex:sectionIndex];
    if (section.hasImage) {
        return 2;
    } else {
        return 1;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        DBSection *section = [tutorial.sections objectAtIndex:[indexPath section]];
        ImageVC *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"imageVC"];
        newView.imageURL = [NSURL URLWithString:section.imageUrl];
        [self presentViewController:newView animated:YES completion:^{
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DBSection *section = [tutorial.sections objectAtIndex:indexPath.section];
    if (indexPath.row == 0) {
        SectionNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normalCell" forIndexPath:indexPath];
        cell.titleLabel.text = section.title;
        cell.contentLabel.text = section.content;
        return cell;
    } else {
        SectionImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell" forIndexPath:indexPath];
        return cell;
    }
}

@end
