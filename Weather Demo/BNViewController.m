//
//  BNViewController.m
//  Weather Demo
//
//  Created by Ben Nicholas on 4/4/14.
//  Copyright (c) 2014 Brand Networks. All rights reserved.
//

#import "BNViewController.h"

@interface BNViewController ()

- (UIColor *)mixColor:(UIColor *)firstColor withColor:(UIColor *)secondColor atPercent:(CGFloat)firstColorPercent;

@end

@implementation BNViewController

- (UIColor *)clearSkyColor
{
    return [UIColor colorWithRed:0.14 green:0.69 blue:0.91 alpha:1.0];
}

- (UIColor *)cloudySkyColor
{
    return [UIColor colorWithRed:0.48 green:0.43 blue:0.49 alpha:1.0];
}

- (UIColor *)hotTempColor
{
    return [UIColor colorWithRed:1.0 green:0.2 blue:0.0 alpha:1.0];
}

- (UIColor *)coldTempColor
{
    return [UIColor colorWithRed:0.39 green:0.84 blue:0.94 alpha:1.0];
}

// clear-day, clear-night, rain, snow, sleet, wind, fog, cloudy, partly-cloudy-day, or partly-cloudy-night default

#pragma mark View Lifecycle Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.temperatureLabel.hidden = YES;
	
	backgroundQueue = [[NSOperationQueue alloc] init];
	
	NSURL *forecastUrl = [NSURL URLWithString:@"https://api.forecast.io/forecast/2fffadab9510c0beb91ad51e73794403/43.160,-77.615"];\
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:forecastUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // Load the response into JSON
        NSError *localError;
        NSDictionary *forecast = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&localError];
        
        // Pull out the values we need
        NSNumber *temp       = [forecast valueForKeyPath:@"currently.apparentTemperature"];
        NSNumber *cloudCover = [forecast valueForKeyPath:@"currently.cloudCover"];
        NSString *iconName   = [forecast valueForKeyPath:@"currently.icon"];
        
        // Get the colors for the gradient
        UIColor *topColor    = [self colorForCloudCover:cloudCover];
        UIColor *bottomColor = [self colorForTemperature:temp];
        
        // Build the gradient
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = self.view.bounds;
        gradient.colors = @[(id)[topColor CGColor], (id)[bottomColor CGColor]];
        
        // Bounce back to the Main queue for UI updates
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the temperature label
            self.temperatureLabel.text = [NSString stringWithFormat:@"%ld°", [temp integerValue]];
            self.temperatureLabel.hidden = NO;
            
            // Pushin in the gradient layer
            [self.view.layer insertSublayer:gradient atIndex:0];
            self.view.backgroundColor = [UIColor clearColor];
            
            // Update the forecast image
            self.iconView.image = [UIImage imageNamed:iconName];
        });

    }];
    [task resume];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Color helpers
-(UIColor *)colorForCloudCover:(NSNumber *)cloudCover
{
    CGFloat cloudPercent = [cloudCover floatValue];
    
    return [self mixColor:self.cloudySkyColor withColor:self.clearSkyColor atPercent:cloudPercent];
}

-(UIColor *)colorForTemperature:(NSNumber *)temperature
{
    CGFloat cappedTemperature = MAX(MIN([temperature floatValue], 90.0), 37.0);
    CGFloat hotPercent = (cappedTemperature - 37.0) / 53.0;

    return [self mixColor:self.hotTempColor withColor:self.coldTempColor atPercent:hotPercent];
}

- (UIColor *)mixColor:(UIColor *)firstColor withColor:(UIColor *)secondColor atPercent:(CGFloat)firstColorPercent
{
    CGFloat firstRed, firstGreen, firstBlue, firstAlpha, secondRed, secondGreen, secondBlue, secondAlpha;
    CGFloat resultRed, resultGreen, resultBlue, secondColorPercent;
    
    secondColorPercent = 1.0 - firstColorPercent;
    
    [firstColor getRed:&firstRed green:&firstGreen blue:&firstBlue alpha:&firstAlpha];
    [secondColor getRed:&secondRed green:&secondGreen blue:&secondBlue alpha:&secondAlpha];
    
    resultRed = firstRed * firstColorPercent + secondRed * secondColorPercent;
    resultGreen = firstGreen * firstColorPercent + secondGreen * secondColorPercent;
    resultBlue = firstBlue * firstColorPercent + secondBlue * secondColorPercent;
    
    return [UIColor colorWithRed:resultRed green:resultGreen blue:resultBlue alpha:1.0];
}


@end
