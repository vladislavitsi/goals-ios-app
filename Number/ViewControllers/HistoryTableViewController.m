//
//  HistoryTableViewController.m
//  Number
//
//  Created by Vladislav Kleschenko on 4/17/18.
//  Copyright © 2018 vladislavitsi. All rights reserved.
//

#import "HistoryTableViewController.h"
#import "EXEntryDAO.h"
#import "HistoryTableViewCell.h"

@interface HistoryTableViewController ()

@end

@implementation HistoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    [self.tableView registerNib:[UINib nibWithNibName:@"HistoryTableViewCell" bundle:nil] forCellReuseIdentifier:@"HistoryCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [EXEntryDAO.shared save];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return EXEntryDAO.shared.historyEntries.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryCell" forIndexPath:indexPath];
    EXEntry *entry = EXEntryDAO.shared.historyEntries[indexPath.row];
    cell.name.text = entry.name;
    if (entry.progress < entry.goal) {
        cell.name.textColor = [UIColor redColor];
    }else {
        cell.name.textColor = [UIColor greenColor];
    }
    cell.date.text = [entry getFormattedDate];
    cell.progress.text = [NSString stringWithFormat:@"%ld", entry.progress];
    cell.goal.text = [NSString stringWithFormat:@"%ld", entry.goal];
    return cell;
}

@end
