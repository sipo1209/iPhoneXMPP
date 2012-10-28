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



-(IBAction)publishNewStream:(id)sender{
    CreateNodeForPublishingViewController *create = [[CreateNodeForPublishingViewController alloc]init];
    [self.view addSubview:create.view];
}

-(IBAction)subscribeNewStream:(id)sender{
    SubscribeToNodeViewController *subscribe = [[SubscribeToNodeViewController alloc] init];
    [self.view addSubview:subscribe.view];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
