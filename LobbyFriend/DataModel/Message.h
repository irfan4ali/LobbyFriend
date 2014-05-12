//
//  Message.h
//  LobbyFriend
//
//  Created by Imran on 22/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class User;

@interface Message : NSManagedObject

@property (nonatomic, retain) NSString * message_id;
@property (nonatomic, retain) NSNumber * is_new;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSString * created_time;
@property (nonatomic, retain) NSString * timestamp;
@property (nonatomic, retain) NSString * read_status;
@property (nonatomic, retain) User *sender;
@end
