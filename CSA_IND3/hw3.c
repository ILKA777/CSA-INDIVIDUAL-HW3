#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>


static double x;
static double inf = INFINITY;

double factorial (double n) {
  return (n < 2) ? 1 : n * factorial (n - 1);
}

int main() {
    
    printf("Enter X: ");
    scanf("%lf", &x);
    
    while(x > 121 || x < -63) {
        printf("Enter X in the range -63 to 121: ");
        scanf("%lf", &x);
    }
    
    double exact_result = (exp(x) - exp(-x))/2;
    
    printf("Accurate result: %.30lf\n", exact_result);
    
    double result, step = 0;
    
    int n = 1;
    
    for (int i = 0; i < 900; ++i) {
        result = 0;
        n = 1;
        do {
            step = pow(x, n) / factorial(n);
            if (result + step >= inf) {
                break;
            }
            result += step;
            n += 2;
        } while (fabs(step) != 0);

    }
    
    printf("The result obtained as a result of the summation of the power series: %.30lf\n", result);
    
    if(fabs(exact_result - result) <= fabs(exact_result * 0.01)) {
        printf("Accuracy not less than 0.1 percent \n");
    }
    
}
