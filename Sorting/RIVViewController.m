//
//  RIVViewController.m
//  Sorting
//
//  Created by Brian Radebaugh on 5/20/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "RIVViewController.h"
#import "NSMutableArray+Sorting.h"

@interface RIVViewController ()

@property (strong, nonatomic) NSMutableArray *unsortedArray;

@end

@implementation RIVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableSet *mutableSet = [NSMutableSet new];
    for (NSInteger i = 1; i <= 100000; i++) [mutableSet addObject:@(i)];
    self.unsortedArray = [[mutableSet allObjects] mutableCopy];
    
//    self.unsortedArray = [@[@12, @13, @11, @7, @6, @2, @1, @14, @15, @10, @9, @8, @5, @4, @3, @16] mutableCopy];
    
//    NSLog(@"before sort: %@", self.unsortedArray.description);
    NSLog(@"start");
    
    [self.unsortedArray sortUsingMergeSort];
    
    NSLog(@"done");
//    NSLog(@"after sort: %@", self.unsortedArray.description);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
