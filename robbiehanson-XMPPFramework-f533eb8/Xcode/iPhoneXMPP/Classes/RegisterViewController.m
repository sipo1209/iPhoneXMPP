//
//  RegsiterViewController.m
//  iPhoneXMPP
//
//  Created by Ankur Kothari on 10/26/12.
//
//

#import "RegisterViewController.h"
#import "iPhoneXMPPAppDelegate.h"
#import "HomeViewController.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize home;
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

- (void)setField:(UITextField *)field forKey:(NSString *)key
{
    if (field.text != nil)
    {
        [[NSUserDefaults standardUserDefaults] setObject:field.text forKey:key];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
}

- (void)createAccount
{
	
	
	    NSError *error = nil;
		
    NSString *spassword = password.text;
    
	BOOL success = [[[self appDelegate] xmppStream] registerWithPassword:spassword error:&error];
    
  	
}


-(IBAction)signUp:(id)sender{
    
    
    [self setField:username forKey:kXMPPmyJID];
   // [self setField:password forKey:kXMPPmyPassword];
    NSError *error = nil;

    
    [[self appDelegate] connect];
    
    [[[self appDelegate] xmppStream ]addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
   
    
    UINavigationController *nav = [self appDelegate].navigationController;
    [nav popViewControllerAnimated:YES];
    
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
    [self createAccount];
}

- (IBAction)hideKeyboard:(id)sender {
    [sender resignFirstResponder];
    [self setField:username forKey:kXMPPmyJID];
    // [self setField:password forKey:kXMPPmyPassword];
    NSError *error = nil;
    
    
    [[self appDelegate] connect];
    
    [[[self appDelegate] xmppStream ]addDelegate:self delegateQueue:dispatch_get_main_queue()];
    

}
@end
