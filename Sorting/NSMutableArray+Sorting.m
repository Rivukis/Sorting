//
//  NSMutableArray+Sorting.m
//  Sorting
//
//  Created by Brian Radebaugh on 5/20/14.
//  Copyright (c) 2014 Brian Radebaugh. All rights reserved.
//

#import "NSMutableArray+Sorting.h"

@implementation NSMutableArray (Sorting)

#pragma mark - Quick Sort

- (void)sortUsingQuickSort
{
    [self sortUsingQuickSortWithLow:0 andHigh:self.count - 1];
}

- (void)sortUsingQuickSortWithLow:(NSInteger)low andHigh:(NSInteger)high
{
    if (low < high) {
        NSInteger pivotLocation = [self partitionArray:self withLow:low andHigh:high];
        [self sortUsingQuickSortWithLow:low andHigh:pivotLocation - 1];
        [self sortUsingQuickSortWithLow:pivotLocation + 1 andHigh:high];
    }
}

- (NSInteger)partitionArray:(NSMutableArray *)array withLow:(NSInteger)low andHigh:(NSInteger)high
{
    NSInteger pivotValue = [self[low] integerValue];
    NSInteger leftWall = low;
    
    for (NSInteger i = low; i <= high; i++) {
        if ([self[i] integerValue] < pivotValue) {
            [self exchangeObjectAtIndex:i withObjectAtIndex:++leftWall];
        }
    }
    [array exchangeObjectAtIndex:low withObjectAtIndex:leftWall];
    
    return leftWall;
}


#pragma mark - In Place Merge Sort

- (void)sortUsingMergeSort
{
    [self sortUsingMergeSortWithLow:0 andHigh:self.count - 1];
}

- (void)sortUsingMergeSortWithLow:(NSInteger)low andHigh:(NSInteger)high
{
    if (high - low > 0) {
        NSInteger middle = floorf((high - low) / 2.0) + low;
        [self sortUsingMergeSortWithLow:low andHigh:middle];
        [self sortUsingMergeSortWithLow:middle + 1 andHigh:high];
        [self mergeWithLeftLowIndex:low lowHigh:middle rightLow:middle + 1 andRightHigh:high]; // middle-1 then middle
    }
}


- (void)mergeWithLeftLowIndex:(NSInteger)leftLow lowHigh:(NSInteger)leftHigh rightLow:(NSInteger)rightLow andRightHigh:(NSInteger)rightHigh
{
    while (leftLow != rightLow && rightLow <= rightHigh) {
        if ([self[leftLow] integerValue] < [self[rightLow] integerValue]) {
            leftLow++;
        } else {
            id obj = self[rightLow];
            [self removeObjectAtIndex:rightLow++];
            [self insertObject:obj atIndex:leftLow++];
            leftHigh++;
        }
    }
//    NSLog(@"current state: %@", self.description);
}

#pragma mark - ***NOT*** In Place Merge Sort

- (NSArray *)sortUsingMergeSortWithArray:(NSArray *)unsortedArray
{
    if (unsortedArray.count < 2) return unsortedArray;
    
    NSInteger middle = unsortedArray.count/2;
    NSArray *leftArray = [unsortedArray subarrayWithRange:NSMakeRange(0, middle)];
    NSArray *rightArray = [unsortedArray subarrayWithRange:NSMakeRange(middle, unsortedArray.count - middle)];
    return [self arrayByMergingArray:[self sortUsingMergeSortWithArray:leftArray]
                           withArray:[self sortUsingMergeSortWithArray:rightArray]];
}

-(NSArray *)arrayByMergingArray:(NSArray *)leftArray withArray:(NSArray *)rightArray
{
    NSMutableArray *collector = [NSMutableArray new];
    NSInteger leftTracker = 0;
    NSInteger rightTracker = 0;
    
    // Fill Collector Array until One Array Has Added Every Index
    while (leftTracker < leftArray.count && rightTracker < rightArray.count) {
        if ([leftArray[leftTracker] integerValue] < [rightArray[rightTracker] integerValue]) {
            [collector addObject:leftArray[leftTracker++]];
        } else {
            [collector addObject:rightArray[rightTracker++]];
        }
    }
    
    // Return NSArray of collector And the Items Not Yet Added to collector
    NSRange range;
    NSArray *sortedArray;
    
    if (leftTracker < leftArray.count) {
        range = NSMakeRange(leftTracker, leftArray.count - leftTracker);
        sortedArray = [collector arrayByAddingObjectsFromArray:[leftArray subarrayWithRange:range]];
    } else {
        range = NSMakeRange(rightTracker, ([rightArray count] - rightTracker));
        sortedArray = [collector arrayByAddingObjectsFromArray:[rightArray subarrayWithRange:range]];
    }
    
    return sortedArray;
}

@end
