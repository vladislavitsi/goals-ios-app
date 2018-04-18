//
//  EXEntry.m
//  Number
//
//  Created by Владислав Клещенко on 3/30/18.
//  Copyright © 2018 vladislavitsi. All rights reserved.
//

#define DATA_PATTERN @"dd.MM.yyyy"

#import "EXEntry.h"

@interface EXEntry ()

@end

@implementation EXEntry

static NSDateFormatter *_formatter;

+ (NSDateFormatter *)getFormatter {
    if(_formatter == nil) {
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setDateFormat:DATA_PATTERN];
    }
    return _formatter;
}

- (instancetype)initWithName:(NSString *)name descr:(NSString *)descr date:(NSDate *)date progress:(NSInteger)progress goal:(NSInteger)goal step:(NSInteger)step {
    if (self = [super init]) {
        self.name = name;
        self.descr = descr;
        self.date = date;
        self.progress = progress;
        self.goal = goal;
        self.step = step;
    }
    return self;
}

- (NSDictionary *)toJSONDictionary {
    return @{
               @"name":self.name==nil?@"":self.name,
               @"descr":self.descr==nil?@"":self.descr,
               @"date":self.date==nil?@"":[[EXEntry getFormatter] stringFromDate:self.date],
               @"progress":[NSNumber numberWithInteger:self.progress],
               @"goal":[NSNumber numberWithInteger:self.goal],
               @"step":[NSNumber numberWithInteger:self.step]
            };
    
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)jsonDataDictionary {
    EXEntry * entry = [[EXEntry alloc] init];
    entry.name = jsonDataDictionary[@"name"];
    entry.descr = jsonDataDictionary[@"descr"];
    entry.date = [[EXEntry getFormatter] dateFromString:jsonDataDictionary[@"date"]];
    entry.progress = [jsonDataDictionary[@"progress"] integerValue];
    entry.goal = [jsonDataDictionary[@"goal"] integerValue];
    entry.step = [jsonDataDictionary[@"step"] integerValue];
    return entry;
}

- (id)copyWithZone:(NSZone *)zone {
    return [self copy];
}

- (NSString *)getFormattedDate {
    return [[EXEntry getFormatter] stringFromDate:self.date];
}

- (id)copy {
    EXEntry * entry = [[EXEntry alloc] init];
    entry.name = self.name;
    entry.descr = self.descr;
    entry.date = self.date;
    entry.progress = self.progress;
    entry.goal = self.goal;
    entry.step = self.step;
    return entry;
}

@end
