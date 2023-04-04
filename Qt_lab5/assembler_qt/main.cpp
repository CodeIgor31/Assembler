#include <iostream>
#include <stdio.h>
#include <string.h>
#include <locale.h>
#include <stdlib.h>
extern "C" void COMPARE(char* x, int n, char* y, int m,char *p);
using namespace std;
int main()
{
char a[256],b[256],c[256];
std::cout << "Введите строку\n";
std::cin.getline(a, 256);
std::cout << "Введенная строка: " << a << std::endl;
std::cout << "Введите строку\n";
std::cin.getline(b, 256);
std::cout << "Введенная строка: " << b << std::endl;
COMPARE(a, strlen(a)+1, b, strlen(b)+1, c);
std::cout << "Строка: " << c << std::endl;
return 0;
}
