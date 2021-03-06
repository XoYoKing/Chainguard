//
//  RWSDumbItem.h
//  Manifest
//
//  Created by Samuel Goodwin on 03-02-14.
//
//

#import "RWSProject.h"

@interface RWSDumbItem : NSObject<RWSItem>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSDecimalNumber *price;
@property (nonatomic, copy) NSString *currencyCode;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *addressString;
@property (nonatomic, copy) NSString *notes;
@property (nonatomic, assign, getter = isPurchased) BOOL purchased;
@end
