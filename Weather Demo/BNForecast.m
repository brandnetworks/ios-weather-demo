//
//  BNForecast.m
//  Weather Demo
//
//  Created by bnicholas on 5/8/14.
//  Copyright (c) 2014 Brand Networks. All rights reserved.
//

#import "BNForecast.h"

@implementation BNForecast

- (instancetype)initWithForecastJson:(NSDictionary *)jsonData
{
    self = [super init];
    if (self) {
        self.temperature = [jsonData valueForKeyPath:@"currently.apparentTemperature"];
        self.cloudCover  = [jsonData valueForKeyPath:@"currently.cloudCover"];
        self.iconName    = [jsonData valueForKeyPath:@"currently.icon"];
    }
    return self;
}

@end
