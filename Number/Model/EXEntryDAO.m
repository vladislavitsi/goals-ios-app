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

@property (nonatomic, readwrite) NSMutableArray<EXEntry*> *entries;
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
}

@end
