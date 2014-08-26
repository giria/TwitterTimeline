//
//  GManagedObject.h
//  TwitterTimeline
//
//  Created by Joan Barrull Ribalta on 25/08/14.
//  Copyright (c) 2014 com.giria. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface GManagedObject : NSManagedObject

+ (NSString *)entityName;
+ (NSFetchRequest *)fetchRequest;

+ (id)insertNewObjectInManagedObjectContext:(NSManagedObjectContext *)context;
+ (id)importFromDictionary:(NSDictionary *)dictionary inManagedObjectContext:(NSManagedObjectContext *)context;

- (void)importValuesFromDictionary:(NSDictionary *)dictionary;

@end
