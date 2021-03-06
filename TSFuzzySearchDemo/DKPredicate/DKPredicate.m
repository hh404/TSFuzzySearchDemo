//
//  DKPredicate.m
//  DiscoKit
//
//  Created by Keith Pitt on 11/07/11.
//  Copyright 2011 Mostly Disco. All rights reserved.
//

#import "DKPredicate.h"

@implementation DKPredicate

@synthesize predicate, predicateType, info;

+ (DKPredicate *)withPredicate:(NSPredicate *)predicate predicateType:(DKPredicateType)predicateType info:(NSDictionary *)dictionary {
    
    return [[DKPredicate alloc] initWithPredicate:predicate
                                     predicateType:predicateType
                                              info:(NSDictionary *)dictionary];
    
}

- (id)initWithPredicate:(NSPredicate *)thePredicate predicateType:(DKPredicateType)thePredicateType info:(NSDictionary *)dictionary {
    
    if ((self = [super init])) {
        
        // Store and retain the predicate
        predicate = thePredicate;
        
        // Store and retain the info dictionary
        info = dictionary;
        
        // Store the predicate typ
        predicateType = thePredicateType;
        
    }
    
    return self;
    
}

- (NSString *)predicateFormat {
    
    return [self.predicate predicateFormat];
    
}

- (void)dealloc {
    

    
}

@end
