//
//  DBManager.h
//  Realm
//
//  Created by JHY on 2015. 5. 20..
//  Copyright (c) 2015년 KINETC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "DBMessage.h"
#import "DBSender.h"

@interface DBManager : NSObject

-(void) initializeDB;
-(void) insertMessage:(DBMessage *)dbMessage; // 1
-(void) insertMessageWithTransaction:(int)repeatCount senderIdMax:(int)senderIdMax; // 2
-(void) insertSender:(DBSender *)dbSender;
-(void) insertSenderWithTransaction:(int)repeatCount; // 3
-(DBMessage *) selectMessage:(NSInteger)withID; // 4
-(DBSender *) selectSender:(NSString *)withName; // 5
-(void) updateMessageViewed:(NSInteger)senderID; // 6
-(NSMutableArray *) fetchBetweenDate:(NSDate *)startDate endDate:(NSDate *)endDate fetchMax:(NSInteger)fetchMax; // 7
-(int) unseenMessageCountWithID:(NSInteger)senderID; // 8
-(NSMutableArray *) fetchMessageWithName:(NSString *)senderName fetchCount:(NSInteger)fetchMax; // 9
-(void) deleteOldMessage:(NSInteger)expiredDate; // 10


@end
