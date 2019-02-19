/*******************************************************************************
 * Copyright (c) 2019 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package com.itemis.xtext.antlr4.generator

import com.google.inject.Inject
import org.eclipse.xtext.AbstractElement
import org.eclipse.xtext.Grammar
import org.eclipse.xtext.TerminalRule
import org.eclipse.xtext.xtext.generator.parser.antlr.AbstractAntlrGrammarGenerator
import org.eclipse.xtext.xtext.generator.parser.antlr.AntlrOptions
import static extension com.itemis.xtext.antlr4.generator.TerminalRuleToLexerBody.*

/**
 * @author Holger Schill - Initial contribution and API
 * @author Fabio Spiekermann - Adding independent machine learning interface
 */
class Antlr4GrammarGenerator extends AbstractAntlrGrammarGenerator {
	@Inject org.xtext.example.mydsl.antlr4.generator.Antlr4GrammarNaming naming

	override protected getGrammarNaming() {
		naming
	}

	override protected compileParserOptions(Grammar it, AntlrOptions options) {
		"options {contextSuperClass=org.antlr.v4.runtime.RuleContextWithAltNum;}"
	}

	override protected compileParserHeader(Grammar it, AntlrOptions options) '''
	'''

	override protected compileLexerHeader(Grammar it, AntlrOptions options) '''
	'''

	protected override String ebnfPredicate(AbstractElement it, AntlrOptions options) ''''''

	protected override String dataTypeEbnfPredicate(AbstractElement it) ''''''

	protected override dispatch compileRule(TerminalRule it, Grammar grammar, AntlrOptions options) '''
		�IF options.isBacktrackLexer�
			�IF !isSyntheticTerminalRule(it)�
				�IF fragment�
					fragment �ruleName� : �toLexerBody�;
				�ELSE�
					fragment �ruleName� : FRAGMENT_�ruleName�;
					fragment FRAGMENT_�ruleName� : �toLexerBody�;
				�ENDIF�
			�ENDIF�
		�ELSE�
			�IF isSyntheticTerminalRule(it)�
				fragment �ruleName� : ;
			�ELSE�
				�IF fragment�
					fragment 
				�ENDIF�
				�ruleName� : �toLexerBody�
				�IF shouldBeSkipped(grammar)�
					 -> channel(HIDDEN)
					�ENDIF�;
			�ENDIF�
		�ENDIF�
	'''
}
