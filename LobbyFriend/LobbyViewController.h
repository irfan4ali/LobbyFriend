//
//  LobbyViewController.h
//  LobbyFriend
//
//  Created by Imran on 18/03/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lobby.h"
#import "UserProfileViewController.h"

@interface LobbyViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *lobbyBarButton;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) IBOutlet UIView *content;
@property (nonatomic,retain) Lobby *lobby;
- (void)UserProfileAction;
- (void)getProfileID:(UserProfileViewController *)profileName;
@end
