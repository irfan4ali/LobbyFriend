//
//  InboxDataController.h
//  LobbyFriend
//
//  Created by Imran on 22/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Inbox;

@interface InboxDataController : NSObject

@property (nonatomic,retain) Inbox *inbox;
+ (InboxDataController *)getInboxInstance;

- (void)addDataOfInbox: (Inbox *)_inbox;
- (Inbox *)getDataOfInbox;

@end
