//
//  BNViewController.m
//  Weather Demo
//
//  Created by Ben Nicholas on 4/4/14.
//  Copyright (c) 2014 Brand Networks. All rights reserved.
//

#import "BNViewController.h"

@interface BNViewController ()

@end

@implementation BNViewController

#pragma mark View Lifecycle Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.temperatureLabel.hidden = YES;
	
	backgroundQueue = [[NSOperationQueue alloc] init];
	
	NSURL *forecastUrl = [NSURL URLWithString:@"https://api.forecast.io/forecast/2fffadab9510c0beb91ad51e73794403/43.160,-77.615"];
	NSURLRequest *req = [NSURLRequest requestWithURL:forecastUrl];
	[NSURLConnection sendAsynchronousRequest:req
                                       queue:backgroundQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               NSError *localError;
                               NSDictionary *forecast = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&localError];
                               
                               NSNumber *temp = [forecast valueForKeyPath:@"currently.apparentTemperature"];
                               NSNumber *cloudCover = [forecast valueForKeyPath:@"currently.cloudCover"];
                               NSString *iconName = [forecast valueForKeyPath:@"currently.icon"];
                               
                               UIColor *topColor = [self colorForCloudCover:cloudCover];
                               UIColor *bottomColor = [self colorForTemperature:temp];
                               
                               CAGradientLayer *gradient = [CAGradientLayer layer];
                               gradient.frame = self.view.bounds;
                               gradient.colors = @[(id)[topColor CGColor], (id)[bottomColor CGColor]];
                               
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   self.temperatureLabel.text = [NSString stringWithFormat:@"%d°", [temp integerValue]];
                                   self.temperatureLabel.hidden = NO;
                                   
                                   [self.view.layer insertSublayer:gradient atIndex:0];
                                   self.view.backgroundColor = [UIColor clearColor];
                               });
                           }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Color helpers
-(UIColor *)colorForCloudCover:(NSNumber *)cloudCover
{
    CGFloat cloudPercent = [cloudCover floatValue],
            clearPercent = 1.0 - [cloudCover floatValue];
    
    CGFloat cloudRed = 0.48,
            cloudGreen = 0.43,
            cloudBlue = 0.49,
            skyRed = 0.14,
            skyGreen = 0.69,
            skyBlue = 0.91;
 
    CGFloat resultRed, resultGreen, resultBlue;
    
    resultRed = cloudRed * cloudPercent + skyRed * clearPercent;
    resultGreen = cloudGreen * cloudPercent + skyGreen * clearPercent;
    resultBlue = cloudBlue * cloudPercent + skyBlue * clearPercent;
    
    return [UIColor colorWithRed:resultRed green:resultGreen blue:resultBlue alpha:1.0];
}

-(UIColor *)colorForTemperature:(NSNumber *)temperature
{
    CGFloat hotRed = 1.0,
            hotGreen = 0.2,
            hotBlue = 0.0,
            coldRed = 0.39,
            coldGreen = 0.84,
            coldBlue = 0.94;
    
    CGFloat resultRed, resultGreen, resultBlue;
    
    CGFloat hotPercent = MAX(MIN([temperature floatValue], 90.0), 37.0) / 53.0,
            coldPercent = 1.0 - hotPercent;
    
    resultRed = hotRed * hotPercent + coldRed * coldPercent;
    resultGreen = hotGreen * hotPercent + coldGreen * coldPercent;
    resultBlue = hotBlue * hotPercent + coldBlue * coldPercent;
    
    return [UIColor colorWithRed:resultRed green:resultGreen blue:resultBlue alpha:1.0];
}


@end
