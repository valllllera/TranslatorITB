//
//  DataManager.h
//  TranslatorItbFirst
//
//  Created by Alexandr Kolesnik on 07.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderDataBase.h"

@interface DataManager : NSObject

+(DataManager *)sharedData;
+(NSDictionary*)languages;
+(NSArray*)sortedLanguagesWithString:(NSString*)string;
+(NSArray*)getLanguages;
+(int) getEtc;
@property (strong,nonatomic) NSArray *languages;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic,strong) NSManagedObjectContext *context;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (void) deleteAllObjects: (NSString *) entityDescription;
@end

