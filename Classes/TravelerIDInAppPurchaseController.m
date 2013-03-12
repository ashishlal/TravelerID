//
//  TravelerIDInAppPurchaseController.m
//  TravelerID
//
//  Created by Ashish Lal on 04/10/10.
//  Copyright 2010 NetTech India. All rights reserved.
//
// Thanks to http://nixsolutions.com/blog/development/iphone/in-app-purchase-tutorial/

#import "TravelerIDInAppPurchaseController.h"

@implementation inAppPurchaseController

@synthesize strPurchaseId_;
@synthesize delegate_;

- (id) init

{
	if(self = [super init])
		
	{
		[ [SKPaymentQueue defaultQueue] addTransactionObserver: self];
	}	
	return self;
}

- (void) loadProductsInfo

{
	SKProductsRequest *request = [ [SKProductsRequest alloc] initWithProductIdentifiers: [NSSet setWithObject: strPurchaseId_]];
	[request setDelegate: self];
	[request start];
}

- (void) makePurchase: (SKProduct *) product

{
	
	if(![SKPaymentQueue canMakePayments])
	{
		[delegate_ purchaseController: self didFailPaymentTransactionWithError: [NSError errorWithDomain: @"payMentDomain" code: 123 userInfo: 
																				 [NSDictionary dictionaryWithObject: @"can not make paiments" forKey: NSLocalizedDescriptionKey]]];
	}
	
	SKPayment *payment = [SKPayment paymentWithProduct: product];
	[ [SKPaymentQueue defaultQueue] addPayment: payment];
	
}

- (BOOL) isPresentNonFinishedTransaction

{
	
	NSArray *arrTransactions = [ [SKPaymentQueue defaultQueue] transactions];
	for(SKPaymentTransaction *transaction in arrTransactions)
	{
		if([transaction.payment.productIdentifier isEqualToString: strPurchaseId_])
		{
			if(transaction.transactionState == SKPaymentTransactionStatePurchasing)
			{
				return YES;
			}
			else if(transaction.transactionState == SKPaymentTransactionStateFailed)
			{
				[ [SKPaymentQueue defaultQueue] finishTransaction: transaction];
			}
		}
	}
	return NO;
	
}

#pragma mark ---------------request delegate-----------------

- (void)requestDidFinish:(SKRequest *)request

{
	
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error

{
	[delegate_ purchaseController: self didFailLoadProductInfo: error];
}
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response

{
	
	NSArray *invalidIdentifiers = [response invalidProductIdentifiers];
	
	NSArray *products = [response products];
	
	for(SKProduct *product in products)
		
	{
		
		NSString *strId = product.productIdentifier;
		
		if([strId isEqualToString: strPurchaseId_])
			
		{
			
			[delegate_ purchaseController: self didLoadInfo: product];
			
			return;
			
		}
		
	}
	
	if([invalidIdentifiers count])
		
	{
		
		[delegate_ purchaseController: self didFailLoadProductInfo: [NSError errorWithDomain: @"purchaseDomain" code: 143 userInfo: [NSDictionary dictionaryWithObject: @"No Products found" forKey: NSLocalizedDescriptionKey]]];
		
	}
	
}

#pragma mark -------------------transaction observer-------------------
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions

{
	
	for(SKPaymentTransaction *transaction in transactions)
		
	{
		
		SKPayment *payment = [transaction payment];
		
		if([payment.productIdentifier isEqualToString: strPurchaseId_])
			
		{
			
			if(transaction.transactionState == SKPaymentTransactionStatePurchased)
				
			{
				
				[delegate_ purchaseController: self didFinishPaymentTransaction: transaction];
				
				[queue finishTransaction: transaction];
				
			}
			
			else if(transaction.transactionState == SKPaymentTransactionStateFailed)
				
			{
				
				[delegate_ purchaseController: self didFailPaymentTransactionWithError: [NSError errorWithDomain: @"purchaseDomain" code: 1542 userInfo: nil]];
				
				[queue finishTransaction: transaction];
				
			}
			
		}
		
	}
	
}

- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray *)transactions

{
	
}

- (void) dealloc

{
	
	[ [SKPaymentQueue defaultQueue] removeTransactionObserver: self];
	
	[super dealloc];
	
}

@end
