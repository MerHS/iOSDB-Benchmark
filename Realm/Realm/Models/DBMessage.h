//
//  DBMessage.h
//  Realm
//
//  Created by JHY on 2015. 5. 20..
//  Copyright (c) 2015년 KINETC. All rights reserved.
//

#import <Realm/Realm.h>
#import "DBSender.h"

@interface DBMessage : RLMObject

@property NSInteger messageID;
@property NSString* msgData;
@property NSDate*   sendTime;
@property DBSender* senderID;
@property BOOL viewed;

-(id) initWithoutID;

+(DBMessage *) getRandomMessage;
+(DBMessage *) getRandomMessage:(DBSender *)senderID;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<DBMessage>
RLM_ARRAY_TYPE(DBMessage)
