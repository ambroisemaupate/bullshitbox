//
//  RZAppDelegate.h
//  BullshitBox
//
//  Created by Ambroise Maupate on 01/07/2014.
//  Copyright (c) 2014 REZO ZERO. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RZAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:(id)sender;

@end
