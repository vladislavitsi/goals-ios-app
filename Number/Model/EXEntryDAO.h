//
//  EXEntryDAO.h
//  Number
//
//  Created by Владислав Клещенко on 3/30/18.
//  Copyright © 2018 vladislavitsi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXEntry.h"

@interface EXEntryDAO : NSObject

@property (nonatomic, readonly) NSArray<EXEntry*> *entries;
@property (nonatomic, readonly) NSArray<EXEntry *> *historyEntries;

+ (instancetype)shared;

- (void)addEntry:(EXEntry *)entry;
- (void)deleteEntry:(NSInteger)index;
- (void)doStep:(NSInteger)step onPos:(NSInteger)pos;
- (void)save;

@end
