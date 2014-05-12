//
//  Role.h
//  LobbyFriend
//
//  Created by Imran on 10/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Role : NSManagedObject

@property (nonatomic, retain) NSString * roleName;
@property (nonatomic, retain) NSNumber * userType;

@end
