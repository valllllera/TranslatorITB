//
//  DataManager.m
//  TranslatorItbFirst
//
//  Created by Alexandr Kolesnik on 07.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

static DataManager * sharedMySingleton = NULL;


+(DataManager *)sharedData {
    if (!sharedMySingleton || sharedMySingleton == NULL) {
        
		sharedMySingleton = [DataManager new];
        sharedMySingleton.languages = [[self languages] allKeys];
        
	}
	return sharedMySingleton;
}

+(NSDictionary*)languages
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"595", NSLocalizedString(@"Eng", nil),
                           @"595", NSLocalizedString(@"Ger", nil),
                           @"595", NSLocalizedString(@"Fra", nil),
                           @"1190",NSLocalizedString(@"Aze", nil),
                           @"1530",NSLocalizedString(@"Ara", nil),
                           @"850", NSLocalizedString(@"Arm", nil),
                           @"595", NSLocalizedString(@"Bel", nil),
                           @"884", NSLocalizedString(@"Bul", nil),
                           @"884", NSLocalizedString(@"Hun", nil),
                           @"1394",NSLocalizedString(@"Vie", nil),
                           @"1360",NSLocalizedString(@"Nld", nil),
                           @"1530",NSLocalizedString(@"Gre", nil),
                           @"1190",NSLocalizedString(@"Gru", nil),
                           @"1666",NSLocalizedString(@"Dri", nil),
                           @"1326",NSLocalizedString(@"Dan", nil),
                           @"690", NSLocalizedString(@"Heb", nil),
                           @"1020",NSLocalizedString(@"Esl", nil),
                           @"1020",NSLocalizedString(@"Ita", nil),
                           @"986", NSLocalizedString(@"Kaz", nil),
                           @"1190",NSLocalizedString(@"Kir", nil),
                           @"1530",NSLocalizedString(@"Chi", nil),
                           @"0",   NSLocalizedString(@"Rus", nil),
                           @"1326",NSLocalizedString(@"Lat", nil),
                           @"1360",NSLocalizedString(@"Lav", nil),
                           @"1360",NSLocalizedString(@"Lit", nil),
                           @"986", NSLocalizedString(@"Mac", nil),
                           @"646", NSLocalizedString(@"Mol", nil),
                           @"1190",NSLocalizedString(@"Mon", nil),
                           @"1360",NSLocalizedString(@"Nor", nil), 
                           @"850", NSLocalizedString(@"Pol", nil),
                           @"1530",NSLocalizedString(@"Por", nil),
                           @"1666",NSLocalizedString(@"Pus", nil),
                           @"986", NSLocalizedString(@"Rom", nil),
                           @"986", NSLocalizedString(@"Scc", nil),
                           @"1190",NSLocalizedString(@"Slk", nil),
                           @"986", NSLocalizedString(@"Slv", nil),
                           @"1326",NSLocalizedString(@"Tur", nil),
                           @"986", NSLocalizedString(@"Tuk", nil),
                           @"986", NSLocalizedString(@"Uzb", nil),
                           @"629", NSLocalizedString(@"Ukr", nil),
                           @"1666",NSLocalizedString(@"Urd", nil), 
                           @"1666",NSLocalizedString(@"Far", nil),
                           @"1190",NSLocalizedString(@"Fin", nil),
                           @"1666",NSLocalizedString(@"Hin", nil),
                           @"986", NSLocalizedString(@"Hor", nil),
                           @"986", NSLocalizedString(@"Chz", nil),
                           @"1326",NSLocalizedString(@"Shv", nil),
                           @"986", NSLocalizedString(@"Est", nil),
                           @"1530",NSLocalizedString(@"Jpn", nil),nil];
    return dict;
}

+(NSArray*)sortedLanguagesWithString:(NSString*)string
{
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray: [[self languages] allKeys]];
    
    for (int i =0; i<[[self languages] allKeys].count; i++) {
        if (((NSString*)[[self languages] allKeys][i]).length>=string.length && (![string isEqualToString:@""])) {
            if([string caseInsensitiveCompare:[[NSString stringWithFormat:@"%@",[[self languages] allKeys][i]] substringToIndex:string.length]] != NSOrderedSame){
                [array removeObject:[[self languages] allKeys][i]];
            }
        }else{
            [array removeObject:[[self languages] allKeys][i]];
        }
    }
    return array;
}

+(NSArray*)getLanguages{
    return [[NSMutableArray alloc]initWithArray: [[self languages] allKeys]];
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TryingOfCoreData" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TranslatorlbFirst.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectContext*) getObjectContext {
    NSManagedObjectContext *context = [self managedObjectContext];
    return context;
}

@end
