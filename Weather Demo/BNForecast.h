//
//  BNForecast.h
//  Weather Demo
//
//  Created by bnicholas on 5/8/14.
//  Copyright (c) 2014 Brand Networks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNForecast : NSObject

@property (strong, nonatomic) NSNumber *temperature;
@property (strong, nonatomic) NSNumber *cloudCover;
@property (strong, nonatomic) NSString *iconName;

- (instancetype) initWithForecastJson:(NSDictionary *)jsonData;

@end
