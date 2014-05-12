//
//  Deals.h
//  LobbyFriend
//
//  Created by Imran on 21/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Post.h"

@interface Deals : NSManagedObject

@property (nonatomic, retain) NSNumber * blocksize;
@property (nonatomic, retain) NSNumber * offset;
@property (nonatomic, retain) NSNumber * dealcount;
@property (nonatomic, retain) NSMutableArray *dealsArray;
@property (retain, nonatomic) Post *stickyPost;

@end
