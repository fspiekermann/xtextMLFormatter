/*******************************************************************************
 * Copyright (c) 2019 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package com.itemis.xtext.antlr4.generator

import org.eclipse.xtext.Grammar
import org.eclipse.xtext.xtext.generator.parser.antlr.AntlrGrammar
import org.eclipse.xtext.xtext.generator.parser.antlr.GrammarNaming

/**
 * @author Holger Schill - Initial contribution and API
 * @author Fabio Spiekermann - Adding independent machine learning formatter interface
 */
class Antlr4GrammarNaming extends GrammarNaming {
	override getInternalParserSuperClass(Grammar it) {
		null
	}
	
	override isCombinedGrammar(Grammar it) {
		true
	}
	
	override protected getGrammarNamePrefix(Grammar it) {
		return "MLFormatter_" + it.name.split("\\.").last
	}
	
	override  AntlrGrammar getParserGrammar(Grammar it) {
		new org.xtext.example.mydsl.antlr4.generator.Antlr4Grammar(internalParserPackage, '''�grammarNamePrefix��IF !combinedGrammar�Parser�ENDIF�''')
	}
}
