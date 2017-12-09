//
//  ViewController.m
//  iosCalc
//
//  Created by Rodney Kahane on 12/3/17.
//  Copyright © 2017 Rodney Kahane. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    char op;
    int currentNumber;
    BOOL firstOperand, isNumerator;
    Calculator *myCalculator;
    NSMutableString *displayString;
}//end globals




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    firstOperand = YES;
    isNumerator = YES;
    displayString = [NSMutableString stringWithCapacity:40];
    myCalculator = [[Calculator alloc]init];
}//end viewDidLoad

-(void) processDigit: (int) digit {

    currentNumber = currentNumber * 10 + digit;
    
    [displayString appendString:[NSString stringWithFormat:@"%i",digit]];
    display.text=displayString;
    
}//end processDigit

-(IBAction) clickDigit:(UIButton *)sender {
    
    int digit = sender.tag;
    
    [self processDigit:digit];
    
}//end clickDigit

-(void) processOp:(char)theOp {
    
    NSString *opStr;
    
    op = theOp;
    
    switch(theOp) {
        case '+':
            opStr = @" + ";
            break;
        case '-':
            opStr = @" - ";
            break;
        case '*':
            opStr = @" * ";
            break;
        case '/':
            opStr = @" / ";
            break;
    }//end switch
    
    [self storeFracPart];
    firstOperand = NO;
    isNumerator = YES;
    
    [displayString appendString: opStr];
    display.text = displayString;
    
}//end processOp

-(void) storeFracPart {
    
    if (firstOperand) {
        if(isNumerator) {
            myCalculator.operand1.numerator = currentNumber;
            myCalculator.operand1.denominator = 1;  //eg 3* 4/5 =
        }//end isNumerator
        else
            myCalculator.operand1.denominator = currentNumber;
    }//end if firstOperand
    else if (isNumerator) {
        myCalculator.operand2.numerator = currentNumber;
        myCalculator.operand2.denominator = 1; // eg 3/2 * 4 =
    }//end else if
    else {
        myCalculator.operand2.denominator = currentNumber;
        firstOperand = YES;
    }//end else
    
    currentNumber = 0;
    
}//end storeFracPart

-(IBAction)clickOver {
    [self storeFracPart];
    isNumerator = NO;
    [displayString appendString: @"/"];
    display.text = displayString;
}//end clickOver

-(IBAction)clickPlus {
    
    [self processOp: '+'];
    
}//end clickPlus


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}//end didReceiveMemoryWarning


@end
