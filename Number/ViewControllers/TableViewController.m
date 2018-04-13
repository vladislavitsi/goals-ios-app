//
//  TableViewController.m
//  Number
//
//  Created by Владислав Клещенко on 3/30/18.
//  Copyright © 2018 vladislavitsi. All rights reserved.
//

#import "TableViewController.h"
#import "EXEntryDAO.h"
#import "TableViewCell.h"
#import "DetailViewController.h"
#import "EditViewController.h"

@interface TableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *table;

- (IBAction)addNewEntry:(UIBarButtonItem *)sender;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    [self.table registerNib:[UINib nibWithNibName:@"EntryCell" bundle:nil] forCellReuseIdentifier:@"EntryCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.table reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return EXEntryDAO.shared.entries.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EntryCell" forIndexPath:indexPath];
    EXEntry *entry = EXEntryDAO.shared.entries[indexPath.row];
    cell.entry = entry;
    cell.name.text = entry.name;
    cell.progress.text = [NSString stringWithFormat:@"%ld", entry.progress];
    cell.goal.text = [NSString stringWithFormat:@"%ld", entry.goal];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *vc = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];

    vc.index = indexPath.row;
    vc.table = self.tableView;
    
    [self.navigationController pushViewController:vc animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [EXEntryDAO.shared deleteEntry:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (IBAction)addNewEntry:(UIBarButtonItem *)sender {
    EditViewController *vc = [[EditViewController alloc] initNewForTable:self.tableView];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}
@end
