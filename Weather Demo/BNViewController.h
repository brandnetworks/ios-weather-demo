//
//  BNViewController.h
//  Weather Demo
//
//  Created by Ben Nicholas on 4/4/14.
//  Copyright (c) 2014 Brand Networks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "BNForecast.h"

@interface BNViewController : UIViewController < CLLocationManagerDelegate > {
	NSOperationQueue *backgroundQueue;
}

@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (strong, readonly, nonatomic) UIColor *clearSkyColor;
@property (strong, readonly, nonatomic) UIColor *cloudySkyColor;
@property (strong, readonly, nonatomic) UIColor *hotTempColor;
@property (strong, readonly, nonatomic) UIColor *coldTempColor;

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) BNForecast *forecast;

- (UIColor *) colorForCloudCover:(NSNumber *) cloudCover;
- (UIColor *) colorForTemperature:(NSNumber *) temperature;

@end
