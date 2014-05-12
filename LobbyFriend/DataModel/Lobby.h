//
//  Lobby.h
//  LobbyFriend
//
//  Created by Imran on 13/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class Post,Hotel;

@interface Lobby : NSManagedObject

@property (nonatomic, retain) NSString * blocksize;
@property (nonatomic, retain) NSString * offset;
@property (nonatomic, retain) NSNumber * postcount;
@property (nonatomic, retain) NSString * sticky;
@property (nonatomic, retain)Post *stickyPost;
@property (nonatomic, retain)Hotel *hotel;
@property (strong,nonatomic) NSMutableArray *postArray;


- (NSInteger)totalSection;


@end
