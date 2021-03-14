package org.elixir_lang.leex.reference

import com.intellij.openapi.util.TextRange
import com.intellij.psi.PsiPolyVariantReferenceBase
import com.intellij.psi.ResolveResult
import com.intellij.psi.impl.source.resolve.ResolveCache
import org.elixir_lang.psi.AtNonNumericOperation
import org.elixir_lang.leex.reference.resolver.Assign

class Assign(usage: AtNonNumericOperation): PsiPolyVariantReferenceBase<AtNonNumericOperation>(usage, TextRange(0, usage.textLength)) {
    val name: String by lazy {
        usage.moduleAttributeName().substring(1)
    }

    override fun multiResolve(incompleteCode: Boolean): Array<ResolveResult> =
            ResolveCache
                    .getInstance(this.myElement.project)
                    .resolveWithCaching(
                            this,
                            Assign,
                            false,
                            incompleteCode
                    )
}
