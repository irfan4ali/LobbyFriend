//
//  Event.h
//  LobbyFriend
//
//  Created by Imran on 22/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Post;

@interface Event : NSManagedObject

@property (nonatomic, retain) NSNumber * blocksize;
@property (nonatomic, retain) NSNumber * offset;
@property (nonatomic, retain) NSString * eventcount;
@property (nonatomic, retain) NSMutableArray *eventArray;
@property (nonatomic, retain) Post *stickyPost;

@end
