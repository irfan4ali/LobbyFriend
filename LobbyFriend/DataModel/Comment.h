//
//  Comment.h
//  LobbyFriend
//
//  Created by Imran on 14/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class  User;
@interface Comment : NSManagedObject

@property (nonatomic, retain) NSNumber * commentid;
@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSString * created;
@property (nonatomic, retain) NSString * postedfrom;
@property (nonatomic, retain) User *poster;

@end
