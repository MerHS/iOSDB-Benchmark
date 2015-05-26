//
//  DBManager.m
//  Realm
//
//  Created by JHY on 2015. 5. 20..
//  Copyright (c) 2015년 KINETC. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

RLMRealm *realm;
DBSender *defaultSender;

-(id) init
{
    if(self = [super init])
        [self initializeDB];
    
    return self;
}

-(void) initializeDB
{
    realm = [RLMRealm defaultRealm];
    if (defaultSender == nil){
        if ((defaultSender = [[DBSender allObjects] firstObject]) == nil){
            defaultSender = [[DBSender alloc] init];
            [realm beginWriteTransaction];
            [realm addObject:defaultSender];
            [realm commitWriteTransaction];
        }
    }
}


-(void) insertMessage:(DBMessage *)dbMessage
{
    [realm beginWriteTransaction];
    [realm addObject:dbMessage];
    [realm commitWriteTransaction];
}

-(void) insertMessageWithTransaction:(int)repeatCount senderIdMax:(int)senderIdMax
{
    [realm beginWriteTransaction];
    for (int i = 0; i < repeatCount; i++) {
        [realm addObject:[DBMessage getRandomMessage:defaultSender]];
    }
    [realm commitWriteTransaction];
}

-(void) insertSender:(DBSender *)dbSender
{
    [realm beginWriteTransaction];
    [realm addObject:dbSender];
    [realm commitWriteTransaction];
}

-(void) insertSenderWithTransaction:(int)repeatCount
{
    [realm beginWriteTransaction];
    for (int i = 0; i < repeatCount; i++) {
        [realm addObject:[DBSender getRandomSender]];
    }
    [realm commitWriteTransaction];
}

-(DBMessage *) selectMessage:(NSInteger)withID
{
    return [DBMessage objectForPrimaryKey:[NSNumber numberWithInteger:withID]];
}

-(DBSender *) selectSender:(NSString *)withName
{
    return [[DBSender objectsWithPredicate:
             [NSPredicate predicateWithFormat:@"senderName == %@", withName]] firstObject];
}

-(void) updateMessageViewed:(NSInteger)senderID
{
    RLMResults *results = [DBMessage objectsWithPredicate:
                           [NSPredicate predicateWithFormat:@"viewed == NO AND senderID.senderID == %@", senderID]];
    [realm beginWriteTransaction];
    [results setValue:[NSNumber numberWithBool:YES] forKey:@"viewed"];
    [realm commitWriteTransaction];
}

-(NSMutableArray *) fetchBetweenDate:(NSDate *)startDate endDate:(NSDate *)endDate fetchMax:(NSInteger)fetchMax
{
    NSMutableArray *fetchData = [[NSMutableArray alloc] init];
    RLMResults *results = [DBMessage objectsWithPredicate:
                           [NSPredicate predicateWithFormat:@"sendTime >= %@ AND sendTIME <= %@", startDate, endDate]];
    NSInteger i = 0;
    for (id objects in results){
        if (i++ >= fetchMax) break;
        [fetchData addObject:objects];
    }
    return fetchData;
}

-(int) unseenMessageCountWithID:(NSInteger)senderID
{
    RLMResults *result = [DBMessage objectsWithPredicate:
                          [NSPredicate predicateWithFormat:@"viewed = NO AND senderID.senderID = %@", senderID]];
    
    return (int)[result count];
}

-(NSMutableArray *) fetchMessageWithName:(NSString *)senderName fetchCount:(NSInteger)fetchMax
{
    NSMutableArray *fetchData = [[NSMutableArray alloc] initWithCapacity:fetchMax];
    RLMResults *results = [DBMessage objectsWithPredicate:
                           [NSPredicate predicateWithFormat:@"senderID.senderName == %@", senderName]];
    
    NSInteger i = 0;
    for (id objects in results){
        if (i++ >= fetchMax) break;
        [fetchData addObject:objects];
    }
    return fetchData;
}

-(void) deleteOldMessage:(NSDate *)expiredDate
{
    RLMResults *results = [DBMessage objectsWithPredicate:
                           [NSPredicate predicateWithFormat:@"sendTime < %@", expiredDate]];
    [realm beginWriteTransaction];
    [realm deleteObjects:results];
    [realm commitWriteTransaction];
}


@end
