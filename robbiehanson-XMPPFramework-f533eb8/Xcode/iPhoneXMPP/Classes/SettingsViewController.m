//
//  SettingsViewController.m
//  iPhoneXMPP
//
//  Created by Eric Chamberlain on 3/18/11.
//  Copyright 2011 RF.com. All rights reserved.
//

#import "SettingsViewController.h"
#import "iPhoneXMPPAppDelegate.h"
#import "StreamsViewController.h"
NSString *const kXMPPmyJID = @"kXMPPmyJID";
NSString *const kXMPPmyPassword = @"kXMPPmyPassword";


@implementation SettingsViewController
@synthesize streams;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Init/dealloc methods
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)awakeFromNib {
  self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark View lifecycle
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)viewDidLoad{
    	[[[self appDelegate]xmppStream] addDelegate:self delegateQueue:dispatch_get_main_queue()];
    	
}

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
	//DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    NSLog(@"authenticated");
    
//    StreamsViewController *streams = [[StreamsViewController alloc] init];
//    
//    [self.view addSubview:streams.view];

    [[[self appDelegate] xmppStream] addDelegate:self delegateQueue:dispatch_get_current_queue()];
    
    [[[self appDelegate] xmppPubSub] addDelegate:self delegateQueue:dispatch_get_current_queue()];
    
    XMPPPubSub *pubsub = [[self appDelegate] xmppPubSub];
    
    //    NSString *subs = [pubsub allItemsForNode:@"hello"];
    
    
    NSString *subs = [pubsub getSubscriptions];
    

}

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
	//DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    NSLog(@"not authenticated");

}



- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
	NSLog(@"recieved");
}



- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  jidField.text = [[NSUserDefaults standardUserDefaults] stringForKey:kXMPPmyJID];
  passwordField.text = [[NSUserDefaults standardUserDefaults] stringForKey:kXMPPmyPassword];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Private
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)setField:(UITextField *)field forKey:(NSString *)key
{
  if (field.text != nil) 
  {
    [[NSUserDefaults standardUserDefaults] setObject:field.text forKey:key];
  } else {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
  }
}
- (iPhoneXMPPAppDelegate *)appDelegate
{
	return (iPhoneXMPPAppDelegate *)[[UIApplication sharedApplication] delegate];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Actions
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (IBAction)done:(id)sender
{
   // StreamsViewController *streams = [[StreamsViewController alloc]init];
    
  [self setField:jidField forKey:kXMPPmyJID];
  [self setField:passwordField forKey:kXMPPmyPassword];
    
    if ([[self appDelegate] connect])
	{
		//titleLabel.text = [[[[self appDelegate] xmppStream] myJID] bare];
	} else
	{
		//titleLabel.text = @"No JID";
	}

    
//    UINavigationController *nav = [self appDelegate].navigationController;
//    [nav presentViewController:streams animated:normal completion:nil];

 // [self dismissModalViewControllerAnimated:YES];
}
- (void)xmppPubSub:(XMPPPubSub *)sender didReceiveResult:(XMPPIQ *)iq{
    
    NSXMLElement *pubsub = [iq elementForName:@"pubsub"] ;
    NSXMLElement *subscriptions = [pubsub elementForName:@"subscriptions"];
    NSXMLElement *subscription = [subscriptions elementForName:@"subscription"];
    NSArray *arr = [subscriptions elementsForName:@"subscription"];
    NSMutableArray *nsarr = [[NSMutableArray alloc]init];
    for (int i = 0; i < [arr count]; i++) {
        NSXMLElement *e = (NSXMLElement *)[arr objectAtIndex:i];
        NSString *node = [e attributeStringValueForName:@"node"];
        NSLog(@"%@",node);
         NSRange range = [node rangeOfString:@":"];
        if (node != nil && !(range.length > 0)){
            if (![nsarr containsObject:node]) {
            [nsarr addObject:node];
        }
        }
        if (i == [arr count] - 1) {
          
        streams = [[StreamsViewController alloc] init];
        streams.subscribingOnly = nsarr;
        [self.view addSubview:streams.view];
        }
        
    }
    
    
        
    
            //
}


- (IBAction)hideKeyboard:(id)sender {
  [sender resignFirstResponder];
  [self done:sender];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Getter/setter methods
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@synthesize jidField;
@synthesize passwordField;

@end
