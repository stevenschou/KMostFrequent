//
//  KMFViewController.m
//  KMostFrequent
//

#import "KMFViewController.h"
#import "KMFTableViewController.h"

@interface KMFViewController ()

@end

@implementation KMFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _inputTextView.delegate = self;
}

- (IBAction)valueChanged:(UIStepper *)sender {
    double value = [sender value];
    
    [_inputFrequentLabel setText:[NSString stringWithFormat:@"%d", (int)value]];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    // look for newlines to see if we should dismiss the keyboard
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue destinationViewController] isKindOfClass:[KMFTableViewController class]]) {
        KMFTableViewController *vc = (KMFTableViewController *)[segue destinationViewController];
        vc.inputString = _inputTextView.text;
        vc.numFrequentWords = _inputFrequentStepper.value;
    }
}

@end
