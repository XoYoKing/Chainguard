//
//  RWSListViewController.m
//  Manifest
//
//  Created by Samuel Goodwin on 26-01-14.
//  Copyright (c) 2014 Roundwall Software. All rights reserved.
//

#import "RWSListViewController.h"
#import "RWSCoreDataController.h"
#import "RWSListSource.h"
#import "RWSManagedList.h"
#import "RWSListCell.h"
#import "RWSProjectViewController.h"

@interface RWSListViewController ()

@end

@implementation RWSListViewController

- (RWSListSource *)listSource
{
    if(!_listSource){
        self.listSource = [[RWSListSource alloc] initWithCoreDataController:self.coreDataController];

        NSManagedObjectContext *mainContext = [self.coreDataController mainContext];

        RWSManagedList *list = [RWSManagedList insertInManagedObjectContext:mainContext];
        list.title = @"Example Project";
        NSError *saveError;
        BOOL saved = [mainContext save:&saveError];
        if(!saved){
            abort();
        }
    }
    return _listSource;
}

- (RWSCoreDataController *)coreDataController
{
    if(!_coreDataController){
        self.coreDataController = [[RWSCoreDataController alloc] init];
    }
    return _coreDataController;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return [self.listSource listCount];
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        return [self tableView:tableView firstSectionCellAtIndexPath:indexPath];
    }

    return [self tableView:tableView secondSectionCellAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView firstSectionCellAtIndexPath:(NSIndexPath *)indexPath
{
    RWSListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"list" forIndexPath:indexPath];

    id<RWSList> list = [self.listSource listAtIndexPath:indexPath];
    [cell setList:list];

    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView secondSectionCellAtIndexPath:(NSIndexPath *)indexPath
{
    switch(indexPath.row){
        case 0:
            return [tableView dequeueReusableCellWithIdentifier:@"settings" forIndexPath:indexPath];
        case 1:
            return [tableView dequeueReusableCellWithIdentifier:@"credits" forIndexPath:indexPath];
    }

    return nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = [segue identifier];
    if([identifier isEqualToString:@"addList"]){
        RWSManagedList *list = [RWSManagedList makeUntitledListInContext:[self.coreDataController mainContext]];

        RWSProjectViewController *controller = [segue destinationViewController];
        controller.coreDataController = self.coreDataController;
        controller.list = list;
    }
}

@end
