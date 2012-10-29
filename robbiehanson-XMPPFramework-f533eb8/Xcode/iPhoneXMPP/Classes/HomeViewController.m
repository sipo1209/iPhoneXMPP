//
//  HomeViewController.m
//  iPhoneXMPP
//
//  Created by Ankur Kothari on 10/27/12.
//
//

#import "HomeViewController.h"
#import "SettingsViewController.h"
#import "iPhoneXMPPAppDelegate.h"
#import "RegisterViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

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

-(IBAction)signIn:(id)sender{
    SettingsViewController *settings = [[SettingsViewController alloc]init];
    UINavigationController *nav = [self appDelegate].navigationController;
    [nav pushViewController:settings animated:YES];
 //   [nav presentViewController:settings animated:NO completion:nil];
}

-(IBAction)signUp:(id)sender{
    RegisterViewController *register1 = [[RegisterViewController alloc]init];
    UINavigationController *nav = [self appDelegate].navigationController;
    [nav pushViewController:register1 animated:YES];
  //  [nav presentViewController:register1 animated:NO completion:nil];

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

@end
