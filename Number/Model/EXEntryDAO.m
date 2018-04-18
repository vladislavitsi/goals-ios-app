//
//  EXEntryDAO.m
//  Number
//
//  Created by Владислав Клещенко on 3/30/18.
//  Copyright © 2018 vladislavitsi. All rights reserved.
//

#import "EXEntryDAO.h"
#import "DiskDataExpert.h"

@interface EXEntryDAO ()

@property (nonatomic, copy) NSMutableArray<EXEntry*> *entries;
@property (nonatomic, copy) NSMutableArray<EXEntry *> *historyEntries;
@property (nonatomic, strong) DiskDataExpert *dataExpert;

@end

@implementation EXEntryDAO

static EXEntryDAO *sharedInstance;

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[EXEntryDAO alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.dataExpert = [[DiskDataExpert alloc] init];
        _entries = [self.dataExpert getDataFromDisk];
        _historyEntries = [self.dataExpert getHistoryFromDisk];
        NSCalendar *cal = [NSCalendar currentCalendar];
        for (EXEntry *entry in _entries) {
            NSDateComponents *components = [cal components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
            NSDate *today = [cal dateFromComponents:components];
            components = [cal components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:entry.date];
            NSDate *otherDate = [cal dateFromComponents:components];
            if(![today isEqualToDate:otherDate]) {
                [_historyEntries insertObject:[entry copyWithZone:nil] atIndex:0];
                entry.progress = 0;
                entry.date = [NSDate date];
            }
        }
        [self save];
    }
    return self;
}

- (void)addEntry:(EXEntry *)entry {
    [_entries addObject:entry];
}

- (void)deleteEntry:(NSInteger)index {
    [_entries removeObjectAtIndex:index];
}

- (void)doStep:(NSInteger)step onPos:(NSInteger)pos {
    self.entries[pos].step += step;
}

- (void)save {
    [self.dataExpert saveDataToDisk:_entries];
    [self.dataExpert saveHistoryToDisk:_historyEntries];
}

@end
