//
//  EditViewController.h
//  Number
//
//  Created by Владислав Клещенко on 3/31/18.
//  Copyright © 2018 vladislavitsi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXEntryDAO.h"
#import "EXEntry.h"

@interface EditViewController : UIViewController

- (instancetype)initNewForTable:(UITableView *)tableView;

- (instancetype)initWithIndex:(NSInteger)index forTable:(UITableView *)tableView;

@end
