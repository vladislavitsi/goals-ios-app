//
//  DetailViewController.h
//  Number
//
//  Created by Владислав Клещенко on 3/30/18.
//  Copyright © 2018 vladislavitsi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXEntryDAO.h"

@interface DetailViewController : UIViewController

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UITableView *table;

@end
