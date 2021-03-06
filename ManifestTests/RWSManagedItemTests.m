//
//  RWSManagedItemTests.m
//  Manifest
//
//  Created by Samuel Goodwin on 22-02-14.
//
//

@import CoreData;
#import <XCTest/XCTest.h>
#import "RWSCoreDataController.h"
#import "RWSManagedItem.h"

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

@interface RWSManagedItemTests : XCTestCase{
    NSManagedObjectContext *testContext;
    NSPersistentStoreCoordinator *storeCoordinator;
    RWSCoreDataController *coreDataController;
    RWSManagedItem *item;
}
@end

@implementation RWSManagedItemTests

- (void)setUp
{
    [super setUp];

    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    NSPersistentStore *store = [storeCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:nil];
    assertThat(store, isNot(nilValue()));

    testContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [testContext setPersistentStoreCoordinator:storeCoordinator];

    item = [RWSManagedItem insertInManagedObjectContext:testContext];
    item.name = @"Sup";
    assertThatBool([testContext save:nil], isTrue());
}

- (void)testAddingAPhoto
{
    NSUInteger count = [item photoCount];

    UIImage *image = [self pokemonImage];

    [item addPhotoWithImage:image];

    assertThatInteger([item photoCount], equalToInteger(count+1));
    id<RWSPhoto> photo = [item photoAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    assertThat(photo, notNilValue());
    assertThat([photo fullImage], notNilValue());
    assertThat([photo thumbnailImage], notNilValue());
}

- (UIImage *)pokemonImage
{
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"Pokemon" ofType:@"jpg"];
    return [UIImage imageWithContentsOfFile:path];
}

- (void)testPriceInCurrencyUSDtoEUR
{
    item.price = [NSDecimalNumber decimalNumberWithString:@"1"];
    item.currencyCode = @"USD";

    assertThat([item priceInCurrency:@"EUR"], closeTo([[NSDecimalNumber decimalNumberWithString:@"0.89"] doubleValue], 0.2));
}

- (void)testPriceInCurrencyGBPtoEUR
{
    item.price = [NSDecimalNumber decimalNumberWithString:@"2"];
    item.currencyCode = @"GBP";

    assertThatDouble([[item priceInCurrency:@"EUR"] doubleValue], closeTo([[NSDecimalNumber decimalNumberWithString:@"2.69"] doubleValue], 0.2));
}

- (void)testValidLineItemStringWithoutCurrency
{
    XCTAssertNoThrow(item.lineItemString, @"Generating a line item string should be ok without a price");
}

- (void)testValidLineItemString
{
    assertThat(item.lineItemString, is(equalTo(@"Sup")));
}

- (void)testValidLineItemStringWithCurrency
{
    item.price = [NSDecimalNumber decimalNumberWithString:@"2"];
    item.currencyCode = @"USD";
    
    assertThat(item.lineItemString, is(equalTo(@"Sup: $2.00")));
}

- (void)testSearchingForProjectNamesWorks
{
    NSArray *results = [RWSManagedItem search:@"Sup" inContext:testContext];
    
    assertThatInteger([results count], is(equalToInteger(1)));
    assertThat(results.firstObject, is(item));
}

@end
