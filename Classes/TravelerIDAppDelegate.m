//
//  TravelerIDAppDelegate.m
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

#import "TravelerIDAppDelegate.h"
#import "TravelerIDViewController.h"
#import "TravelerIDSaveAsController.h"

@implementation TravelerIDAppDelegate

@synthesize window;
@synthesize viewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	
	//UIViewController *rootViewController =
	//[[[TravelerIDSaveAsController alloc] init] autorelease];
	//viewController1 =
	//[[UINavigationController alloc]
	// initWithRootViewController:rootViewController];
	
    // Add the view controller's view to the window and display.
	
	//viewController.TravelerIDList = [[TravelerIDListTableViewController alloc] init];
	//viewController.TravelerIDList.managedObjectContext = self.managedObjectContext;
    [window addSubview:viewController.view];
#if 1
	//BOOL toggleSplashScreenTimer= [[NSUserDefaults standardUserDefaults] boolForKey:@"toggleSS_key"];
	
	//if (toggleSplashScreenTimer) { 
	if(1) {
		// create the view that will execute our animation
		UIImageView *ssView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 480)];
		
		// load all the frames of our animation
		ssView.animationImages = [NSArray arrayWithObjects: 
								  [UIImage imageNamed:@"ss1-2.png"],
								  [UIImage imageNamed:@"ss2-1.png"],
								  [UIImage imageNamed:@"ss1-3.png"],
								  [UIImage imageNamed:@"ss1-4.png"],
								   [UIImage imageNamed:@"ss2-2.png"],
								  [UIImage imageNamed:@"ss1-5.png"],
								   [UIImage imageNamed:@"ss1-6.png"],
								   [UIImage imageNamed:@"ss2-3.png"],
								   [UIImage imageNamed:@"ss1-7.png"],
								   [UIImage imageNamed:@"ss1-8.png"],
								   [UIImage imageNamed:@"ss2-4.png"],
								  // [UIImage imageNamed:@"ss1-9.png"],
								  // [UIImage imageNamed:@"ss1-10.png"],
								 //  [UIImage imageNamed:@"ss1-11.png"],
								 //  [UIImage imageNamed:@"ss1-12.png"],
								  nil];
		
		ssView.animationDuration = 10.0;
		
		// repeat the annimation once
		ssView.animationRepeatCount = 1;
		[ssView startAnimating];
		
		// add the animation view to the main window 
		//[self.view addSubview:ssView];
		[window insertSubview:ssView aboveSubview:viewController.view];
		//[window addSubview:ssView];
		[ssView release]; 
	}
#endif
	viewController.TravelerIDList = [[TravelerIDListTableViewController alloc] init];
	viewController.TravelerIDList.managedObjectContext = self.managedObjectContext;
	// [window addSubview:viewController.view];
	[window setNeedsLayout];
    [window makeKeyAndVisible];
	
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
	
#if 0
	BOOL toggleSplashScreenTimer= [[NSUserDefaults standardUserDefaults] boolForKey:@"toggleSS_key"];
	
	//if (toggleSplashScreenTimer) { 
	if(1) {
		// create the view that will execute our animation
		UIImageView *ssView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 460)];
		
		// load all the frames of our animation
		ssView.animationImages = [NSArray arrayWithObjects: 
								  [UIImage imageNamed:@"Default1.png"],
								  [UIImage imageNamed:@"Default2.png"],
								  [UIImage imageNamed:@"Default3.png"],
								  [UIImage imageNamed:@"Default4.png"],
								  [UIImage imageNamed:@"Default5.png"],
								  nil];
		
		ssView.animationDuration = 5.0;
		
		// repeat the annimation once
		ssView.animationRepeatCount = 1;
		[ssView startAnimating];
		
		// add the animation view to the main window 
		[window addSubview:viewController.view];
		//[window insertSubview:ssView aboveSubview:viewController.view];
		[ssView release]; 
	}
#endif
	
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
	NSError *error;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
        } 
    }
	
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [NSManagedObjectContext new];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
	// managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];   
	NSString *path = [[NSBundle mainBundle] pathForResource:@"TravelerID" ofType:@"momd"];
    NSURL *momURL = [NSURL fileURLWithPath:path];
    managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:momURL];
	
    return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
	NSString *storePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"test.sqlite"];
	/*
	 Set up the store.
	 For the sake of illustration, provide a pre-populated default store.
	 */
	NSFileManager *fileManager = [NSFileManager defaultManager];
	// If the expected store doesn't exist, copy the default store.
	if (![fileManager fileExistsAtPath:storePath]) {
		NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"sqlite"];
		if (defaultStorePath) {
			[fileManager copyItemAtPath:defaultStorePath toPath:storePath error:NULL];
		}
	}
	
	NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
	
	NSError *error;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }    
	
    return persistentStoreCoordinator;
}


#pragma mark -
#pragma mark Application's documents directory

/**
 Returns the path to the application's documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [managedObjectContext release];
    [managedObjectModel release];
    [persistentStoreCoordinator release];
    
    [viewController release];
    
    [window release];
    [super dealloc];
}

@end
#if 0
@implementation UINavigationBar (UINavigationBarCategory)

- (void)drawRect:(CGRect)rect {
	//UIColor *color = [UIColor clearColor];
	//UIImage *img = [UIImage imageNamed:@"toolbar-gradient-reverse.png"];
	//[img drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	//self.tintColor = color;
	//UIImage *img = [UIImage imageNamed: @"oolbar-gradient-reverse.png"];
	//CGContextRef context = UIGraphicsGetCurrentContext();
	//CGContextDrawImage(context, CGRectMake(0, 0, 320, self.frame.size.height), img.CGImage);
	
	
}

@end
#endif