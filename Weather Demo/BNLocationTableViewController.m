//
//  BNLocationTableViewController.m
//  Weather Demo
//
//  Created by bnicholas on 5/8/14.
//  Copyright (c) 2014 Brand Networks. All rights reserved.
//

#import "BNLocationTableViewController.h"
#import "BNLocation.h"
#import "BNLocationStore.h"
#import "BNViewController.h"

@interface BNLocationTableViewController ()

@end

@implementation BNLocationTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [BNLocationStore addLocation:[[BNLocation alloc] initWithName:@"London" andLatitude:51.508515 andLongitude:-0.125487]];
    [BNLocationStore addLocation:[[BNLocation alloc] initWithName:@"New York" andLatitude:50.705631 andLongitude:-73.978003]];
    [BNLocationStore addLocation:[[BNLocation alloc] initWithName:@"Abu Dhabi" andLatitude:24.466666 andLongitude:54.366666]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    } else {
        return [BNLocationStore locations].count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationCell" forIndexPath:indexPath];
    
    if ([indexPath section] == 0) {
        cell.textLabel.text = @"Current Location";
    } else {
        cell.textLabel.text = ((BNLocation *)[BNLocationStore locations][indexPath.row]).name;
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailViewSegue"]) {
        NSIndexPath *selectedRow = [self.tableView indexPathForSelectedRow];
        BNViewController *vc = segue.destinationViewController;
        
        if ([selectedRow section] == 0) {
            vc.useCurrentLocation = YES;
        } else {
            BNLocation *selectedLocation = [BNLocationStore locations][[selectedRow row]];
            
            vc.useCurrentLocation = NO;
            vc.location = selectedLocation.location;
        }
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)locationAdded:(UIStoryboardSegue *)segue
{
    [self.tableView reloadData];
}


@end
