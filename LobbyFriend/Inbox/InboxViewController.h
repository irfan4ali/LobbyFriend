//
//  InboxViewController.h
//  LobbyFriend
//
//  Created by Imran on 11/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "Inbox.h"

@interface InboxViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *inboxBarButton;
@property (nonatomic, retain) Inbox *inbox;
@property (strong, nonatomic) IBOutlet UITableView *tableData;

- (void)checkExitingDataForDisplay;
- (void)reloadTableData;

@end
