//
//  BNLocationStore.m
//  Weather Demo
//
//  Created by bnicholas on 5/8/14.
//  Copyright (c) 2014 Brand Networks. All rights reserved.
//

#import "BNLocationStore.h"

@implementation BNLocationStore

static NSMutableArray *locations;

+ (NSArray *)locations
{
    if (!locations) {
        locations = [NSMutableArray array];
    }
    return locations;
}

+ (void)addLocation:(BNLocation *)location
{
    if (!locations) {
        locations = [NSMutableArray array];
    }
    [locations addObject:location];
}

@end
