//
//  NSMutableArray+Sorting.m
//  Sorting
//
//  Created by Brian Radebaugh on 5/20/14.
//  Copyright (c) 2014 Brian Radebaugh. All rights reserved.
//

#import "NSMutableArray+Sorting.h"

@implementation NSMutableArray (Sorting)

- (void)sortUsingQuickSort
{
    
    [self sortUsingQuickSortWithLow:0 andHigh:self.count - 1];
    
    
}

- (void)sortUsingQueue
{
    NSOperationQueue *sortQueue = [NSOperationQueue new];
    [self quickSortWithLow:0 andHigh:self.count - 1 UsingOperationQueue:sortQueue];
    while (sortQueue.operationCount) {
        NSLog(@"Not Done");
//        usleep(500);
    }
    NSLog(@"Done");
}

- (void)sortUsingQuickSortWithLow:(NSInteger)low andHigh:(NSInteger)high
{
    if (low < high)
    {
        NSInteger pivotLocation = [self partitionArray:self withLow:low andHigh:high];
        [self sortUsingQuickSortWithLow:low andHigh:pivotLocation - 1];
        [self sortUsingQuickSortWithLow:pivotLocation + 1 andHigh:high];
    }
}

- (void)quickSortWithLow:(NSInteger)low andHigh:(NSInteger)high UsingOperationQueue:(NSOperationQueue *)queue
{
    if (low < high)
    {
        __block NSInteger pivotLocation;
        NSOperation *pivotOperation = [NSBlockOperation blockOperationWithBlock:^{
            pivotLocation = [self partitionArray:self withLow:low andHigh:high];
        }];
        [pivotOperation setCompletionBlock:^{
            [self sortUsingQuickSortWithLow:low andHigh:pivotLocation - 1];
            [self sortUsingQuickSortWithLow:pivotLocation + 1 andHigh:high];
            NSLog(@"block done");
//            NSLog(@"block done: %@", [self description]);
        }];
        
        [queue addOperation:pivotOperation];
    }
}

-(NSInteger)partitionArray:(NSMutableArray *)array withLow:(NSInteger)low andHigh:(NSInteger)high
{
    NSInteger pivotValue = [self[low] integerValue];
    NSInteger leftWall = low;
    
    for (NSInteger i = low; i <= high; i++) {
        if ([self[i] integerValue] < pivotValue) {
            leftWall++;
            [self exchangeObjectAtIndex:i withObjectAtIndex:leftWall];
        }
    }
    [array exchangeObjectAtIndex:low withObjectAtIndex:leftWall];
    
    return leftWall;
    
//    int pivotValue = [array[low] intValue];
//    int leftWall = low;
//    
//    for (int i = low; i <= high;i++) //this for loop gets every value less than the pivot value to the left of our leftwall
//    {
//        if ([array[i] intValue] < pivotValue)
//        {
//            leftWall++; //counting how many values are less than our pivotValue
//            
//            [array exchangeObjectAtIndex:i withObjectAtIndex:leftWall]; //Switches out the value at i for the value at leftWall, this way when we do the final exchange after this for loop, leftwall is the pivot (since it switched with low) and low is the final smaller value that was exchanged in the for loop
//        }
//    }
//    
//    [array exchangeObjectAtIndex:low withObjectAtIndex:leftWall];
//    
//    NSLog(@"%d",leftWall);
//    
//    return leftWall;
}

@end
