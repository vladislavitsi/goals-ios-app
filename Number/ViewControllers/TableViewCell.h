//
//  TableViewCell.h
//  Number
//
//  Created by Владислав Клещенко on 3/30/18.
//  Copyright © 2018 vladislavitsi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXEntry.h"

@interface TableViewCell : UITableViewCell

@property (nonatomic, strong) EXEntry *entry;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *progress;
@property (weak, nonatomic) IBOutlet UILabel *goal;

@end
