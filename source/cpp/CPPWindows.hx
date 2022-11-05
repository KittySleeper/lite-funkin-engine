package cpp;
#if windows

import cpp.Int64;

// only for windows atm

@:headerCode('
#include <windows.h>
#include <iostream>
')

class CPPWindows
{
    @:functionCode('
    // https://www.programiz.com/cpp-programming/examples/add-numbers
    int first_number, second_number, sum;
    
    cout << "Enter two integers: ";
    cin >> first_number >> second_number;
  
    // sum of two numbers in stored in variable sumOfTwoNumbers
    sum = first_number + second_number;
  
    // prints sum 
    cout << first_number << " + " <<  second_number << " = " << sum;     
  
    return 0;
    ')
    public static function returnTwoNumbers():Int64
    {
        return 0;
    }
}
#end