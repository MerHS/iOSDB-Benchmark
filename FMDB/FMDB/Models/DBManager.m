//
//  DBManager.m
//  FMDB
//
//  Created by JHY on 2015. 5. 20..
//  Copyright (c) 2015년 KINETC. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

FMDatabase* db;

-(id) init
{
    
   if(self = [super init])
       [self initializeDB];
    
    return self;
}

-(void) initializeDB
{
    db = [FMDatabase databaseWithPath:[[NSBundle mainBundle]
                                       pathForResource:@"messenger" ofType:@"db"]];
}

-(void) openDB
{
    [db open];
}

-(void) closeDB
{
    [db close];
}

-(void) insertMessage:(DBMessage *)dbMessage
{
    [db executeUpdate:@"INSERT INTO DBMessage VALUES (?, ?, ?, ?, ?)"
                      ,[NSNumber numberWithInteger:dbMessage.messageID]
                      ,dbMessage.msgData
                      ,dbMessage.sendTime
                      ,[NSNumber numberWithInteger:dbMessage.senderID]
                      ,[NSNumber numberWithBool:dbMessage.viewed]];
}

-(void) insertMessageWithTransaction:(int)repeatCount
{
    
}

-(void) insertSender:(DBSender *)dbSender
{
    
}

-(void) insertSenderWithTransaction:(int)repeatCount
{
    
}

-(DBMessage *) selectMessage:(NSInteger)withID
{
    FMResultSet *resultSet = [db executeQuery:@"SELECT * FROM DBMessage WHERE messageID = ?", [NSNumber numberWithInteger:withID]];
    DBMessage *message = [[DBMessage alloc] initWithoutID];
    
    return message;
}

-(DBSender *) selectSender:(NSString *)withName
{
    DBSender *sender = [[DBSender alloc] initWithoutID];
    return sender;
}

-(void) updateMessageViewed:(NSInteger)senderID
{
    
}

-(NSMutableArray *) fetchBetweenDate:(NSDate *)startDate endDate:(NSDate *)endDate
{
    NSMutableArray *fetchData = [[NSMutableArray alloc] initWithCapacity:10000];
    return fetchData;
}

-(int) unseenMessageCountWithID:(NSInteger)senderID
{
    return (int)senderID;
}

-(NSMutableArray *) fetchMessageWithName:(NSString *)senderName
{
    NSMutableArray *fetchData = [[NSMutableArray alloc] initWithCapacity:10000];
    return fetchData;
}

-(void) deleteOldMessage:(NSInteger)expiredDate
{
    
}
@end
