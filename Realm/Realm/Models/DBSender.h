//
//  DBSender.h
//  Realm
//
//  Created by JHY on 2015. 5. 20..
//  Copyright (c) 2015년 KINETC. All rights reserved.
//

#import <Realm/Realm.h>
#import "DBMessage.h"

@interface DBSender : RLMObject

@property NSInteger senderID;
@property NSData*   senderImage;
@property NSString* senderName;
@property RLMArray<DBMessage> *messages;

-(id) initWithoutID;

+(DBSender *) getDefaultSender;
+(DBSender *) getRandomSender;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<DBSender>
RLM_ARRAY_TYPE(DBSender)
