//
//  CreateNodeForPublishingViewController.m
//  iPhoneXMPP
//
//  Created by Ankur Kothari on 10/28/12.
//
//

#import "CreateNodeForPublishingViewController.h"
#import "iPhoneXMPPAppDelegate.h"
@interface CreateNodeForPublishingViewController ()

@end

@implementation CreateNodeForPublishingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

-(IBAction)createNode:(id)sender{
    [[[self appDelegate] xmppStream] addDelegate:self delegateQueue:dispatch_get_current_queue()];
    
    [[[self appDelegate] xmppPubSub] addDelegate:self delegateQueue:dispatch_get_current_queue()];
     
    NSXMLElement *body = [NSXMLElement elementWithName:@"body" stringValue:[NSString stringWithFormat:@"create %@",create.text]];
    
    XMPPPubSub *pubsub = [[self appDelegate] xmppPubSub];
    [pubsub createNode:create.text withOptions:nil];
     [pubsub subscribeToNode:create.text withOptions:nil];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
	    
    XMPPPubSub *pubsub = [[self appDelegate] xmppPubSub];
    [pubsub subscribeToNode:create.text withOptions:nil];
    
    [[[self appDelegate] xmppStream] removeDelegate:self delegateQueue:dispatch_get_current_queue()];
    
    [[[self appDelegate] xmppPubSub] removeDelegate:self delegateQueue:dispatch_get_current_queue()];

}


@end
