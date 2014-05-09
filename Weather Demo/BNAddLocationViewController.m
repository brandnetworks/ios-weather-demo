//
//  BNAddLocationViewController.m
//  Weather Demo
//
//  Created by bnicholas on 5/8/14.
//  Copyright (c) 2014 Brand Networks. All rights reserved.
//

#import "BNAddLocationViewController.h"
#import "BNLocation.h"
#import "BNLocationStore.h"

@interface BNAddLocationViewController ()

@end

@implementation BNAddLocationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = searchBar.text;
    request.region = self.mapView.region;
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (response.mapItems.count == 0) {
            [[[UIAlertView alloc] initWithTitle:@"No results" message:@"No results for your search query :(" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        } else {
            for (MKMapItem *item in response.mapItems) {
                MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
                annotation.coordinate = item.placemark.coordinate;
                annotation.title = item.placemark.name;
                [self.mapView addAnnotation:annotation];
            }
        }
    }];
    
    [searchBar resignFirstResponder];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        MKAnnotationView *pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"LocationPin"];
        if (!pinView) {
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"LocationPin"];
            pinView.canShowCallout = YES;
            
            UIButton *addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
            [addButton addTarget:self
                          action:@selector(addLocation:)
                forControlEvents:UIControlEventTouchUpInside];
            pinView.rightCalloutAccessoryView = addButton;
        } else {
            pinView.annotation = annotation;
        }
        
        return pinView;
    }
    return nil;
}

- (IBAction)addLocation:(id)sender
{
    MKPointAnnotation *annotation = self.mapView.selectedAnnotations[0];
    BNLocation *newLocation = [[BNLocation alloc] initWithName:annotation.title
                                                   andLatitude:annotation.coordinate.latitude
                                                  andLongitude:annotation.coordinate.longitude];
    [BNLocationStore addLocation:newLocation];
    
    [self performSegueWithIdentifier:@"unwindToLocationList" sender:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
