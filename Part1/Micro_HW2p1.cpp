#include <stdio.h>

int main() {
    int num, frac;

    printf("***Please enter the number: ");
    scanf("%d", &num);
    printf("\n");

    _asm{
        mov eax, num;
        mov ebx, 1; 
    lp:
        mul ebx; 
        inc ebx; 
        cmp ebx, num;
        jl lp; 
        mov frac, eax;
    }

    printf("The factorial of %d = %d..\n\n", num, frac);
    printf("...THANK YOU...\n\n");
    return 0;
}