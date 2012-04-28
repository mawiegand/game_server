all:
	xsltproc rules.cpp.xsl rules.xml  > rules.cpp
	xsltproc rules.h.xsl rules.xml    > rules.h
	g++ rules_test.cpp  rules.cpp -o rules_test -Wall
