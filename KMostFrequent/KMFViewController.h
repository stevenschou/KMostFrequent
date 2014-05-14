//
//  KMFViewController.h
//  KMostFrequent
//

#import <UIKit/UIKit.h>

@interface KMFViewController : UIViewController<UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *inputTextView;

@property (strong, nonatomic) IBOutlet UILabel *inputFrequentLabel;

@property (strong, nonatomic) IBOutlet UIStepper *inputFrequentStepper;

@property (strong, nonatomic) IBOutlet UIButton *calculateButton;

@end
