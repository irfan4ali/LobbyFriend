//
//  NSDictionary+Value.m
//  LobbyFriend
//
//  Created by Imran on 10/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import "NSDictionary+Value.h"

@implementation NSDictionary (Value)

- (id)objectOrNilForKey:(id)aKey {
    id object = [self objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}
@end
