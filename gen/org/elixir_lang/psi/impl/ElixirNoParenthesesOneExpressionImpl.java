// This is a generated file. Not intended for manual editing.
package org.elixir_lang.psi.impl;

import java.util.List;
import org.jetbrains.annotations.*;
import com.intellij.lang.ASTNode;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiElementVisitor;
import com.intellij.psi.util.PsiTreeUtil;
import static org.elixir_lang.psi.ElixirTypes.*;
import com.intellij.extapi.psi.ASTWrapperPsiElement;
import org.elixir_lang.psi.*;

public class ElixirNoParenthesesOneExpressionImpl extends ASTWrapperPsiElement implements ElixirNoParenthesesOneExpression {

  public ElixirNoParenthesesOneExpressionImpl(ASTNode node) {
    super(node);
  }

  public void accept(@NotNull PsiElementVisitor visitor) {
    if (visitor instanceof ElixirVisitor) ((ElixirVisitor)visitor).visitNoParenthesesOneExpression(this);
    else super.accept(visitor);
  }

  @Override
  @Nullable
  public ElixirCallArgumentsNoParenthesesOne getCallArgumentsNoParenthesesOne() {
    return findChildByClass(ElixirCallArgumentsNoParenthesesOne.class);
  }

  @Override
  @Nullable
  public ElixirDotDoIdentifier getDotDoIdentifier() {
    return findChildByClass(ElixirDotDoIdentifier.class);
  }

  @Override
  @Nullable
  public ElixirDotIdentifier getDotIdentifier() {
    return findChildByClass(ElixirDotIdentifier.class);
  }

}
