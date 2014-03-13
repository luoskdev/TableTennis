//
//  AddRecordViewController.m
//  TableTennis
//
//  Created by Luo Shikai on 14-3-13.
//  Copyright (c) 2014年 isnailbook. All rights reserved.
//

#import "AddRecordViewController.h"
#import "Record.h"
#import "RecordDAO.h"

@interface AddRecordViewController ()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *shotsLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *shotsPickerView;
@property (strong, nonatomic) NSDate *date;

@end

@implementation AddRecordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Add Record";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveRecord)];
    self.date = [[NSDate alloc] init];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.dateLabel.text = [dateFormat stringFromDate:self.date];
    self.shotsLabel.text = @"25";
    self.shotsPickerView.dataSource = self;
    self.shotsPickerView.delegate = self;
    self.shotsPickerView.showsSelectionIndicator = YES;
    [self.shotsPickerView selectRow:10 inComponent:0 animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveRecord
{
    Record *record = [[Record alloc] init];
    record.date = self.date;
    record.shots = self.shotsLabel.text;
    
    [[RecordDAO sharedManager] create:record];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 36;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%ld", row + 15];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.shotsLabel.text = [NSString stringWithFormat:@"%ld", row + 15];
}
@end
