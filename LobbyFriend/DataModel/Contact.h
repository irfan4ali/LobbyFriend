//
//  Contact.h
//  LobbyFriend
//
//  Created by Imran on 10/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Contact : NSManagedObject

@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * facebook;
@property (nonatomic, retain) NSString * twitter;
@property (nonatomic, retain) NSString * linkedin;

@end
