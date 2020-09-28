#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <locale.h>

char str_arr[256][256];
char str[256];
int sort[256];
int i = 0;
int j = 0;
char *buf;

extern "C" void __cdecl simbol_count(char *str);
extern "C" void Get_rez(int rez) {
	sort[j] = rez; // создаем массив количества символов в каждом слове
	j++;
}

int main()
{
	setlocale(LC_ALL, "russian");
	std::cout << "Введите строку не более 255 символов: ";
	gets_s(str, sizeof(str));
	setlocale(LC_ALL, "russian");
	buf = strtok(str, " ");
	while (buf != NULL) // разделяем строку на слова
	{
		strcpy(str_arr[i], buf);
		buf = strtok(NULL, " ");
		i++;
	}

	for (int k = 0; k < i; k++) { // переход к ассемблеру (функция подсчета символов в слове)
		simbol_count(str_arr[k]);
	}

	for (int k = 0; k < i; k++) { // сортируем слова по длине
		for (int l = 0; l < i - 1; l++) {
			if (sort[l] > sort[l + 1])
			{
				strcpy(str, str_arr[l]);
				j = sort[l];
				strcpy(str_arr[l], str_arr[l + 1]);
				sort[l] = sort[l + 1];
				strcpy(str_arr[l + 1], str);
				sort[l + 1] = j;
			}
		}
	}
	strcpy(str, ""); // создаем строку
	for (int k = 0; k < i; k++) {
		strcat(str, str_arr[k]);
		strcat(str, " ");
	}
	std::cout << "Строка, отсортированная по длине: " << str << "\n";
	system("pause");
	return 0;
}