//
//  BNLocation.h
//  Weather Demo
//
//  Created by bnicholas on 5/8/14.
//  Copyright (c) 2014 Brand Networks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface BNLocation : NSObject

- (instancetype)initWithName:(NSString *)name andLatitude:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) CLLocationCoordinate2D location;

@end
