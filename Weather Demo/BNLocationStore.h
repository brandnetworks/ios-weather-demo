//
//  BNLocationStore.h
//  Weather Demo
//
//  Created by bnicholas on 5/8/14.
//  Copyright (c) 2014 Brand Networks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNLocation.h"

@interface BNLocationStore : NSObject

+ (NSArray *)locations;
+ (void)addLocation:(BNLocation *)location;

@end
