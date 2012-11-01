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
    



    [[[self appDelegate] xmppStream] addDelegate:self delegateQueue:dispatch_get_current_queue()];
    
    
    
        XMPPRoster *roster =  [[self appDelegate] xmppRoster ];
        [roster subscribePresenceToUser:[XMPPJID jidWithString:@"bot@ankurs-macbook-pro.local"]];
    //
        [roster addDelegate:self delegateQueue:dispatch_get_current_queue()];
    //
     NSXMLElement *body = [NSXMLElement elementWithName:@"body" stringValue:@"registered"];
    //
        XMPPJID *to = [XMPPJID jidWithString:@"bot@ankurs-macbook-pro.local/Smack"];
        XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:to];
        [message addChild:body];
    //
        XMPPStream *str = [self appDelegate].xmppStream;
        [str sendElement:message];
    streams = [[ConfigureStreamViewController alloc] initWithNibName:@"ConfigureStreamViewController" bundle:nil];
    
    UINavigationController *nav = [self appDelegate].navigationController;
    [nav pushViewController:streams animated:YES];
//    XMPPPubSub *pubsub = [[self appDelegate] xmppPubSub];
//    //
//    // NSString *subs = [pubsub allItemsForNode:@"hello3"];
//    //
//    //
//      NSString *subs = [pubsub getSubscriptions];

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
    
    [[self appDelegate].xmppStream setMyJID:[XMPPJID jidWithString:[[NSUserDefaults standardUserDefaults] stringForKey:kXMPPmyJID]]];
    
    
     NSError *error = nil;
    [[self appDelegate].xmppStream  disconnect];
    [[self appDelegate] connect];

   

    
   ;
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
