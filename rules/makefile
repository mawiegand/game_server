all:
	xsltproc rules.ruby.xsl rules.xml > ../app/models/game_rules/rules.rb
	xsltproc rules.cpp.xsl rules.xml  > rules.cpp
	xsltproc rules.h.xsl rules.xml    > rules.h
	g++ rules_test.cpp  rules.cpp -o rules_test -Wall
