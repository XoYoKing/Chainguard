//
//  NSLocale+RWSCurrency.h
//  Parts
//
//  Created by Samuel Goodwin on 23-11-13.
//  Copyright (c) 2013 Roundwall Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSLocale (RWSCurrency)

+ (NSLocale *)currentLocaleWithCurrency:(NSString *)currency;

@end