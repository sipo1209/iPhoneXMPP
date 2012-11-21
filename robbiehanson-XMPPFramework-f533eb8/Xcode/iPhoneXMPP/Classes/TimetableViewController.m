//
//  TimetableViewController.m
//  iPhoneXMPP
//
//  Created by Ankur Kothari on 11/16/12.
//
//

#import "TimetableViewController.h"
#import "JSONKit.h"
#import "DayViewController.h"
@interface TimetableViewController ()

@end

@implementation TimetableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    weekdays = [[NSMutableArray alloc]init];
    NSMutableArray *   weekdays = [[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *timetable = [prefs objectForKey:@"timetable"];
    NSSet *uniqueElements;
    NSDictionary *resultsDictionary = [timetable objectFromJSONData];
    
    NSArray * entries = [resultsDictionary objectForKey:@"entries"];
    
    for(int i = 0;i<[entries count];i++){
        
        
        NSDictionary *a = [entries objectAtIndex:i];
        [weekdays addObject:[a objectForKey:@"weekday"]];
        
        
    }
    uniqueElements = [NSSet setWithArray:weekdays];
    NSLog(@"%@",uniqueElements);
    weekdayset = [uniqueElements allObjects];

        
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [weekdayset count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   
      
    /* Now that the cell is configured we return it to the table view so that it can display it */
    if (cell == nil) {
       
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
   
    }
    cell.textLabel.text = [weekdayset objectAtIndex:indexPath.row];
    
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *timetable = [prefs objectForKey:@"timetable"];
    NSSet *uniqueElements;
    NSDictionary *resultsDictionary = [timetable objectFromJSONData];
    
    NSArray * entries = [resultsDictionary objectForKey:@"entries"];
    NSString *day = [weekdayset objectAtIndex:indexPath.row];
    NSMutableArray *mutArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<[entries count]; i++) {
        NSDictionary *d = [entries objectAtIndex:i];
        NSString *week = [d objectForKey:@"weekday"];
        if ([week isEqualToString:day]) {
            [mutArray addObject:d];
        }
    }
     DayViewController *dayViewController = [[DayViewController alloc] init];
    dayViewController.dayDetails = mutArray;
    [self.view addSubview:dayViewController.view];
     
}

@end
