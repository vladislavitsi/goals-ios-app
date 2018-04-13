//
//  EXEntry.h
//  Number
//
//  Created by Владислав Клещенко on 3/30/18.
//  Copyright © 2018 vladislavitsi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXEntry : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *descr;
@property (nonatomic, copy) NSDate *date;
@property (nonatomic, assign) NSInteger progress;
@property (nonatomic, assign) NSInteger goal;
@property (nonatomic, assign) NSInteger step;

- (instancetype)initWithName:(NSString *)name descr:(NSString *)descr date:(NSDate *)date progress:(NSInteger)progress goal:(NSInteger)goal step:(NSInteger)step;

+ (instancetype)fromJSONDictionary:(NSDictionary *)jsonDataDictionary;

- (NSDictionary *)toJSONDictionary;

@end
