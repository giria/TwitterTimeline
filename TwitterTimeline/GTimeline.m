//
//  GTimeline.m
//  TwitterTimeline
//
//  Created by Joan Barrull Ribalta on 25/08/14.
//  Copyright (c) 2014 com.giria. All rights reserved.
//

#import "GTimeline.h"
#import "GTweet.h"
#import <Social/Social.h>

@interface GTimeline ()

@property (nonatomic, readwrite) BOOL loading;
@property (strong, nonatomic) ACAccount *account;

@end
@implementation GTimeline

- (id)initWithAccount:(ACAccount *)account
{
    self = [super init];
    if (self) {
        _account = account;
    }
    return self;
}
- (BOOL)loadNewTweetsWithCompletionHandler:(void (^)(NSError *error))completionHandler
{
    if (self.loading) {
        return NO;
    }
    
    SLRequest *request = [self requestForNewTweets];
    [self loadTweetsWithRequest:request completionHandler:completionHandler];
    
    return YES;
}

- (BOOL)loadOldTweetsWithCompletionHandler:(void (^)(NSError *error))completionHandler
{
    if (self.loading) {
        return NO;
    }
    
    SLRequest *request = [self requestForOldTweets];
    [self loadTweetsWithRequest:request completionHandler:completionHandler];
    
    return YES;
}
- (SLRequest *)requestForNewTweets
{
    return nil;
}

- (SLRequest *)requestForOldTweets
{
    return nil;
}
- (void)loadTweetsWithRequest:(SLRequest *)request completionHandler:(void (^)(NSError *error))completionHandler
{
    self.loading = YES;
    
    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        if (!error) {
            id response = [NSJSONSerialization JSONObjectWithData:responseData
                                                          options:0
                                                            error:NULL];
            
            if ([response isKindOfClass:[NSArray class]]) {
                [self.managedObjectContext performBlock:^{
                    [self importTweets:response];
                }];
            }
            else {
                NSLog(@"Error: %@", response[@"errors"][0][@"message"]);
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.loading = NO;
            completionHandler(error);
        });
    }];
}
view raw