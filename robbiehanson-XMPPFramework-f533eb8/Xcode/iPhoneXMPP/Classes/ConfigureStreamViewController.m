//
//  ConfigureStreamViewController.m
//  iPhoneXMPP
//
//  Created by Ankur Kothari on 10/27/12.
//
//

#import "ConfigureStreamViewController.h"
#import "iPhoneXMPPAppDelegate.h"
#import "CreateNodeForPublishingViewController.h"
#import "SubscribeToNodeViewController.h"
@interface ConfigureStreamViewController ()

@end

@implementation ConfigureStreamViewController
@synthesize streams,create,subscribe;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        options = [[NSMutableArray alloc]init];
        
    }
    return self;
}

- (iPhoneXMPPAppDelegate *)appDelegate
{
	return (iPhoneXMPPAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(IBAction)streams:(id)sender{
    [[[self appDelegate] xmppStream] addDelegate:self delegateQueue:dispatch_get_current_queue()];
   
    [[[self appDelegate] xmppPubSub] addDelegate:self delegateQueue:dispatch_get_current_queue()];
    
        XMPPPubSub *pubsub = [[self appDelegate] xmppPubSub];
   
          NSString *subs = [pubsub getSubscriptions];
}


-(IBAction)publishNewStream:(id)sender{
    create = [[CreateNodeForPublishingViewController alloc]init];
    UINavigationController *nav = [self appDelegate].navigationController;
    [nav pushViewController:create animated:YES];
}

-(IBAction)subscribeNewStream:(id)sender{
    subscribe = [[SubscribeToNodeViewController alloc] init];
    UINavigationController *nav = [self appDelegate].navigationController;
    [nav pushViewController:subscribe animated:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)xmppPubSub:(XMPPPubSub *)sender didReceiveResult:(XMPPIQ *)iq{
    
    NSXMLElement *pubsub = [iq elementForName:@"pubsub"] ;
    NSXMLElement *subscriptions = [pubsub elementForName:@"subscriptions"];
    NSXMLElement *subscription = [subscriptions elementForName:@"subscription"];
    NSArray *arr = [subscriptions elementsForName:@"subscription"];
    NSMutableArray *nsarr = [[NSMutableArray alloc]init];
    streams = [[StreamsViewController alloc] initWithNibName:@"StreamsViewController" bundle:nil];
    if ([arr count] == 0) {
       
        UINavigationController *nav = [self appDelegate].navigationController;
        [nav pushViewController:streams animated:YES];
    }
    for (int i = 0; i < [arr count]; i++) {
        NSXMLElement *e = (NSXMLElement *)[arr objectAtIndex:i];
        NSString *node = [e attributeStringValueForName:@"node"];
//        [sender deleteNode:node];
        NSLog(@"%@",node);
        NSRange range = [node rangeOfString:@":"];
        if (node != nil && !(range.length > 0)){
            if (![nsarr containsObject:node]) {
                [nsarr addObject:node];
            }
        }
        if (i == [arr count] - 1) {
            
            //  streams = [[StreamsViewController alloc] init];
              streams.subscribingOnly = nsarr;
            UINavigationController *nav = [self appDelegate].navigationController;
            [nav pushViewController:streams animated:YES];
            
        }
        
    }
    
    
    
    
    //
}



@end
