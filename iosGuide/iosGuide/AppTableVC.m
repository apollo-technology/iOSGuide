//
//  AppTableVC.m
//  iosGuide
//
//  Created by Elijah Cobb on 2/7/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "AppTableVC.h"
#import "DBManager.h"
#import "TableViewCell.h"
#import "ListTableVC.h"

@interface AppTableVC (){
    IBOutlet UITableView *appsTable;
}

@end

@implementation AppTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    appsTable.dataSource = self;
    appsTable.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"All";
    } else {
        return @"By App";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return [[[DBManager data] apps] count];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [appsTable reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    if (indexPath.section == 0) {
        cell.appLabel.text = @"All Tutorials";
        cell.appImageView.image = [UIImage imageNamed:@""];
    } else {
        cell.appLabel.text = [[[DBManager data] apps] objectAtIndex:indexPath.row];
        cell.appImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[[DBManager data] apps] objectAtIndex:indexPath.row]]];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ListTableVC *listTableVC = [self.storyboard instantiateViewControllerWithIdentifier:@"listTableVC"];
        listTableVC.selectedApp = @"All";
        listTableVC.tutorials = [[[DBManager data] tutorials] allValues];
        [self.navigationController pushViewController:listTableVC animated:YES];
    } else {
        ListTableVC *listTableVC = [self.storyboard instantiateViewControllerWithIdentifier:@"listTableVC"];
        listTableVC.selectedApp = [[[DBManager data] apps] objectAtIndex:indexPath.row];
        listTableVC.tutorials = [[[DBManager data] tutorials] objectForKey:[[[DBManager data] apps] objectAtIndex:indexPath.row]];
        [self.navigationController pushViewController:listTableVC animated:YES];
    }
}

@end
