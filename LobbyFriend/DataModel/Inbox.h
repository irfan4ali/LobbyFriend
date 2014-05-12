//
//  Inbox.h
//  LobbyFriend
//
//  Created by Imran on 22/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Inbox : NSManagedObject

@property (nonatomic, retain) NSNumber * blocksize;
@property (nonatomic, retain) NSNumber * offset;
@property (nonatomic, retain) NSString * inboxcount;
@property (nonatomic, retain) NSString * all;
@property (nonatomic, retain) NSString * sent;
@property (nonatomic, retain) NSString * unread;
@property (nonatomic,retain) NSMutableArray *messageArray;

@end
