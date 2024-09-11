# IEEE_adder Module

## Overview

The `IEEE_adder` module performs addition or subtraction on two 32-bit IEEE 754 floating-point numbers. It accurately handles various exponent values, aligns significands (fractional parts), and ensures compliance with IEEE 754 standards.
![Single-Precision-IEEE-754-Floating-Point-Standard](https://github.com/user-attachments/assets/06f8e3b3-8897-4724-b6a9-624028836b56)

## Operation Steps

1. **Exponent Difference Calculation**
   - Computes the difference between the exponents of the two input floating-point numbers.
   - Determines the amount of shift needed for one of the significands to align them correctly.

2. **Sign and Exponent Handling**
   - Based on the exponent difference, selects the exponent to be used in the result.
   - If the exponents are equal, compares the significands to decide which number’s exponent and sign will be used in the result.

3. **Significand Alignment**
   - Aligns the significands by shifting the significand of the number with the smaller exponent, so both significands are compared on the same scale.

4. **Addition/Subtraction of Significands**
   - Performs the addition or subtraction of the aligned significands based on the specified operation (addition or subtraction).

5. **Result Adjustment**
   - Adjusts the result to conform to the IEEE 754 format.
   - Includes normalization of the result, rounding, and potential adjustment of the exponent.

6. **Output Generation**
   - Constructs the final result by combining the sign, adjusted exponent, and the resulting significand.

## Inputs

- **number1**: 32-bit IEEE 754 floating-point number to be added or subtracted.
- **number2**: 32-bit IEEE 754 floating-point number to be added or subtracted.
- **op**: Operation type (0 for addition, 1 for subtraction).

## Outputs

- **result**: 32-bit IEEE 754 floating-point result of the operation.

The block diagram used to build this IEEE 754 adder/subtractor module is shown below.

![WhatsApp Image 2024-09-10 at 22 29 14](https://github.com/user-attachments/assets/c3402e20-efed-458a-b152-3371802d7c56)
