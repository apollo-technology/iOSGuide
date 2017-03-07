//
//  ListTableVC.m
//  iosGuide
//
//  Created by Elijah Cobb on 2/7/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "ListTableVC.h"
#import "DBManager.h"
#import "TableViewCell.h"
#import "TutorialVC.h"

@interface ListTableVC (){
    IBOutlet UITableView *listTable;
}

@end

@implementation ListTableVC

@synthesize selectedApp,tutorials;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = [NSString stringWithFormat:@"Select a %@ Tutorial",selectedApp];
    
    listTable.delegate = self;
    listTable.dataSource = self;
    listTable.estimatedRowHeight = 68.0;
    listTable.rowHeight = UITableViewAutomaticDimension;
}

-(void)viewDidAppear:(BOOL)animated{
    [listTable reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tutorials.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    DBTutorial *tutorial = [tutorials objectAtIndex:[indexPath row]];
    cell.tutorialName.text = tutorial.title;
    cell.tutorialDescription.text = tutorial.overview;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TutorialVC *tutorialVC = [self.storyboard instantiateViewControllerWithIdentifier:@"tutorialVC"];
    tutorialVC.tutorial = [tutorials objectAtIndex:[indexPath row]];
    [self.navigationController pushViewController:tutorialVC animated:YES];
}

@end
