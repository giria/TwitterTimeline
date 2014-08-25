//
//  GTimeline.h
//  TwitterTimeline
//
//  Created by Joan Barrull Ribalta on 25/08/14.
//  Copyright (c) 2014 com.giria. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>
#import <CoreData/CoreData.h>

@interface GTimeline : NSObject

@property (strong, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, readonly, getter = isLoading) BOOL loading;

- (id)initWithAccount:(ACAccount *)account;

- (BOOL)loadNewTweetsWithCompletionHandler:(void (^)(NSError *error))completionHandler;

- (BOOL)loadOldTweetsWithCompletionHandler:(void (^)(NSError *error))completionHandler;

@end