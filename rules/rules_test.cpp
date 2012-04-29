#include <iostream>

#include "rules.h"

using namespace std;

int main(int argc, const char* argv[])
{	
	const Rules* rules = Rules::theRules();
	
	char buf[1000];
	
	for (int i=0; i < MAX_UNIT; i++) {	
		cout << rules->unitTypes[i]->toString(buf, 1000) << endl;
	}
	
	return 0;
}