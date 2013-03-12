//
//  TravelerIDInAppPurchaseController.h
//  TravelerID
//
//  Created by Ashish Lal on 04/10/10.
//  Copyright 2010 NetTech India. All rights reserved.
// Thanks to http://nixsolutions.com/blog/development/iphone/in-app-purchase-tutorial/

#import <Foundation/Foundation.h>

#import <StoreKit/StoreKit.h>

@class inAppPurchaseController;

@protocol inAppPurchaseControllerDelegate

- (void) purchaseController: (inAppPurchaseController *) controller didLoadInfo: (SKProduct *) products;
- (void) purchaseController: (inAppPurchaseController *) controller didFailLoadProductInfo: (NSError *) error;
- (void) purchaseController: (inAppPurchaseController *) controller didFinishPaymentTransaction: (SKPaymentTransaction *) transaction;
- (void) purchaseController: (inAppPurchaseController *) controller didFailPaymentTransactionWithError: (NSError *) error;

@end

@interface inAppPurchaseController : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver>
{
	NSString   *strPurchaseId_;
	id <inAppPurchaseControllerDelegate>   delegate_;
}

@property(assign) id <inAppPurchaseControllerDelegate> delegate_;
@property(copy) 	NSString    *strPurchaseId_;

- (void)    loadProductsInfo;
- (void)    makePurchase: (SKProduct *) product;
- (BOOL) isPresentNonFinishedTransaction;

@end