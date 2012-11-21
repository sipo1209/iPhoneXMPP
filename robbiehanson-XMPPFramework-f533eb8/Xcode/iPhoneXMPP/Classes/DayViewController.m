//
//  DayViewController.m
//  iPhoneXMPP
//
//  Created by Ankur Kothari on 11/16/12.
//
//

#import "DayViewController.h"

@interface DayViewController ()

@end

@implementation DayViewController
@synthesize dayDetails,tvView;
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
    NSString *tv = [NSString stringWithFormat:@"%@",dayDetails];
    tvView.text = tv;
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
