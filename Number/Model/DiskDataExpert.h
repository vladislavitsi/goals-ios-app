//
//  DiskDataExpert.h
//  Number
//
//  Created by Vladislav Kleschenko on 4/13/18.
//  Copyright © 2018 vladislavitsi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EXEntry;

@interface DiskDataExpert : NSObject

- (NSMutableArray<EXEntry *> *)getDataFromDisk;
- (void)saveDataToDisk:(NSMutableArray<EXEntry *> *)array;
- (NSMutableArray<EXEntry *> *)getHistoryFromDisk;
- (void)saveHistoryToDisk:(NSMutableArray<EXEntry *> *)array;

@end
