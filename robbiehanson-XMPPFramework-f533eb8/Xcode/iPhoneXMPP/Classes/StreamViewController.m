//
//  StreamViewController.m
//  iPhoneXMPP
//
//  Created by Ankur Kothari on 10/27/12.
//
//

#import "StreamViewController.h"
#import "iPhoneXMPPAppDelegate.h"
@interface StreamViewController ()

@end

@implementation StreamViewController

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
    tvView.text = (NSString *)items;
    
    XMPPPubSub *pubsub = [[self appDelegate]xmppPubSub];
    
    [[[self appDelegate]xmppStream] addDelegate:self delegateQueue:dispatch_get_main_queue()];
    

    
    // Do any additional setup after loading the view from its nib.
}

- (iPhoneXMPPAppDelegate *)appDelegate
{
	return (iPhoneXMPPAppDelegate *)[[UIApplication sharedApplication] delegate];
}






-(void)setItems:(NSXMLElement *)localItems forStream:(NSString *)localStream{
    items = localItems;
    stream = localStream;
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

-(void)getItems{
    
    XMPPPubSub *pubsub = [[self appDelegate] xmppPubSub];
    
    NSXMLElement *items = (NSXMLElement *)[pubsub allItemsForNode:stream];
    
    tvView.text = (NSString *)items;

}


-(IBAction)publish:(id)sender{
    XMPPPubSub *pubsub = [[self appDelegate] xmppPubSub];
    NSXMLElement * item = [NSXMLElement elementWithName:@"entry" stringValue:@"hi"];
    NSXMLElement *body = [NSXMLElement elementWithName:@"body" stringValue:textField.text];
       
        [pubsub publishToNode:stream entry:item];

    [self getItems];
}
@end
