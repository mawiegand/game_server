all: rules_check tutorial_check
	@echo "#########################################################"
	@echo "#                                                       #"
	@echo "#         Did you raise the version numbers?            #"
	@echo "#                                                       #"
	@echo "#########################################################"
	xsltproc --xinclude rules.ruby.xsl rules.xml > ../app/models/game_rules/rules.rb
	xsltproc --xinclude rules.fields.xsl rules.xml  > database_fields
	xsltproc --xinclude rules.cpp.xsl rules.xml  > rules.cpp
	xsltproc --xinclude rules.h.xsl rules.xml    > rules.h
	xsltproc --xinclude tutorial.ruby.xsl tutorial.xml > ../app/models/tutorial/tutorial.rb
	xsltproc --xinclude tutorial.fields.xsl tutorial.xml  >> database_fields
	xsltproc --xinclude rules.german_texts.xsl rules.xml > rules.german.html
	xsltproc --xinclude tutorial.german_texts.xsl tutorial.xml > tutorial.german.html
	xsltproc --xinclude rules.english_texts.xsl rules.xml > rules.english.html
	xsltproc --xinclude tutorial.english_texts.xsl tutorial.xml > tutorial.english.html
	g++ rules_test.cpp  rules.cpp -o rules_test -Wall
	../script/rules/check_formula.rb
	@echo "#########################################################"
	@echo "#                                                       #"
	@echo "#         Did you raise the version numbers?            #"
	@echo "#                                                       #"
	@echo "#########################################################"

rules_check:
	xmllint --xinclude --postvalid --noout rules.xml 

tutorial_check:
	xmllint --xinclude --postvalid --noout tutorial.xml
