//
//  DetailViewController.m
//  Number
//
//  Created by Владислав Клещенко on 3/30/18.
//  Copyright © 2018 vladislavitsi. All rights reserved.
//

#import "DetailViewController.h"
#import "EditViewController.h"
#import "EXEntryDAO.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UILabel *goalLabel;

@property (nonatomic, strong) EXEntry *entry;

- (IBAction)addStep:(UIButton *)sender;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(onEdit:)];
    self.entry = EXEntryDAO.shared.entries[self.index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    self.nameLabel.text = self.entry.name;
    self.descriptionLabel.text = self.entry.descr;
    self.progressLabel.text = [NSString stringWithFormat:@"%ld", self.entry.progress];	
    self.goalLabel.text = [NSString stringWithFormat:@"%ld", self.entry.goal];
}

- (IBAction)onEdit:(id)sender {
    EditViewController *vc = [[EditViewController alloc] initWithIndex:self.index forTable:self.table];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
    
}
    
- (IBAction)addStep:(UIButton *)sender {
    self.entry.progress += self.entry.step;
    [self viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [EXEntryDAO.shared save];
}

@end
