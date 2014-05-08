//
//  BNLocation.m
//  Weather Demo
//
//  Created by bnicholas on 5/8/14.
//  Copyright (c) 2014 Brand Networks. All rights reserved.
//

#import "BNLocation.h"

@implementation BNLocation

- (instancetype)initWithName:(NSString *)name andLatitude:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude
{
    self = [super init];
    if (self) {
        self.name = name;
        self.location = CLLocationCoordinate2DMake(latitude, longitude);
    }
    return self;
}

@end
