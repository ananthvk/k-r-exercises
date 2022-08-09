#include<stdio.h>
#include "utest.h"
#include<ctype.h>
enum Part {
    INT_PART,
    FRACTIONAL_PART,
    EXPONENTIAL_PART,
};
// For the tests 
const double precision = 1e-8;

double _atof(char s[])
{
    // s - Null terminated string.
    // Function returns the double representation of the number.
    //
    // NOTE: This implementation is not 100% correct
    // For example, it does not error when the number is invalid such as sign inbetween number,
    // alphabets within the number, etc.
    //
    int i = 0, sign = 1, exp_sign = 1;
    double converted = 0;
    double power = 1.0;
    int exp_part = 0;

    enum Part part = INT_PART;
    while(s[i] != '\0')
    {
        // Skip spaces
        if(isspace(s[i]))
        {
            i++;
            continue;
        }

        // Get the sign (if any)
        if(s[i] == '-')
        {
            if(part == INT_PART)
                sign = -sign;
            if(part == EXPONENTIAL_PART)
                exp_sign = -exp_sign;
        }

        // Get the decimal point (if any)
        if(s[i] == '.')
        {
            part = FRACTIONAL_PART;
        }

        if(s[i] == 'e' || s[i] == 'E')
        {
            part = EXPONENTIAL_PART;
        }

        // Process the digits.
        if(isdigit(s[i]))
        {
            if(part == INT_PART || part == FRACTIONAL_PART)
                converted = converted * 10.0 + (s[i] - '0');
            if(part == FRACTIONAL_PART)
            {
                power /= 10;
            }
            if(part == EXPONENTIAL_PART)
            {
                exp_part = exp_part * 10 + (s[i] - '0');
            }
        }
        i++;
    }

    while(exp_part > 0)
    {

        power = (exp_sign == -1)?(power/10):power*10;
        exp_part--;
    }
    /* printf("Exp part:%d\n", exp_part);
     * printf("Power part:%f\n", power);
     * printf("Converted part:%f\n", converted);
     * printf("%s\n","================"); */
    // printf("%f\n", power);
    // printf("%s\n","================");

    return sign*converted*power;
}


UTEST(atof_test, converts_valid_int_part)
{
    ASSERT_NEAR(_atof("52"), 52, precision);
    ASSERT_NEAR(_atof("1234"), 1234, precision);
    ASSERT_NEAR(_atof("321"), 321, precision);
    ASSERT_NEAR(_atof("-121"), -121, precision);
    ASSERT_NEAR(_atof("-52"), -52, precision);
    ASSERT_NEAR(_atof("-65432"), -65432, precision);
    ASSERT_NEAR(_atof("0"), 0, precision);
}

UTEST(atof_test, converts_fractional_part)
{
    ASSERT_NEAR(_atof(".1"), .1, precision);
    ASSERT_NEAR(_atof(".123"), .123, precision);
    ASSERT_NEAR(_atof(".32"), .32, precision);
    ASSERT_NEAR(_atof(".288813"), .288813, precision);

    ASSERT_NEAR(_atof("-.1"), -.1, precision);
    ASSERT_NEAR(_atof("-.123"), -.123, precision);
    ASSERT_NEAR(_atof("-.32"), -.32, precision);
    ASSERT_NEAR(_atof("-.288813"), -.288813, precision);

    ASSERT_NEAR(_atof("0.1"), .1, precision);
    ASSERT_NEAR(_atof("0.123"), .123, precision);
    ASSERT_NEAR(_atof("0.32"), .32, precision);
    ASSERT_NEAR(_atof("0.288813"), .288813, precision);

    ASSERT_NEAR(_atof("-0.1"), -0.1, precision);
    ASSERT_NEAR(_atof("-0.123"), -0.123, precision);
    ASSERT_NEAR(_atof("-0.32"), -0.32, precision);
    ASSERT_NEAR(_atof("-0.288813"), -0.288813, precision);

    ASSERT_NEAR(_atof("0.0"), 0, precision);
    ASSERT_NEAR(_atof(".0"), 0, precision);

}

UTEST(atof_test, converts_string_to_double)
{
    ASSERT_NEAR(_atof("11811.1"), 11811.1, precision);
    ASSERT_NEAR(_atof("99999.123"), 99999.123, precision);
    ASSERT_NEAR(_atof("71231.32"), 71231.32, precision);

    ASSERT_NEAR(_atof("-11811.1"), -11811.1, precision);
    ASSERT_NEAR(_atof("-99999.123"), -99999.123, precision);
    ASSERT_NEAR(_atof("-71231.32"), -71231.32, precision);

    ASSERT_NEAR(_atof("0.0000000001"), 0.0000000001, precision);
    ASSERT_NEAR(_atof("-0.0000000001"),-0.0000000001, precision);
    ASSERT_NEAR(_atof("-0.0000002"), -0.0000002, precision);
    ASSERT_NEAR(_atof("0.000002"), 0.000002, precision);

}

UTEST(atof_test, converts_string_with_exponential_part)
{
    ASSERT_NEAR(_atof("11811.1e3"), 11811.1e3, precision);
    ASSERT_NEAR(_atof("99999.123e4"), 99999.123e4, precision);
    ASSERT_NEAR(_atof("71231.32e6"), 71231.32e6, precision);
    ASSERT_NEAR(_atof("71231.32e-6"), 71231.32e-6, precision);
    // Large negative exponent
    ASSERT_NEAR(_atof("11811.1e-201"), 11811.1e-201, 1e-5);
    ASSERT_NEAR(_atof("312.1234e-153"), 312.1234e-153, 1e-5);
    ASSERT_NEAR(_atof("0.1e-297"), 0.1e-297, 1e-5);

    ASSERT_NEAR(_atof("-11811.1e-201"), -11811.1e-201, 1e-5);
    ASSERT_NEAR(_atof("-312.1234e-153"), -312.1234e-153, 1e-5);
    ASSERT_NEAR(_atof("-0.1e-297"), -0.1e-297, 1e-5);

    // Large positive exponent
    ASSERT_NEAR(_atof("11811.1e+201"), 11811.1e201, 1e190);
    ASSERT_NEAR(_atof("312.1234e+153"), 312.1234e+153, 1e143);
    ASSERT_NEAR(_atof("0.1e+297"), 0.1e+297, 1e285);

}

UTEST_MAIN();
