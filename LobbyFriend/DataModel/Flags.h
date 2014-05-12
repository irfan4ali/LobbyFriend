//
//  Flags.h
//  LobbyFriend
//
//  Created by Imran on 14/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Flags : NSManagedObject

@property (nonatomic, retain) NSNumber * likeId;
@property (nonatomic, retain) NSNumber * reportPortId;
@property (nonatomic, retain) NSNumber * isUserLike;
@property (nonatomic, retain) NSNumber * isUserReported;

@end
