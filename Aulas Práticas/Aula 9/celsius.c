#include <stdio.h>

double f2c(double ft);

int main(void)
{
    double c,f;
    printf("Qual a temperatura em Fahrenheit: ");
    scanf("%1f", &f);
    c = f2c(f);
    printf("\nTemperatura em Celsiuis: %lf", c);
    return 0;
}

double f2c(double ft)
{
    return (5.0 / 9.0 * (ft - 32.0));
}
