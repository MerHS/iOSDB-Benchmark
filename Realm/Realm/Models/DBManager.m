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

-(id) init
{
    if(self = [super init])
        [self initializeDB];
    
    return self;
}

-(void) initializeDB
{
    realm = [RLMRealm defaultRealm];
}


-(void) insertMessage:(DBMessage *)dbMessage
{
    /*
    [db executeUpdate:@"INSERT INTO DBMessage VALUES (?, ?, ?, ?, ?)"
     ,[NSNumber numberWithInteger:dbMessage.messageID]
     ,dbMessage.msgData
     ,dbMessage.sendTime
     ,[NSNumber numberWithInteger:dbMessage.senderID]
     ,[NSNumber numberWithBool:dbMessage.viewed]];
     */
}

-(void) insertMessageWithTransaction:(int)repeatCount senderIdMax:(int)senderIdMax
{
    BOOL success = YES;
    DBMessage *message;
    [realm beginWriteTransaction];
    
    for (int i = 0; i < repeatCount; i++) {
        message = [DBMessage getRandomMessage:(NSInteger)arc4random_uniform(senderIdMax)];
        [db executeUpdate:@"INSERT INTO DBMessage VALUES (?, ?, ?, ?, ?)"
         ,[NSNumber numberWithInteger:message.messageID]
         ,message.msgData
         ,message.sendTime
         ,[NSNumber numberWithInteger:message.senderID]
         ,[NSNumber numberWithBool:message.viewed]];
    }
    
    if (success) {
        [realm commitWriteTransaction];
    } else {
        [realm cancelWriteTransaction];
    }
}

-(void) insertSender:(DBSender *)dbSender
{
    [db executeUpdate:@"INSERT INTO DBSender VALUES (?, ?, ?)"
     ,[NSNumber numberWithInteger:dbSender.senderID]
     ,dbSender.senderImage
     ,dbSender.senderName];
    
}

-(void) insertSenderWithTransaction:(int)repeatCount
{
    BOOL success = YES;
    DBSender *sender;
    [db beginTransaction];
    
    for (int i = 0; i < repeatCount; i++) {
        sender = [DBSender getRandomSender];
        [db executeUpdate:@"INSERT INTO DBSender VALUES (?, ?, ?)"
         ,[NSNumber numberWithInteger:sender.senderID]
         ,sender.senderImage
         ,sender.senderName];
    }
    
    if (success) {
        [db commit];
    } else {
        [db rollback];
    }
}

-(DBMessage *) selectMessage:(NSInteger)withID
{
    FMResultSet *resultSet = [db executeQuery:@"SELECT * FROM DBMessage WHERE messageID = ?", [NSNumber numberWithInteger:withID]];
    DBMessage *message = [[DBMessage alloc] initWithoutID];
    if([resultSet next]){
        message.messageID = [resultSet intForColumnIndex:0];
        message.msgData = [resultSet stringForColumnIndex:1];
        message.sendTime = [resultSet dateForColumnIndex:2];
        message.senderID = [resultSet intForColumnIndex:3];
        message.viewed = [resultSet boolForColumnIndex:4];
    }
    return message;
}

-(DBSender *) selectSender:(NSString *)withName
{
    FMResultSet *resultSet = [db executeQuery:@"SELECT * FROM DBSender WHERE senderID = ?", withName];
    DBSender *sender = [[DBSender alloc] initWithoutID];
    if([resultSet next]){
        sender.senderID = [resultSet intForColumnIndex:0];
        sender.senderName = [resultSet stringForColumnIndex:1];
        sender.senderImage = [resultSet dataForColumnIndex:2];
    }
    return sender;
}

-(void) updateMessageViewed:(NSInteger)senderID
{
    [db executeUpdate:@"UPDATE DBMessage SET viewed = TRUE WHERE senderID = ?", [NSNumber numberWithInteger:senderID]];
}

-(NSMutableArray *) fetchBetweenDate:(NSDate *)startDate endDate:(NSDate *)endDate fetchMax:(NSInteger)fetchMax
{
    NSMutableArray *fetchData = [[NSMutableArray alloc] init];
    FMResultSet *resultSet = [db executeQuery:@"SELECT * FROM DBMessage WHERE sendTime >= ? AND sendTime <= ?", startDate, endDate];
    NSInteger i = 0;
    while ([resultSet next] && i < fetchMax) {
        DBMessage *message = [[DBMessage alloc] initWithoutID];
        message.messageID = [resultSet intForColumnIndex:0];
        message.msgData = [resultSet stringForColumnIndex:1];
        message.sendTime = [resultSet dateForColumnIndex:2];
        message.senderID = [resultSet intForColumnIndex:3];
        message.viewed = [resultSet boolForColumnIndex:4];
        i++;
    }
    return fetchData;
}

-(int) unseenMessageCountWithID:(NSInteger)senderID
{
    FMResultSet *resultSet = [db executeQuery:@"SELECT count(*) FROM DBMessage WHERE senderID = ? AND viewed = FALSE", [NSNumber numberWithInteger:senderID]];
    
    if([resultSet next]){
        return [resultSet intForColumnIndex:0];
    }
    
    return 0;
}

-(NSMutableArray *) fetchMessageWithName:(NSString *)senderName fetchCount:(NSInteger)fetchMax
{
    NSMutableArray *fetchData = [[NSMutableArray alloc] initWithCapacity:fetchMax];
    FMResultSet *resultSet = [db executeQuery:@"SELECT messageID, msgData, sendTime, senderID, viewed \
                              FROM DBMessage NATURAL JOIN DBSender WHERE senderName = ?", senderName];
    NSInteger i = 0;
    while ([resultSet next] && i < fetchMax) {
        DBMessage *message = [[DBMessage alloc] initWithoutID];
        message.messageID = [resultSet intForColumnIndex:0];
        message.msgData = [resultSet stringForColumnIndex:1];
        message.sendTime = [resultSet dateForColumnIndex:2];
        message.senderID = [resultSet intForColumnIndex:3];
        message.viewed = [resultSet boolForColumnIndex:4];
        i++;
    }
    return fetchData;
}

-(void) deleteOldMessage:(NSInteger)expiredDate
{
    [db executeUpdate:@"DELETE FROM DBMessage WHERE sendTime < ?", [NSNumber numberWithInteger:expiredDate]];
}


@end
