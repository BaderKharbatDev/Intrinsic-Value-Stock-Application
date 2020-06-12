//
//  ViewController.m
//  Intrinsic Stock Value
//
//  Created by Bader on 5/24/20.
//  Copyright © 2020 Nebo. All rights reserved.
//
//#import "AppDelegate.h"
#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *tickerInput;
@property (strong, nonatomic) IBOutlet UILabel *cnLabel;
@property (strong, nonatomic) IBOutlet UILabel *prLabel;
@property (strong, nonatomic) IBOutlet UIButton *goBuutton;
@property (weak, nonatomic) IBOutlet UILabel *ivOutput;
@property (weak, nonatomic) IBOutlet UISlider *drSlider;
@property (weak, nonatomic) IBOutlet UILabel *drLabel;
@property (strong, nonatomic) IBOutlet UILabel *peLabel;
@property (strong, nonatomic) IBOutlet UISlider *peSlider;
@property (strong, nonatomic) IBOutlet UILabel *agLabel;
@property (strong, nonatomic) IBOutlet UISlider *agSlider;
@property StockManager * manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate* delegateInstance = ( AppDelegate* )[UIApplication sharedApplication].delegate;
    _manager = [delegateInstance stockManager];
    [self uiSetup];
}

-(void)uiSetup {
    _drSlider.minimumValue = 0;
    _drSlider.maximumValue = 0.2;
    _drSlider.value = 0.08;
    self.drLabel.text = [NSString stringWithFormat:@"%%%1.1f", self.drSlider.value*100];
    _peSlider.minimumValue = 0;
    _peSlider.maximumValue = 50;
    _peSlider.value = [[self.manager.stockData objectForKey:@"pe"] doubleValue];
    self.peLabel.text = [NSString stringWithFormat:@"%1.1f", self.peSlider.value];
        
    _agSlider.minimumValue = -0.1;
    _agSlider.maximumValue = 0.2;
    _agSlider.value = 0.115;
    self.agLabel.text = [NSString stringWithFormat:@"%%%1.1f", self.agSlider.value*100];

    _tickerInput.text = @"aapl";
    _goBuutton.layer.cornerRadius = 5;
    _goBuutton.clipsToBounds = true;
    [self updateUI];
}

- (IBAction)goButtonPressed:(UIButton *)sender {
    //special case for when user needs to reset slide val
    _peSlider.value = [[self.manager.stockData objectForKey:@"pe"] doubleValue];
    [self updateUI];
}


- (void) updateUI {
    if(![[_manager.stockData objectForKey:@"ticker"] isEqualToString: _tickerInput.text]) {
        [_manager setTicker: _tickerInput.text];
        _cnLabel.text = [_manager.stockData objectForKey:@"name"];
        _peSlider.value = [[self.manager.stockData objectForKey:@"pe"] doubleValue];
        [_agSlider setValue: 0.115];
        [_drSlider setValue: 0.09];
    }
    
    //updates labels
    _ivOutput.text = [NSString stringWithFormat:@"$%1.2f",
                      [_manager getIV: [_drSlider value] : [_agSlider value] : [_peSlider value]]];
    self.drLabel.text = [NSString stringWithFormat:@"%%%1.1f", self.drSlider.value*100];
    self.agLabel.text = [NSString stringWithFormat:@"%%%1.1f", self.agSlider.value*100];
    self.peLabel.text = [NSString stringWithFormat:@"%1.1f", self.peSlider.value];
    
}


- (IBAction)onSliderUpdate:(UISlider *)sender {
    [self updateUI];
}




@end
