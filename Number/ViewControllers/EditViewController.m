//
//  EditViewController.m
//  Number
//
//  Created by Владислав Клещенко on 3/31/18.
//  Copyright © 2018 vladislavitsi. All rights reserved.
//

#import "EditViewController.h"

#define keyboardBottomInset 220

@interface EditViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) NSArray<UITextField*> *textFields;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *progressTextField;
@property (weak, nonatomic) IBOutlet UITextField *goalTextField;
@property (weak, nonatomic) IBOutlet UITextField *stepTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextField;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, assign) BOOL isNew;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UITableView *table;

- (IBAction)onSave:(UIBarButtonItem *)sender;

- (IBAction)onCancel:(UIBarButtonItem *)sender;

- (instancetype)initForTable:(UITableView *)table;
@end

@implementation EditViewController

- (instancetype)initForTable:(UITableView *)table{
    if (self = [super initWithNibName:@"EditViewController" bundle:nil]) {
        self.table = table;
    }
    return self;
}

- (instancetype)initNewForTable:(UITableView *)tableView {
    if (self = [self initForTable:tableView]) {
        self.isNew = YES;
    }
    return self;
}

- (instancetype)initWithIndex:(NSInteger)index forTable:(UITableView *)tableView {
    if (self = [self initForTable:tableView]) {
        self.isNew = NO;
        self.index = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.textFields = @[self.nameTextField, self.goalTextField, self.progressTextField, self.stepTextField];
    for (UITextField *textField in self.textFields) {
        textField.delegate = self;
    }
    self.descriptionTextField.delegate = self;
    self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    if (!self.isNew) {
        EXEntry *entry = EXEntryDAO.shared.entries[self.index];
        self.nameTextField.text = entry.name;
        self.descriptionTextField.text = entry.descr;
        self.progressTextField.text = [NSString stringWithFormat:@"%ld", entry.progress];
        self.goalTextField.text = [NSString stringWithFormat:@"%ld", entry.goal];
        self.stepTextField.text = [NSString stringWithFormat:@"%ld", entry.step];
    }
}


#pragma mark --TextField delegate methods

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardBottomInset, 0);
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark --TextField delegate methods

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
}

- (void)textViewDidEndEditing:(UITextField *)textView {
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark -- Action listeners

- (IBAction)onSave:(UIBarButtonItem *)sender {
    if (self.isNew) {
        EXEntry *entry = [[EXEntry alloc] init];
        entry.name = self.nameTextField.text;
        entry.descr = self.descriptionTextField.text;
        entry.date = [NSDate date];
        entry.progress = [self.progressTextField.text intValue];
        entry.goal = [self.goalTextField.text intValue];
        entry.step = [self.stepTextField.text intValue];
        [EXEntryDAO.shared addEntry:entry];
    }else {
        EXEntry *entry = EXEntryDAO.shared.entries[self.index];
        entry.name = self.nameTextField.text;
        entry.descr = self.descriptionTextField.text;
        entry.progress = [self.progressTextField.text intValue];
        entry.goal = [self.goalTextField.text intValue];
        entry.step = [self.stepTextField.text intValue];
    }
    [self.table reloadData];
    [self dismissViewControllerAnimated:YES completion:^() {
        [EXEntryDAO.shared save];
    }];
}

- (IBAction)onCancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
