//
//  TableViewCell.m
//  Number
//
//  Created by Владислав Клещенко on 3/30/18.
//  Copyright © 2018 vladislavitsi. All rights reserved.
//

#import "TableViewCell.h"
#import "EXEntryDAO.h"
#import "EXEntry.h"

@interface TableViewCell ()

- (IBAction)onAction:(id)sender;

@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)onAction:(id)sender {
    self.entry.progress += self.entry.step;
    self.progress.text = [NSString stringWithFormat:@"%ld", self.entry.progress];
    [EXEntryDAO.shared save];
}

@end
