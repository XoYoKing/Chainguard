// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RWSManagedProject.h instead.

#import <CoreData/CoreData.h>


extern const struct RWSManagedProjectAttributes {
	__unsafe_unretained NSString *preferredCurrencyCode;
	__unsafe_unretained NSString *title;
} RWSManagedProjectAttributes;

extern const struct RWSManagedProjectRelationships {
	__unsafe_unretained NSString *items;
} RWSManagedProjectRelationships;

extern const struct RWSManagedProjectFetchedProperties {
} RWSManagedProjectFetchedProperties;

@class RWSManagedItem;




@interface RWSManagedProjectID : NSManagedObjectID {}
@end

@interface _RWSManagedProject : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RWSManagedProjectID*)objectID;





@property (nonatomic, strong) NSString* preferredCurrencyCode;



//- (BOOL)validatePreferredCurrencyCode:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSOrderedSet *items;

- (NSMutableOrderedSet*)itemsSet;





#if TARGET_OS_IPHONE


- (NSFetchedResultsController*)newItemsFetchedResultsControllerWithSortDescriptors:(NSArray*)sortDescriptors;


#endif

@end

@interface _RWSManagedProject (CoreDataGeneratedAccessors)

- (void)addItems:(NSOrderedSet*)value_;
- (void)removeItems:(NSOrderedSet*)value_;
- (void)addItemsObject:(RWSManagedItem*)value_;
- (void)removeItemsObject:(RWSManagedItem*)value_;

@end

@interface _RWSManagedProject (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitivePreferredCurrencyCode;
- (void)setPrimitivePreferredCurrencyCode:(NSString*)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;





- (NSMutableOrderedSet*)primitiveItems;
- (void)setPrimitiveItems:(NSMutableOrderedSet*)value;


@end
