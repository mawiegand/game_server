all:
	xsltproc --xinclude rules.ruby.xsl rules.xml > ../app/models/game_rules/rules.rb
	xsltproc --xinclude rules.fields.xsl rules.xml  > database_fields
	xsltproc --xinclude rules.cpp.xsl rules.xml  > rules.cpp
	xsltproc --xinclude rules.h.xsl rules.xml    > rules.h
	xsltproc --xinclude tutorial.ruby.xsl tutorial.xml > ../app/models/tutorial/tutorial.rb
	g++ rules_test.cpp  rules.cpp -o rules_test -Wall
	xsltproc --xinclude rules.german_texts.xsl rules.xml > rules.german.html
	xsltproc --xinclude tutorial.german_texts.xsl tutorial.xml > tutorial.german.html



rules_check:
	xmllint --xinclude --postvalid --noout rules.xml 

tutorial_check:
	xmllint --xinclude --postvalid --noout tutorial.xml 