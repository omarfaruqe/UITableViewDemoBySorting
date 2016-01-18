//
//  ViewController.m
//  UITableViewDemo
//
//  Created by Omar Faruqe on 2016-01-17.
//  Copyright © 2016 Omar Faruqe. All rights reserved.
//

#import "ViewController.h"
#include "MyCellTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *ourStrings;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.ourStrings = [NSMutableArray arrayWithArray:@[@"The first row!", @"More data"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ourStrings.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OurCell" forIndexPath:indexPath];
    cell.ourCellLabel.text = self.ourStrings[indexPath.row];
    
    return cell;
}

- (IBAction)addText:(id)sender {
    
    [self.tableView beginUpdates];
    [self.ourStrings addObject:self.textField.text];
    self.textField.text = @"";
    NSInteger newRow = [self.ourStrings count] - 1;
    NSIndexPath *newIndex = [NSIndexPath indexPathForRow:newRow inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[newIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
//    [self.tableView reloadData];
}


- (IBAction)sortText:(id)sender {
    
    for (long i= [self.ourStrings count]; i >= 0; i--) {
        for (long j= i; j<[self.ourStrings count] - 1 ; j++) {
            if ([self.ourStrings[j] compare:self.ourStrings[j+1]] > 0) {
                [self.tableView beginUpdates];

                //Swap our elements
                
                [self.ourStrings exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                
                NSIndexPath *firstIndex = [NSIndexPath indexPathForRow:j inSection:0];
                NSIndexPath *secondIndex = [NSIndexPath indexPathForRow:j+1 inSection:0];
                
                [self.tableView moveRowAtIndexPath:firstIndex toIndexPath:secondIndex];
                
                [self.tableView endUpdates];
            }
        }
    }
    
}

@end
