//
//  EXEntryCellDAO.h
//  Number
//
//  Created by Владислав Клещенко on 3/30/18.
//  Copyright © 2018 vladislavitsi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXEntry.h"

@interface EXEntryCellDAO : NSObject

@property (nonatomic, readonly) NSArray<EXEntry*> *entries;

@end
