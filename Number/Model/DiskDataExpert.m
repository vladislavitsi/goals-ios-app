//
//  DiskDataExpert.m
//  Number
//
//  Created by Vladislav Kleschenko on 4/13/18.
//  Copyright © 2018 vladislavitsi. All rights reserved.
//

#import "DiskDataExpert.h"
#import "EXEntry.h"

#define DATA_FILE_NAME @"data.compressed"
#define HISTORY_FILE_NAME @"history.compressed"
@interface DiskDataExpert ()

- (void)saveToDisk:(NSMutableArray<EXEntry *> *)entries fileName:(NSString *)fileName;
- (NSMutableArray *)getFromDisk:(NSString *)fileName;

@end


@implementation DiskDataExpert

- (NSMutableArray<EXEntry *> *)getDataFromDisk {
    return [self getFromDisk:DATA_FILE_NAME];
}

- (void)saveDataToDisk:(NSMutableArray<EXEntry *> *)entries {
    [self saveToDisk:entries fileName:DATA_FILE_NAME];
}

- (NSMutableArray<EXEntry *> *)getHistoryFromDisk {
    return [self getFromDisk:HISTORY_FILE_NAME];

}

- (void)saveHistoryToDisk:(NSMutableArray<EXEntry *> *)entries {
    [self saveToDisk:entries fileName:HISTORY_FILE_NAME];
}

- (void)saveToDisk:(NSMutableArray<EXEntry *> *)entries fileName:(NSString *)fileName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsURL = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
    NSURL *dataFileURL = [documentsURL URLByAppendingPathComponent:DATA_FILE_NAME];
    NSMutableArray *array = [NSMutableArray array];
    for (EXEntry *entry in entries) {
        [array addObject:[entry toJSONDictionary]];
    }
    [fileManager createFileAtPath:dataFileURL.path contents:[NSJSONSerialization dataWithJSONObject:array options:0 error:nil] attributes:nil];
}

- (NSMutableArray *)getFromDisk:(NSString *)fileName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsURL = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
    NSURL *dataFileURL = [documentsURL URLByAppendingPathComponent:fileName];
    NSData *jsonFileData = [NSData dataWithContentsOfURL:dataFileURL];
    NSMutableArray<EXEntry *> *entries = [NSMutableArray array];
    if (jsonFileData != nil) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonFileData options:0 error:nil];
        for (NSDictionary *dict in array) {
            [entries addObject:[EXEntry fromJSONDictionary:dict]];
        }
    }
    return entries;
}

@end
