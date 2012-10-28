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
@interface StreamsViewController ()

@end

@implementation StreamsViewController

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
    [[[self appDelegate] xmppStream] addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    [[[self appDelegate] xmppPubSub] addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    [self getSubscriptions];
    
  
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

-(IBAction)configure:(id)sender{
    ConfigureStreamViewController *configure = [[ConfigureStreamViewController alloc]init];
    
    [self.view addSubview:configure.view];
}

-(void)getSubscriptions{
     XMPPPubSub *pubsub = [[self appDelegate] xmppPubSub];
    NSString *subs = [pubsub getSubscriptions];
   
}

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

-(void)tableView:(UITableView *)tblView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *stream = [subscribingOnly objectAtIndex:indexPath.row];
    
    XMPPPubSub *pubsub = [[self appDelegate] xmppPubSub];
    
  NSXMLElement *items = (NSXMLElement *)[pubsub allItemsForNode:stream];
    
    
    StreamViewController *streamView = [[StreamViewController alloc]init];
    
    [streamView setItems:items forStream:stream];
    
    [self.view addSubview:streamView.view];
    
}


- (void)xmppPubSub:(XMPPPubSub *)sender didReceiveResult:(XMPPIQ *)iq{
    
    NSXMLElement *pubsub = [iq elementForName:@"pubsub"] ;
    NSXMLElement *subscriptions = [pubsub elementForName:@"subscriptions"];
    NSXMLElement *subscription = [subscriptions elementForName:@"subscription"];
    NSArray *arr = [subscriptions elementsForName:@"subscription"];
    
    for (int i = 0; i < [arr count]; i++) {
        NSXMLElement *e = (NSXMLElement *)[arr objectAtIndex:i];
        NSString *node = [e attributeStringValueForName:@"node"];
        NSLog(@"%@",node);
    }
    [tableView reloadData];
}
//- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq
//{
//		NSXMLElement *pubsub = [iq elementForName:@"pubsub"] ;
//    NSXMLElement *subscriptions = [pubsub elementForName:@"subscriptions"];
//    NSXMLElement *subscription = [subscriptions elementForName:@"subscription"];
//    NSArray *arr = [subscriptions elementsForName:@"subscription"];
//    
//    for (int i = 0; i < [arr count]; i++) {
//        NSXMLElement *e = (NSXMLElement *)[arr objectAtIndex:i];
//        NSString *node = [e attributeStringValueForName:@"node"];
//        NSLog(@"%@",node);
//    }
//	return NO;
//}

@end
