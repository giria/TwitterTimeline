//
//  GUser.h
//  TwitterTimeline
//
//  Created by Joan Barrull Ribalta on 25/08/14.
//  Copyright (c) 2014 com.giria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GTweet;

@interface GUser : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * stringName;
@property (nonatomic, retain) NSString * imageLink;
@property (nonatomic, retain) NSSet *tweets;
@property (nonatomic, retain) NSSet *retweets;
@end

@interface GUser (CoreDataGeneratedAccessors)

- (void)addTweetsObject:(GTweet *)value;
- (void)removeTweetsObject:(GTweet *)value;
- (void)addTweets:(NSSet *)values;
- (void)removeTweets:(NSSet *)values;

- (void)addRetweetsObject:(GTweet *)value;
- (void)removeRetweetsObject:(GTweet *)value;
- (void)addRetweets:(NSSet *)values;
- (void)removeRetweets:(NSSet *)values;

@end
