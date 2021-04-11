package org.elixir_lang.psi

import com.intellij.psi.PsiElement
import com.intellij.psi.PsiPolyVariantReference
import com.intellij.psi.ResolveResult
import com.intellij.psi.ResolveState
import org.elixir_lang.psi.call.Call
import org.elixir_lang.psi.call.name.Function.UNQUOTE
import org.elixir_lang.psi.call.name.Module.KERNEL
import org.elixir_lang.psi.impl.call.finalArguments
import org.elixir_lang.psi.scope.WhileIn.whileIn

object Unquote {
    fun treeWalkUp(unquoteCall: Call, resolveState: ResolveState, keepProcessing: (PsiElement, ResolveState) -> Boolean): Boolean =
            unquoteCall
                    .finalArguments()
                    ?.singleOrNull()
                    ?.let { it as Call }
                    ?.reference
                    ?.let { it as PsiPolyVariantReference }
                    ?.let { reference ->
                        reference
                                .multiResolve(false)
                                .filter(ResolveResult::isValidResult)
                                .mapNotNull(ResolveResult::getElement)
                                .filterIsInstance<Call>()
                                .filter { CallDefinitionClause.`is`(it) }
                                .let { unquotedFunctionDefinitionList ->
                                    whileIn(unquotedFunctionDefinitionList) {
                                        Using.treeWalkUp(it, null, resolveState, keepProcessing)
                                    }
                                }
                    }
                    ?: true

    fun `is`(call: Call): Boolean = call.isCalling(KERNEL, UNQUOTE)
}
