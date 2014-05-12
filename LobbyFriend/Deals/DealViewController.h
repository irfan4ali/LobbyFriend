//
//  DealViewController.h
//  LobbyFriend
//
//  Created by Imran on 11/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "Deals.h"
@interface DealViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *dealBarButton;
@property (strong, nonatomic) NSArray *dataArray;

@property (retain,nonatomic) Deals *deals;

- (void)checkExitingDataForDisplay;
@property (strong, nonatomic) IBOutlet UITableView *dataTable;
- (void)reloadTableData;

@end
