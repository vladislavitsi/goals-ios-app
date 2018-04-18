//
//  HistoryTableViewCell.h
//  Number
//
//  Created by Vladislav Kleschenko on 4/18/18.
//  Copyright © 2018 vladislavitsi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *progress;
@property (weak, nonatomic) IBOutlet UILabel *goal;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end
