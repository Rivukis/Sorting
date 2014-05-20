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

@property (strong, nonatomic) NSMutableArray *normalSort;
@property (strong, nonatomic) NSMutableArray *queueSort;

@end

@implementation RIVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableSet *setToSort = [NSMutableSet new];
    
    for (NSInteger i = 1; i <= 10000000; i++) {
        [setToSort addObject:@(i)];
    }
    
    self.normalSort = [[setToSort allObjects] mutableCopy];
    self.queueSort = [[setToSort allObjects] mutableCopy];
    
    
//    NSLog(@"start normal: %@", [self.normalSort description]);
    NSLog(@"start normal");
    [self.normalSort sortUsingQuickSort];
//    NSLog(@"end normal: %@", [self.normalSort description]);
    
    NSLog(@"end normal / start queue");
    
//    NSLog(@"start queue: %@", [self.queueSort description]);
    [self.queueSort sortUsingQueue];
//    NSLog(@"end queue: %@", [self.queueSort description]);
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
