//
//  ViewController.m
//  TSFuzzySearchDemo
//
//  Created by huangjianwu on 2017/4/12.
//  Copyright © 2017年 huangjianwu. All rights reserved.
//

#import "ViewController.h"
#import "DKArrayQuery.h"
#import "NSArray+ArrayQuery.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self test1];
    [self test3];
}

- (void)test1
{
    NSArray * namesArray = [NSArray arrayWithObjects:
                            [NSDictionary dictionaryWithObjectsAndKeys:@"Kevin", @"first_name", nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"Keith", @"first_name", nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"Jordan", @"first_name", nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"Mario", @"first_name", nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"Dirk", @"first_name", nil],
                            nil];
    
    DKArrayQuery * arrayQuery = [DKArrayQuery queryWithArray:namesArray];
    
//    [arrayQuery where:@"first_name" startsWith:@"Ke"];
//    [arrayQuery orderBy:@"first_name" ascending:YES];
//    
//    [arrayQuery perform:^(NSArray * records) {
//        // Returns an array with this order;
//        //   [NSDictionary dictionaryWithObjectsAndKeys:@"Keith", @"first_name", nil]
//        //   [NSDictionary dictionaryWithObjectsAndKeys:@"Kevin", @"first_name", nil]
//    }];
    
    //[arrayQuery where:@"first_name" like:@"or"];
    NSArray *ar = [NSArray arrayWithObjects:@"o",@"r", nil];
    [arrayQuery where:@"first_name" isIn:ar];
    [arrayQuery perform:^(NSArray *records) {
        
    }];
}


- (void)test2
{
    NSMutableArray *namesArray = [NSMutableArray array];
    
    DKArrayQuery * arrayQuery = [[namesArray query] where:@"first_name" isNull:NO];
    // The block will be called on the main thread while the records
    // are calculated in a background thread.
    [arrayQuery perform:^(NSArray * records) {
        // ...
    } background:YES];
}

- (void)test3
{
    NSArray *array = @[@"Test String: Apple", @"Test String: Pineapple", @"Test String: Banana"];
    NSString *searchText = @"apple";
    NSMutableString *searchWithWildcards = [@"*" mutableCopy];
    [searchText enumerateSubstringsInRange:NSMakeRange(0, [searchText length])
                                   options:NSStringEnumerationByComposedCharacterSequences
                                usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                    [searchWithWildcards appendString:substring];
                                    [searchWithWildcards appendString:@"*"];
                                }];

//    if (searchWithWildcards.length > 3)
//        for (int i = 2; i < searchText.length * 2; i += 2)
//            [searchWithWildcards insertString:@"*" atIndex:i];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF LIKE[cd] %@", searchWithWildcards];
    NSArray *filteredArray = [array filteredArrayUsingPredicate:predicate];
    //封装的模糊匹配
    NSArray *ar1 = [ViewController filterFuzzySearchFromArray:array withWildcards:searchText];
    NSLog(@"filteredArray: %@", filteredArray);
}

//array里边是对象的话需要略作修改
+ (NSArray*)filterFuzzySearchFromArray:(NSArray*)sourceArray withWildcards:(NSString*)wildcards
{
    NSMutableString *searchWithWildcards = [@"*" mutableCopy];
    [wildcards enumerateSubstringsInRange:NSMakeRange(0, [wildcards length])
                                   options:NSStringEnumerationByComposedCharacterSequences
                                usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                    [searchWithWildcards appendString:substring];
                                    [searchWithWildcards appendString:@"*"];
                                }];
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF LIKE[cd] %@", searchWithWildcards];
    NSArray *filteredArray = [sourceArray filteredArrayUsingPredicate:predicate];
    return filteredArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
