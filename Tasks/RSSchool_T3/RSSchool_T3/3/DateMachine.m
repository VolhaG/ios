#import "DateMachine.h"
@interface DateMachine()
    
@end

@implementation DateMachine
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.userInteractionEnabled = YES;
    
    UILabel *resultDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    resultDateLabel.layer.borderColor = [UIColor redColor].CGColor;
    resultDateLabel.backgroundColor = [UIColor grayColor];
    //resultDateLabel.text = [NSDateFormatter localizedStringFromDate:_resultDate dateStyle:(NSDateFormatterNoStyle) timeStyle:NSDateFormatterNoStyle];
    
    UITextField *startDateTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 60, 100, 50)];
    startDateTF.layer.borderColor = [UIColor grayColor].CGColor;
    startDateTF.backgroundColor = [UIColor grayColor];
    [startDateTF setText:[NSDateFormatter localizedStringFromDate:_resultDate dateStyle:(NSDateFormatterNoStyle) timeStyle:NSDateFormatterNoStyle]];
    [self.view addSubview:startDateTF];
    
    UITextField *stepTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 110, 50, 50)];
    stepTF.layer.borderColor = [UIColor grayColor].CGColor;
    stepTF.backgroundColor = [UIColor grayColor];
    [stepTF setText: [self.step stringValue] ];
    [self.view addSubview:stepTF];
    
    UIPickerView *unitsTF = [[UIPickerView alloc] initWithFrame:CGRectMake(10, 160, 100, 100)];
    unitsTF.layer.borderColor = [UIColor grayColor].CGColor;
    unitsTF.backgroundColor = [UIColor grayColor];
  //  [unitsTF setDataSource: _units];
    [self.view addSubview:unitsTF];
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 210, 100, 100)];
    addButton.layer.borderColor = [UIColor redColor].CGColor;
    addButton.layer.cornerRadius = 10;
    addButton.backgroundColor = [UIColor grayColor];
    [addButton setTitle:@"Add" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addUnit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    [addButton release];
    
    UIButton *subButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 210, 100, 100)];
    subButton.layer.borderColor = [UIColor redColor].CGColor;
    subButton.layer.cornerRadius = 10;
    subButton.backgroundColor = [UIColor grayColor];
    [subButton setTitle:@"Sub" forState:UIControlStateNormal];
    [subButton addTarget:self action:@selector(subUnit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:subButton];
    [subButton release];
}

-(void) subUnit:(id)sender {
    //self.resultDate = self.startDate - self.unit;
}

-(void) addUnit:(id)sender {
 //   self.resultDate = self.startDate + self.unit;
}


@end
