//
//  StreamsViewController.m
//  iPhoneXMPP
//
//  Created by Ankur Kothari on 10/27/12.
//
//

/* Displays the streams or nodes that I am following and the streams that I am publishing too. 
*/

#import "StreamsViewController.h"
#import "iPhoneXMPPAppDelegate.h"
#import "ConfigureStreamViewController.h"
#import "StreamViewController.h"
#import "HomeViewController.h"
@interface StreamsViewController ()

@end

@implementation StreamsViewController
@synthesize subscribingOnly;
@synthesize tableView;
@synthesize stream;
@synthesize home;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"done"
                                                                       style:UIBarButtonItemStyleDone target:self action:@selector(configure1:)];
    self.navigationItem.rightBarButtonItem = settingsButton;
   
    [super viewDidLoad];
   
    // Do any additional setup after loading the view from its nib.
}
- (iPhoneXMPPAppDelegate *)appDelegate
{
	return (iPhoneXMPPAppDelegate *)[[UIApplication sharedApplication] delegate];
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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UITableView
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////







- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
	
	return [subscribingOnly count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
	}
	
    cell.textLabel.text = [subscribingOnly objectAtIndex:indexPath.row];
		
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    NSString *sstream = [subscribingOnly objectAtIndex:indexPath.row];
    
    XMPPPubSub *pubsub = [[self appDelegate] xmppPubSub];
    
  NSXMLElement *items = (NSXMLElement *)[pubsub allItemsForNode:sstream];
    
    
    stream = [[StreamViewController alloc]init];
    
    [stream setItems:items forStream:sstream];
    
    UINavigationController *nav = [self appDelegate].navigationController;
    [nav pushViewController:stream animated:YES];
    
}






@end
