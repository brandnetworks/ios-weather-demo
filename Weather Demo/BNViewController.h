//
//  BNViewController.h
//  Weather Demo
//
//  Created by Ben Nicholas on 4/4/14.
//  Copyright (c) 2014 Brand Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNViewController : UIViewController {
	NSOperationQueue *backgroundQueue;
}

@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

- (UIColor *) colorForCloudCover:(NSNumber *) cloudCover;
- (UIColor *) colorForTemperature:(NSNumber *) temperature;

@end
