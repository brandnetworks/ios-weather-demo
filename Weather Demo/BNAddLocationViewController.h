//
//  BNAddLocationViewController.h
//  Weather Demo
//
//  Created by bnicholas on 5/8/14.
//  Copyright (c) 2014 Brand Networks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface BNAddLocationViewController : UIViewController < MKMapViewDelegate, UISearchBarDelegate >

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)addLocation:(id)sender;

@end
