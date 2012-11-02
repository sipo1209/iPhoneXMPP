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
-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(updateView:)
     name:@"updateRoot"
     object:nil];
}

-(void)updateView:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSString *message = nil;
    NSString* node = [userInfo valueForKey:@"node"] ;
    
    
    
    id alert = [userInfo objectForKey:@"alert"];
    if ([alert isKindOfClass:[NSString class]]) {
        message = alert;
    } else if ([alert isKindOfClass:[NSDictionary class]]) {
        message = [alert objectForKey:@"body"];
    }
    
    stream = node;
    XMPPPubSub *pubsub = [[self appDelegate]xmppPubSub];
    NSString *items = [pubsub allItemsForNode:node];
    NSString *textString = tvView.text;
   
    textString = [textString stringByAppendingFormat:@"\n%@",node];
       
	tvView.text = textString;
   
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
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


- (IBAction)hideKeyboard:(id)sender {
    [sender resignFirstResponder];
    
}

- (BOOL)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)book
{
    NSString *textString = tvView.text;
    for (int i = 0; i < [book childCount]; i++) {
        DDXMLNode *node = [book childAtIndex:i];
        NSString *name = [node name];
        NSString *value = [node stringValue];
        textString = [textString stringByAppendingFormat:@"\n%@",value];
        break;
    }
	tvView.text = textString;
	return NO;
}

-(IBAction)publish:(id)sender{
    NSXMLElement *body = [NSXMLElement elementWithName:@"body" stringValue:[NSString stringWithFormat:@"publish %@ %@",stream,textField.text]];
    
    XMPPJID *to = [XMPPJID jidWithString:@"bot@ankurs-macbook-pro.local"];
    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:to];
    [message addChild:body];
    
    XMPPStream *str = [self appDelegate].xmppStream;
    [str sendElement:message];

   
}
@end
