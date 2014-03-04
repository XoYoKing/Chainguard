#import "_RWSManagedItem.h"
#import "RWSProject.h"
@import MapKit;

@interface RWSManagedItem : _RWSManagedItem<RWSItem, MKAnnotation> {}
- (NSString *)lineItemString;
- (NSDecimalNumber *)priceInCurrency:(NSString *)currencyCode;
@end
