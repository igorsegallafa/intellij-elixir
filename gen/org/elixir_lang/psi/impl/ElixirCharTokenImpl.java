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
import com.ericsson.otp.erlang.OtpErlangObject;

public class ElixirCharTokenImpl extends ASTWrapperPsiElement implements ElixirCharToken {

  public ElixirCharTokenImpl(@NotNull ASTNode node) {
    super(node);
  }

  public void accept(@NotNull ElixirVisitor visitor) {
    visitor.visitCharToken(this);
  }

  @Override
  public void accept(@NotNull PsiElementVisitor visitor) {
    if (visitor instanceof ElixirVisitor) accept((ElixirVisitor)visitor);
    else super.accept(visitor);
  }

  @Override
  @Nullable
  public ElixirEscapedCharacter getEscapedCharacter() {
    return PsiTreeUtil.getChildOfType(this, ElixirEscapedCharacter.class);
  }

  @Override
  @Nullable
  public ElixirEscapedEOL getEscapedEOL() {
    return PsiTreeUtil.getChildOfType(this, ElixirEscapedEOL.class);
  }

  @Override
  @Nullable
  public ElixirQuoteHexadecimalEscapeSequence getQuoteHexadecimalEscapeSequence() {
    return PsiTreeUtil.getChildOfType(this, ElixirQuoteHexadecimalEscapeSequence.class);
  }

  @Override
  public @NotNull OtpErlangObject quote() {
    return ElixirPsiImplUtil.quote(this);
  }

}
