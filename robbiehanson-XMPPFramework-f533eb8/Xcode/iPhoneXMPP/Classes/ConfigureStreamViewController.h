//
//  ConfigureStreamViewController.h
//  iPhoneXMPP
//
//  Created by Ankur Kothari on 10/27/12.
//
//

#import <UIKit/UIKit.h>
#import "StreamsViewController.h"
#import "CreateNodeForPublishingViewController.h"
#import "SubscribeToNodeViewController.h"
@interface ConfigureStreamViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *tableView;
    NSMutableArray *options;
    IBOutlet UITextField *addField;
    StreamsViewController *streams;
    CreateNodeForPublishingViewController *create;
    SubscribeToNodeViewController *subscribe ;
}
@property (nonatomic,retain) StreamsViewController *streams;
@property (nonatomic,retain) CreateNodeForPublishingViewController *create;
@property (nonatomic,retain) SubscribeToNodeViewController *subscribe ;
@end
