# Source code recreated from a .beam file by IntelliJ Elixir
defmodule Kernel do
  @moduledoc ~S"""
  `Kernel` is Elixir's default environment.

  It mainly consists of:

    * basic language primitives, such as arithmetic operators, spawning of processes,
      data type handling, and others
    * macros for control-flow and defining new functionality (modules, functions, and the like)
    * guard checks for augmenting pattern matching

  You can invoke `Kernel` functions and macros anywhere in Elixir code
  without the use of the `Kernel.` prefix since they have all been
  automatically imported. For example, in IEx, you can call:

      iex> is_number(13)
      true

  If you don't want to import a function or macro from `Kernel`, use the `:except`
  option and then list the function/macro by arity:

      import Kernel, except: [if: 2, unless: 2]

  See `Kernel.SpecialForms.import/2` for more information on importing.

  Elixir also has special forms that are always imported and
  cannot be skipped. These are described in `Kernel.SpecialForms`.

  ## The standard library

  `Kernel` provides the basic capabilities the Elixir standard library
  is built on top of. It is recommended to explore the standard library
  for advanced functionality. Here are the main groups of modules in the
  standard library (this list is not a complete reference, see the
  documentation sidebar for all entries).

  ### Built-in types

  The following modules handle Elixir built-in data types:

    * `Atom` - literal constants with a name (`true`, `false`, and `nil` are atoms)
    * `Float` - numbers with floating point precision
    * `Function` - a reference to code chunk, created with the `fn/1` special form
    * `Integer` - whole numbers (not fractions)
    * `List` - collections of a variable number of elements (linked lists)
    * `Map` - collections of key-value pairs
    * `Process` - light-weight threads of execution
    * `Port` - mechanisms to interact with the external world
    * `Tuple` - collections of a fixed number of elements

  There are two data types without an accompanying module:

    * Bitstring - a sequence of bits, created with `Kernel.SpecialForms.<<>>/1`.
      When the number of bits is divisible by 8, they are called binaries and can
      be manipulated with Erlang's `:binary` module
    * Reference - a unique value in the runtime system, created with `make_ref/0`

  ### Data types

  Elixir also provides other data types that are built on top of the types
  listed above. Some of them are:

    * `Date` - `year-month-day` structs in a given calendar
    * `DateTime` - date and time with time zone in a given calendar
    * `Exception` - data raised from errors and unexpected scenarios
    * `MapSet` - unordered collections of unique elements
    * `NaiveDateTime` - date and time without time zone in a given calendar
    * `Keyword` - lists of two-element tuples, often representing optional values
    * `Range` - inclusive ranges between two integers
    * `Regex` - regular expressions
    * `String` - UTF-8 encoded binaries representing characters
    * `Time` - `hour:minute:second` structs in a given calendar
    * `URI` - representation of URIs that identify resources
    * `Version` - representation of versions and requirements

  ### System modules

  Modules that interface with the underlying system, such as:

    * `IO` - handles input and output
    * `File` - interacts with the underlying file system
    * `Path` - manipulates file system paths
    * `System` - reads and writes system information

  ### Protocols

  Protocols add polymorphic dispatch to Elixir. They are contracts
  implementable by data types. See `Protocol` for more information on
  protocols. Elixir provides the following protocols in the standard library:

    * `Collectable` - collects data into a data type
    * `Enumerable` - handles collections in Elixir. The `Enum` module
      provides eager functions for working with collections, the `Stream`
      module provides lazy functions
    * `Inspect` - converts data types into their programming language
      representation
    * `List.Chars` - converts data types to their outside world
      representation as charlists (non-programming based)
    * `String.Chars` - converts data types to their outside world
      representation as strings (non-programming based)

  ### Process-based and application-centric functionality

  The following modules build on top of processes to provide concurrency,
  fault-tolerance, and more.

    * `Agent` - a process that encapsulates mutable state
    * `Application` - functions for starting, stopping and configuring
      applications
    * `GenServer` - a generic client-server API
    * `Registry` - a key-value process-based storage
    * `Supervisor` - a process that is responsible for starting,
      supervising and shutting down other processes
    * `Task` - a process that performs computations
    * `Task.Supervisor` - a supervisor for managing tasks exclusively

  ### Supporting documents

  Elixir documentation also includes supporting documents under the
  "Pages" section. Those are:

    * [Compatibility and Deprecations](compatibility-and-deprecations.md) - lists
      compatibility between every Elixir version and Erlang/OTP, release schema;
      lists all deprecated functions, when they were deprecated and alternatives
    * [Library Guidelines](library-guidelines.md) - general guidelines, anti-patterns,
      and rules for those writing libraries
    * [Naming Conventions](naming-conventions.md) - naming conventions for Elixir code
    * [Operators](operators.md) - lists all Elixir operators and their precedences
    * [Patterns and Guards](patterns-and-guards.md) - an introduction to patterns,
      guards, and extensions
    * [Syntax Reference](syntax-reference.md) - the language syntax reference
    * [Typespecs](typespecs.md)- types and function specifications, including list of types
    * [Unicode Syntax](unicode-syntax.md) - outlines Elixir support for Unicode
    * [Writing Documentation](writing-documentation.md) - guidelines for writing
      documentation in Elixir

  ## Guards

  This module includes the built-in guards used by Elixir developers.
  They are a predefined set of functions and macros that augment pattern
  matching, typically invoked after the `when` operator. For example:

      def drive(%User{age: age}) when age >= 16 do
        ...
      end

  The clause above will only be invoked if the user's age is more than
  or equal to 16. Guards also support joining multiple conditions with
  `and` and `or`. The whole guard is true if all guard expressions will
  evaluate to `true`. A more complete introduction to guards is available
  [in the "Patterns and Guards" page](patterns-and-guards.md).

  ## Inlining

  Some of the functions described in this module are inlined by
  the Elixir compiler into their Erlang counterparts in the
  [`:erlang` module](http://www.erlang.org/doc/man/erlang.html).
  Those functions are called BIFs (built-in internal functions)
  in Erlang-land and they exhibit interesting properties, as some
  of them are allowed in guards and others are used for compiler
  optimizations.

  Most of the inlined functions can be seen in effect when
  capturing the function:

      iex> &Kernel.is_atom/1
      &:erlang.is_atom/1

  Those functions will be explicitly marked in their docs as
  "inlined by the compiler".

  ## Truthy and falsy values

  Besides the booleans `true` and `false`, Elixir has the
  concept of a "truthy" or "falsy" value.

    *  a value is truthy when it is neither `false` nor `nil`
    *  a value is falsy when it is either `false` or `nil`

  Elixir has functions, like `and/2`, that *only* work with
  booleans, but also functions that work with these
  truthy/falsy values, like `&&/2` and `!/1`.

  ### Examples

  We can check the truthiness of a value by using the `!/1`
  function twice.

  Truthy values:

      iex> !!true
      true
      iex> !!5
      true
      iex> !![1,2]
      true
      iex> !!"foo"
      true

  Falsy values (of which there are exactly two):

      iex> !!false
      false
      iex> !!nil
      false


  """

  # Macros

  @doc ~S"""
  Boolean "not" operator.

  Receives any value (not just booleans) and returns `true` if `value`
  is `false` or `nil`; returns `false` otherwise.

  Not allowed in guard clauses.

  ## Examples

      iex> !Enum.empty?([])
      false

      iex> !List.first([])
      true


  """
  defmacro unquote(:!)(p0) do
    # body not decompiled
  end

  @doc ~S"""
  Boolean "and" operator.

  Provides a short-circuit operator that evaluates and returns
  the second expression only if the first one evaluates to a truthy value
  (neither `false` nor `nil`). Returns the first expression
  otherwise.

  Not allowed in guard clauses.

  ## Examples

      iex> Enum.empty?([]) && Enum.empty?([])
      true

      iex> List.first([]) && true
      nil

      iex> Enum.empty?([]) && List.first([1])
      1

      iex> false && throw(:bad)
      false

  Note that, unlike `and/2`, this operator accepts any expression
  as the first argument, not only booleans.

  """
  defmacro left && right do
    # body not decompiled
  end

  @doc ~S"""
  Range creation operator. Returns a range with the specified `first` and `last` integers.

  If last is larger than first, the range will be increasing from
  first to last. If first is larger than last, the range will be
  decreasing from first to last. If first is equal to last, the range
  will contain one element, which is the number itself.

  ## Examples

      iex> 0 in 1..3
      false

      iex> 1 in 1..3
      true

      iex> 2 in 1..3
      true

      iex> 3 in 1..3
      true


  """
  defmacro left .. right do
    # body not decompiled
  end

  @doc ~S"""
  Binary concatenation operator. Concatenates two binaries.

  ## Examples

      iex> "foo" <> "bar"
      "foobar"

  The `<>/2` operator can also be used in pattern matching (and guard clauses) as
  long as the left argument is a literal binary:

      iex> "foo" <> x = "foobar"
      iex> x
      "bar"

  `x <> "bar" = "foobar"` would have resulted in a `CompileError` exception.


  """
  defmacro left <> right do
    # body not decompiled
  end

  @doc ~S"""
  Module attribute unary operator. Reads and writes attributes in the current module.

  The canonical example for attributes is annotating that a module
  implements an OTP behaviour, such as `GenServer`:

      defmodule MyServer do
        @behaviour GenServer
        # ... callbacks ...
      end

  By default Elixir supports all the module attributes supported by Erlang, but
  custom attributes can be used as well:

      defmodule MyServer do
        @my_data 13
        IO.inspect(@my_data)
        #=> 13
      end

  Unlike Erlang, such attributes are not stored in the module by default since
  it is common in Elixir to use custom attributes to store temporary data that
  will be available at compile-time. Custom attributes may be configured to
  behave closer to Erlang by using `Module.register_attribute/3`.

  Finally, note that attributes can also be read inside functions:

      defmodule MyServer do
        @my_data 11
        def first_data, do: @my_data
        @my_data 13
        def second_data, do: @my_data
      end

      MyServer.first_data()
      #=> 11

      MyServer.second_data()
      #=> 13

  It is important to note that reading an attribute takes a snapshot of
  its current value. In other words, the value is read at compilation
  time and not at runtime. Check the `Module` module for other functions
  to manipulate module attributes.

  """
  defmacro unquote(:@)(p0) do
    # body not decompiled
  end

  @doc ~S"""
  When used inside quoting, marks that the given alias should not
  be hygienized. This means the alias will be expanded when
  the macro is expanded.

  Check `Kernel.SpecialForms.quote/2` for more information.

  """
  defmacro alias!(alias) do
    # body not decompiled
  end

  @doc ~S"""
  Strictly boolean "and" operator.

  If `left` is `false`, returns `false`; otherwise returns `right`.

  Requires only the `left` operand to be a boolean since it short-circuits. If
  the `left` operand is not a boolean, an `ArgumentError` exception is raised.

  Allowed in guard tests.

  ## Examples

      iex> true and false
      false

      iex> true and "yay!"
      "yay!"

      iex> "yay!" and true
      ** (BadBooleanError) expected a boolean on left-side of "and", got: "yay!"


  """
  defmacro left and right do
    # body not decompiled
  end

  defmacro binding() do
    # body not decompiled
  end

  @doc ~S"""
  Returns the binding for the given context as a keyword list.

  In the returned result, keys are variable names and values are the
  corresponding variable values.

  If the given `context` is `nil` (by default it is), the binding for the
  current context is returned.

  ## Examples

      iex> x = 1
      iex> binding()
      [x: 1]
      iex> x = 2
      iex> binding()
      [x: 2]

      iex> binding(:foo)
      []
      iex> var!(x, :foo) = 1
      1
      iex> binding(:foo)
      [x: 1]


  """
  defmacro binding(context \\ nil) do
    # body not decompiled
  end

  defmacro def(p0) do
    # body not decompiled
  end

  @doc ~S"""
  Defines a public function with the given name and body.

  ## Examples

      defmodule Foo do
        def bar, do: :baz
      end

      Foo.bar()
      #=> :baz

  A function that expects arguments can be defined as follows:

      defmodule Foo do
        def sum(a, b) do
          a + b
        end
      end

  In the example above, a `sum/2` function is defined; this function receives
  two arguments and returns their sum.

  ## Default arguments

  `\\` is used to specify a default value for a parameter of a function. For
  example:

      defmodule MyMath do
        def multiply_by(number, factor \\ 2) do
          number * factor
        end
      end

      MyMath.multiply_by(4, 3)
      #=> 12

      MyMath.multiply_by(4)
      #=> 8

  The compiler translates this into multiple functions with different arities,
  here `MyMath.multiply_by/1` and `MyMath.multiply_by/2`, that represent cases when
  arguments for parameters with default values are passed or not passed.

  When defining a function with default arguments as well as multiple
  explicitly declared clauses, you must write a function head that declares the
  defaults. For example:

      defmodule MyString do
        def join(string1, string2 \\ nil, separator \\ " ")

        def join(string1, nil, _separator) do
          string1
        end

        def join(string1, string2, separator) do
          string1 <> separator <> string2
        end
      end

  Note that `\\` can't be used with anonymous functions because they
  can only have a sole arity.

  ## Function and variable names

  Function and variable names have the following syntax:
  A _lowercase ASCII letter_ or an _underscore_, followed by any number of
  _lowercase or uppercase ASCII letters_, _numbers_, or _underscores_.
  Optionally they can end in either an _exclamation mark_ or a _question mark_.

  For variables, any identifier starting with an underscore should indicate an
  unused variable. For example:

      def foo(bar) do
        []
      end
      #=> warning: variable bar is unused

      def foo(_bar) do
        []
      end
      #=> no warning

      def foo(_bar) do
        _bar
      end
      #=> warning: the underscored variable "_bar" is used after being set

  ## `rescue`/`catch`/`after`/`else`

  Function bodies support `rescue`, `catch`, `after`, and `else` as `Kernel.SpecialForms.try/1`
  does (known as "implicit try"). For example, the following two functions are equivalent:

      def convert(number) do
        try do
          String.to_integer(number)
        rescue
          e in ArgumentError -> {:error, e.message}
        end
      end

      def convert(number) do
        String.to_integer(number)
      rescue
        e in ArgumentError -> {:error, e.message}
      end


  """
  defmacro def(call, expr \\ nil) do
    # body not decompiled
  end

  @doc ~S"""
  Defines a function that delegates to another module.

  Functions defined with `defdelegate/2` are public and can be invoked from
  outside the module they're defined in, as if they were defined using `def/2`.
  Therefore, `defdelegate/2` is about extending the current module's public API.
  If what you want is to invoke a function defined in another module without
  using its full module name, then use `alias/2` to shorten the module name or use
  `import/2` to be able to invoke the function without the module name altogether.

  Delegation only works with functions; delegating macros is not supported.

  Check `def/2` for rules on naming and default arguments.

  ## Options

    * `:to` - the module to dispatch to.

    * `:as` - the function to call on the target given in `:to`.
      This parameter is optional and defaults to the name being
      delegated (`funs`).

  ## Examples

      defmodule MyList do
        defdelegate reverse(list), to: Enum
        defdelegate other_reverse(list), to: Enum, as: :reverse
      end

      MyList.reverse([1, 2, 3])
      #=> [3, 2, 1]

      MyList.other_reverse([1, 2, 3])
      #=> [3, 2, 1]


  """
  defmacro defdelegate(funs, opts) do
    # body not decompiled
  end

  @doc ~S"""
  Defines an exception.

  Exceptions are structs backed by a module that implements
  the `Exception` behaviour. The `Exception` behaviour requires
  two functions to be implemented:

    * [`exception/1`](`c:Exception.exception/1`) - receives the arguments given to `raise/2`
      and returns the exception struct. The default implementation
      accepts either a set of keyword arguments that is merged into
      the struct or a string to be used as the exception's message.

    * [`message/1`](`c:Exception.message/1`) - receives the exception struct and must return its
      message. Most commonly exceptions have a message field which
      by default is accessed by this function. However, if an exception
      does not have a message field, this function must be explicitly
      implemented.

  Since exceptions are structs, the API supported by `defstruct/1`
  is also available in `defexception/1`.

  ## Raising exceptions

  The most common way to raise an exception is via `raise/2`:

      defmodule MyAppError do
        defexception [:message]
      end

      value = [:hello]

      raise MyAppError,
        message: "did not get what was expected, got: #{inspect(value)}"

  In many cases it is more convenient to pass the expected value to
  `raise/2` and generate the message in the `c:Exception.exception/1` callback:

      defmodule MyAppError do
        defexception [:message]

        @impl true
        def exception(value) do
          msg = "did not get what was expected, got: #{inspect(value)}"
          %MyAppError{message: msg}
        end
      end

      raise MyAppError, value

  The example above shows the preferred strategy for customizing
  exception messages.

  """
  defmacro defexception(fields) do
    # body not decompiled
  end

  @doc ~S"""
  Generates a macro suitable for use in guard expressions.

  It raises at compile time if the definition uses expressions that aren't
  allowed in guards, and otherwise creates a macro that can be used both inside
  or outside guards.

  Note the convention in Elixir is to name functions/macros allowed in
  guards with the `is_` prefix, such as `is_list/1`. If, however, the
  function/macro returns a boolean and is not allowed in guards, it should
  have no prefix and end with a question mark, such as `Keyword.keyword?/1`.

  ## Example

      defmodule Integer.Guards do
        defguard is_even(value) when is_integer(value) and rem(value, 2) == 0
      end

      defmodule Collatz do
        @moduledoc "Tools for working with the Collatz sequence."
        import Integer.Guards

        @doc "Determines the number of steps `n` takes to reach `1`."
        # If this function never converges, please let me know what `n` you used.
        def converge(n) when n > 0, do: step(n, 0)

        defp step(1, step_count) do
          step_count
        end

        defp step(n, step_count) when is_even(n) do
          step(div(n, 2), step_count + 1)
        end

        defp step(n, step_count) do
          step(3 * n + 1, step_count + 1)
        end
      end


  """
  defmacro defguard(guard) do
    # body not decompiled
  end

  @doc ~S"""
  Generates a private macro suitable for use in guard expressions.

  It raises at compile time if the definition uses expressions that aren't
  allowed in guards, and otherwise creates a private macro that can be used
  both inside or outside guards in the current module.

  Similar to `defmacrop/2`, `defguardp/1` must be defined before its use
  in the current module.

  """
  defmacro defguardp(guard) do
    # body not decompiled
  end

  defmacro defimpl(p0, p1) do
    # body not decompiled
  end

  @doc ~S"""
  Defines an implementation for the given protocol.

  See the `Protocol` module for more information.

  """
  defmacro defimpl(name, opts, do_block \\ []) do
    # body not decompiled
  end

  defmacro defmacro(p0) do
    # body not decompiled
  end

  @doc ~S"""
  Defines a public macro with the given name and body.

  Macros must be defined before its usage.

  Check `def/2` for rules on naming and default arguments.

  ## Examples

      defmodule MyLogic do
        defmacro unless(expr, opts) do
          quote do
            if !unquote(expr), unquote(opts)
          end
        end
      end

      require MyLogic

      MyLogic.unless false do
        IO.puts("It works")
      end


  """
  defmacro defmacro(call, expr \\ nil) do
    # body not decompiled
  end

  defmacro defmacrop(p0) do
    # body not decompiled
  end

  @doc ~S"""
  Defines a private macro with the given name and body.

  Private macros are only accessible from the same module in which they are
  defined.

  Private macros must be defined before its usage.

  Check `defmacro/2` for more information, and check `def/2` for rules on
  naming and default arguments.


  """
  defmacro defmacrop(call, expr \\ nil) do
    # body not decompiled
  end

  @doc ~S"""
  Defines a module given by name with the given contents.

  This macro defines a module with the given `alias` as its name and with the
  given contents. It returns a tuple with four elements:

    * `:module`
    * the module name
    * the binary contents of the module
    * the result of evaluating the contents block

  ## Examples

      defmodule Number do
        def one, do: 1
        def two, do: 2
      end
      #=> {:module, Number, <<70, 79, 82, ...>>, {:two, 0}}

      Number.one()
      #=> 1

      Number.two()
      #=> 2

  ## Nesting

  Nesting a module inside another module affects the name of the nested module:

      defmodule Foo do
        defmodule Bar do
        end
      end

  In the example above, two modules - `Foo` and `Foo.Bar` - are created.
  When nesting, Elixir automatically creates an alias to the inner module,
  allowing the second module `Foo.Bar` to be accessed as `Bar` in the same
  lexical scope where it's defined (the `Foo` module). This only happens
  if the nested module is defined via an alias.

  If the `Foo.Bar` module is moved somewhere else, the references to `Bar` in
  the `Foo` module need to be updated to the fully-qualified name (`Foo.Bar`) or
  an alias has to be explicitly set in the `Foo` module with the help of
  `Kernel.SpecialForms.alias/2`.

      defmodule Foo.Bar do
        # code
      end

      defmodule Foo do
        alias Foo.Bar
        # code here can refer to "Foo.Bar" as just "Bar"
      end

  ## Dynamic names

  Elixir module names can be dynamically generated. This is very
  useful when working with macros. For instance, one could write:

      defmodule String.to_atom("Foo#{1}") do
        # contents ...
      end

  Elixir will accept any module name as long as the expression passed as the
  first argument to `defmodule/2` evaluates to an atom.
  Note that, when a dynamic name is used, Elixir won't nest the name under
  the current module nor automatically set up an alias.

  ## Reserved module names

  If you attempt to define a module that already exists, you will get a
  warning saying that a module has been redefined.

  There are some modules that Elixir does not currently implement but it
  may be implement in the future. Those modules are reserved and defining
  them will result in a compilation error:

      defmodule Any do
        # code
      end
      ** (CompileError) iex:1: module Any is reserved and cannot be defined

  Elixir reserves the following module names: `Elixir`, `Any`, `BitString`,
  `PID`, and `Reference`.

  """
  defmacro defmodule(alias, do_block) do
    # body not decompiled
  end

  @doc ~S"""
  Makes the given functions in the current module overridable.

  An overridable function is lazily defined, allowing a developer to override
  it.

  Macros cannot be overridden as functions and vice-versa.

  ## Example

      defmodule DefaultMod do
        defmacro __using__(_opts) do
          quote do
            def test(x, y) do
              x + y
            end

            defoverridable test: 2
          end
        end
      end

      defmodule InheritMod do
        use DefaultMod

        def test(x, y) do
          x * y + super(x, y)
        end
      end

  As seen as in the example above, `super` can be used to call the default
  implementation.

  If `@behaviour` has been defined, `defoverridable` can also be called with a
  module as an argument. All implemented callbacks from the behaviour above the
  call to `defoverridable` will be marked as overridable.

  ## Example

      defmodule Behaviour do
        @callback foo :: any
      end

      defmodule DefaultMod do
        defmacro __using__(_opts) do
          quote do
            @behaviour Behaviour

            def foo do
              "Override me"
            end

            defoverridable Behaviour
          end
        end
      end

      defmodule InheritMod do
        use DefaultMod

        def foo do
          "Overridden"
        end
      end


  """
  defmacro defoverridable(keywords_or_behaviour) do
    # body not decompiled
  end

  defmacro defp(p0) do
    # body not decompiled
  end

  @doc ~S"""
  Defines a private function with the given name and body.

  Private functions are only accessible from within the module in which they are
  defined. Trying to access a private function from outside the module it's
  defined in results in an `UndefinedFunctionError` exception.

  Check `def/2` for more information.

  ## Examples

      defmodule Foo do
        def bar do
          sum(1, 2)
        end

        defp sum(a, b), do: a + b
      end

      Foo.bar()
      #=> 3

      Foo.sum(1, 2)
      ** (UndefinedFunctionError) undefined function Foo.sum/2


  """
  defmacro defp(call, expr \\ nil) do
    # body not decompiled
  end

  @doc ~S"""
  Defines a protocol.

  See the `Protocol` module for more information.

  """
  defmacro defprotocol(name, do_block) do
    # body not decompiled
  end

  @doc ~S"""
  Defines a struct.

  A struct is a tagged map that allows developers to provide
  default values for keys, tags to be used in polymorphic
  dispatches and compile time assertions.

  To define a struct, a developer must define both `__struct__/0` and
  `__struct__/1` functions. `defstruct/1` is a convenience macro which
  defines such functions with some conveniences.

  For more information about structs, please check `Kernel.SpecialForms.%/2`.

  ## Examples

      defmodule User do
        defstruct name: nil, age: nil
      end

  Struct fields are evaluated at compile-time, which allows
  them to be dynamic. In the example below, `10 + 11` is
  evaluated at compile-time and the age field is stored
  with value `21`:

      defmodule User do
        defstruct name: nil, age: 10 + 11
      end

  The `fields` argument is usually a keyword list with field names
  as atom keys and default values as corresponding values. `defstruct/1`
  also supports a list of atoms as its argument: in that case, the atoms
  in the list will be used as the struct's field names and they will all
  default to `nil`.

      defmodule Post do
        defstruct [:title, :content, :author]
      end

  ## Deriving

  Although structs are maps, by default structs do not implement
  any of the protocols implemented for maps. For example, attempting
  to use a protocol with the `User` struct leads to an error:

      john = %User{name: "John"}
      MyProtocol.call(john)
      ** (Protocol.UndefinedError) protocol MyProtocol not implemented for %User{...}

  `defstruct/1`, however, allows protocol implementations to be
  *derived*. This can be done by defining a `@derive` attribute as a
  list before invoking `defstruct/1`:

      defmodule User do
        @derive [MyProtocol]
        defstruct name: nil, age: 10 + 11
      end

      MyProtocol.call(john) # it works!

  For each protocol in the `@derive` list, Elixir will assert the protocol has
  been implemented for `Any`. If the `Any` implementation defines a
  `__deriving__/3` callback, the callback will be invoked and it should define
  the implementation module. Otherwise an implementation that simply points to
  the `Any` implementation is automatically derived. For more information on
  the `__deriving__/3` callback, see `Protocol.derive/3`.

  ## Enforcing keys

  When building a struct, Elixir will automatically guarantee all keys
  belongs to the struct:

      %User{name: "john", unknown: :key}
      ** (KeyError) key :unknown not found in: %User{age: 21, name: nil}

  Elixir also allows developers to enforce certain keys must always be
  given when building the struct:

      defmodule User do
        @enforce_keys [:name]
        defstruct name: nil, age: 10 + 11
      end

  Now trying to build a struct without the name key will fail:

      %User{age: 21}
      ** (ArgumentError) the following keys must also be given when building struct User: [:name]

  Keep in mind `@enforce_keys` is a simple compile-time guarantee
  to aid developers when building structs. It is not enforced on
  updates and it does not provide any sort of value-validation.

  ## Types

  It is recommended to define types for structs. By convention such type
  is called `t`. To define a struct inside a type, the struct literal syntax
  is used:

      defmodule User do
        defstruct name: "John", age: 25
        @type t :: %__MODULE__{name: String.t(), age: non_neg_integer}
      end

  It is recommended to only use the struct syntax when defining the struct's
  type. When referring to another struct it's better to use `User.t` instead of
  `%User{}`.

  The types of the struct fields that are not included in `%User{}` default to
  `term()` (see `t:term/0`).

  Structs whose internal structure is private to the local module (pattern
  matching them or directly accessing their fields should not be allowed) should
  use the `@opaque` attribute. Structs whose internal structure is public should
  use `@type`.

  """
  defmacro defstruct(fields) do
    # body not decompiled
  end

  @doc ~S"""
  Destructures two lists, assigning each term in the
  right one to the matching term in the left one.

  Unlike pattern matching via `=`, if the sizes of the left
  and right lists don't match, destructuring simply stops
  instead of raising an error.

  ## Examples

      iex> destructure([x, y, z], [1, 2, 3, 4, 5])
      iex> {x, y, z}
      {1, 2, 3}

  In the example above, even though the right list has more entries than the
  left one, destructuring works fine. If the right list is smaller, the
  remaining elements are simply set to `nil`:

      iex> destructure([x, y, z], [1])
      iex> {x, y, z}
      {1, nil, nil}

  The left-hand side supports any expression you would use
  on the left-hand side of a match:

      x = 1
      destructure([^x, y, z], [1, 2, 3])

  The example above will only work if `x` matches the first value in the right
  list. Otherwise, it will raise a `MatchError` (like the `=` operator would
  do).

  """
  defmacro destructure(left, right) do
    # body not decompiled
  end

  @doc ~S"""
  Gets a value and updates a nested data structure via the given `path`.

  This is similar to `get_and_update_in/3`, except the path is extracted
  via a macro rather than passing a list. For example:

      get_and_update_in(opts[:foo][:bar], &{&1, &1 + 1})

  Is equivalent to:

      get_and_update_in(opts, [:foo, :bar], &{&1, &1 + 1})

  This also works with nested structs and the `struct.path.to.value` way to specify
  paths:

      get_and_update_in(struct.foo.bar, &{&1, &1 + 1})

  Note that in order for this macro to work, the complete path must always
  be visible by this macro. See the "Paths" section below.

  ## Examples

      iex> users = %{"john" => %{age: 27}, "meg" => %{age: 23}}
      iex> get_and_update_in(users["john"].age, &{&1, &1 + 1})
      {27, %{"john" => %{age: 28}, "meg" => %{age: 23}}}

  ## Paths

  A path may start with a variable, local or remote call, and must be
  followed by one or more:

    * `foo[bar]` - accesses the key `bar` in `foo`; in case `foo` is nil,
      `nil` is returned

    * `foo.bar` - accesses a map/struct field; in case the field is not
      present, an error is raised

  Here are some valid paths:

      users["john"][:age]
      users["john"].age
      User.all()["john"].age
      all_users()["john"].age

  Here are some invalid ones:

      # Does a remote call after the initial value
      users["john"].do_something(arg1, arg2)

      # Does not access any key or field
      users


  """
  defmacro get_and_update_in(path, fun) do
    # body not decompiled
  end

  @doc ~S"""
  Provides an `if/2` macro.

  This macro expects the first argument to be a condition and the second
  argument to be a keyword list.

  ## One-liner examples

      if(foo, do: bar)

  In the example above, `bar` will be returned if `foo` evaluates to
  a truthy value (neither `false` nor `nil`). Otherwise, `nil` will be
  returned.

  An `else` option can be given to specify the opposite:

      if(foo, do: bar, else: baz)

  ## Blocks examples

  It's also possible to pass a block to the `if/2` macro. The first
  example above would be translated to:

      if foo do
        bar
      end

  Note that `do/end` become delimiters. The second example would
  translate to:

      if foo do
        bar
      else
        baz
      end

  In order to compare more than two clauses, the `cond/1` macro has to be used.

  """
  defmacro if(condition, clauses) do
    # body not decompiled
  end

  @doc ~S"""
  Membership operator. Checks if the element on the left-hand side is a member of the
  collection on the right-hand side.

  ## Examples

      iex> x = 1
      iex> x in [1, 2, 3]
      true

  This operator (which is a macro) simply translates to a call to
  `Enum.member?/2`. The example above would translate to:

      Enum.member?([1, 2, 3], x)

  Elixir also supports `left not in right`, which evaluates to
  `not(left in right)`:

      iex> x = 1
      iex> x not in [1, 2, 3]
      false

  ## Guards

  The `in/2` operator (as well as `not in`) can be used in guard clauses as
  long as the right-hand side is a range or a list. In such cases, Elixir will
  expand the operator to a valid guard expression. For example:

      when x in [1, 2, 3]

  translates to:

      when x === 1 or x === 2 or x === 3

  When using ranges:

      when x in 1..3

  translates to:

      when is_integer(x) and x >= 1 and x <= 3

  Note that only integers can be considered inside a range by `in`.

  ### AST considerations

  `left not in right` is parsed by the compiler into the AST:

      {:not, _, [{:in, _, [left, right]}]}

  This is the same AST as `not(left in right)`.

  Additionally, `Macro.to_string/2` will translate all occurrences of
  this AST to `left not in right`.

  """
  defmacro left in right do
    # body not decompiled
  end

  @doc ~S"""
  Returns true if `term` is an exception; otherwise returns `false`.

  Allowed in guard tests.

  ## Examples

      iex> is_exception(%RuntimeError{})
      true

      iex> is_exception(%{})
      false


  """
  defmacro is_exception(term) do
    # body not decompiled
  end

  @doc ~S"""
  Returns true if `term` is an exception of `name`; otherwise returns `false`.

  Allowed in guard tests.

  ## Examples

      iex> is_exception(%RuntimeError{}, RuntimeError)
      true

      iex> is_exception(%RuntimeError{}, Macro.Env)
      false


  """
  defmacro is_exception(term, name) do
    # body not decompiled
  end

  @doc ~S"""
  Returns `true` if `term` is `nil`, `false` otherwise.

  Allowed in guard clauses.

  ## Examples

      iex> is_nil(1)
      false

      iex> is_nil(nil)
      true


  """
  defmacro is_nil(term) do
    # body not decompiled
  end

  @doc ~S"""
  Returns true if `term` is a struct; otherwise returns `false`.

  Allowed in guard tests.

  ## Examples

      iex> is_struct(URI.parse("/"))
      true

      iex> is_struct(%{})
      false


  """
  defmacro is_struct(term) do
    # body not decompiled
  end

  @doc ~S"""
  Returns true if `term` is a struct of `name`; otherwise returns `false`.

  Allowed in guard tests.

  ## Examples

      iex> is_struct(URI.parse("/"), URI)
      true

      iex> is_struct(URI.parse("/"), Macro.Env)
      false


  """
  defmacro is_struct(term, name) do
    # body not decompiled
  end

  @doc ~S"""
  A convenience macro that checks if the right side (an expression) matches the
  left side (a pattern).

  ## Examples

      iex> match?(1, 1)
      true

      iex> match?({1, _}, {1, 2})
      true

      iex> map = %{a: 1, b: 2}
      iex> match?(%{a: _}, map)
      true

      iex> a = 1
      iex> match?(^a, 1)
      true

  `match?/2` is very useful when filtering or finding a value in an enumerable:

      iex> list = [a: 1, b: 2, a: 3]
      iex> Enum.filter(list, &match?({:a, _}, &1))
      [a: 1, a: 3]

  Guard clauses can also be given to the match:

      iex> list = [a: 1, b: 2, a: 3]
      iex> Enum.filter(list, &match?({:a, x} when x < 2, &1))
      [a: 1]

  However, variables assigned in the match will not be available
  outside of the function call (unlike regular pattern matching with the `=`
  operator):

      iex> match?(_x, 1)
      true
      iex> binding()
      []


  """
  defmacro match?(pattern, expr) do
    # body not decompiled
  end

  @doc ~S"""
  Strictly boolean "or" operator.

  If `left` is `true`, returns `true`; otherwise returns `right`.

  Requires only the `left` operand to be a boolean since it short-circuits.
  If the `left` operand is not a boolean, an `ArgumentError` exception is
  raised.

  Allowed in guard tests.

  ## Examples

      iex> true or false
      true

      iex> false or 42
      42

      iex> 42 or false
      ** (BadBooleanError) expected a boolean on left-side of "or", got: 42


  """
  defmacro left or right do
    # body not decompiled
  end

  @doc ~S"""
  Pops a key from the nested structure via the given `path`.

  This is similar to `pop_in/2`, except the path is extracted via
  a macro rather than passing a list. For example:

      pop_in(opts[:foo][:bar])

  Is equivalent to:

      pop_in(opts, [:foo, :bar])

  Note that in order for this macro to work, the complete path must always
  be visible by this macro. For more information about the supported path
  expressions, please check `get_and_update_in/2` docs.

  ## Examples

      iex> users = %{"john" => %{age: 27}, "meg" => %{age: 23}}
      iex> pop_in(users["john"][:age])
      {27, %{"john" => %{}, "meg" => %{age: 23}}}

      iex> users = %{john: %{age: 27}, meg: %{age: 23}}
      iex> pop_in(users.john[:age])
      {27, %{john: %{}, meg: %{age: 23}}}

  In case any entry returns `nil`, its key will be removed
  and the deletion will be considered a success.

  """
  defmacro pop_in(path) do
    # body not decompiled
  end

  @doc ~S"""
  Puts a value in a nested structure via the given `path`.

  This is similar to `put_in/3`, except the path is extracted via
  a macro rather than passing a list. For example:

      put_in(opts[:foo][:bar], :baz)

  Is equivalent to:

      put_in(opts, [:foo, :bar], :baz)

  This also works with nested structs and the `struct.path.to.value` way to specify
  paths:

      put_in(struct.foo.bar, :baz)

  Note that in order for this macro to work, the complete path must always
  be visible by this macro. For more information about the supported path
  expressions, please check `get_and_update_in/2` docs.

  ## Examples

      iex> users = %{"john" => %{age: 27}, "meg" => %{age: 23}}
      iex> put_in(users["john"][:age], 28)
      %{"john" => %{age: 28}, "meg" => %{age: 23}}

      iex> users = %{"john" => %{age: 27}, "meg" => %{age: 23}}
      iex> put_in(users["john"].age, 28)
      %{"john" => %{age: 28}, "meg" => %{age: 23}}


  """
  defmacro put_in(path, value) do
    # body not decompiled
  end

  @doc ~S"""
  Raises an exception.

  If the argument `msg` is a binary, it raises a `RuntimeError` exception
  using the given argument as message.

  If `msg` is an atom, it just calls `raise/2` with the atom as the first
  argument and `[]` as the second argument.

  If `msg` is an exception struct, it is raised as is.

  If `msg` is anything else, `raise` will fail with an `ArgumentError`
  exception.

  ## Examples

      iex> raise "oops"
      ** (RuntimeError) oops

      try do
        1 + :foo
      rescue
        x in [ArithmeticError] ->
          IO.puts("that was expected")
          raise x
      end


  """
  defmacro raise(message) do
    # body not decompiled
  end

  @doc ~S"""
  Raises an exception.

  Calls the `exception/1` function on the given argument (which has to be a
  module name like `ArgumentError` or `RuntimeError`) passing `attrs` as the
  attributes in order to retrieve the exception struct.

  Any module that contains a call to the `defexception/1` macro automatically
  implements the `c:Exception.exception/1` callback expected by `raise/2`.
  For more information, see `defexception/1`.

  ## Examples

      iex> raise(ArgumentError, "Sample")
      ** (ArgumentError) Sample


  """
  defmacro raise(exception, attributes) do
    # body not decompiled
  end

  @doc ~S"""
  Raises an exception preserving a previous stacktrace.

  Works like `raise/1` but does not generate a new stacktrace.

  Note that `__STACKTRACE__` can be used inside catch/rescue
  to retrieve the current stacktrace.

  ## Examples

      try do
        raise "oops"
      rescue
        exception ->
          reraise exception, __STACKTRACE__
      end


  """
  defmacro reraise(message, stacktrace) do
    # body not decompiled
  end

  @doc ~S"""
  Raises an exception preserving a previous stacktrace.

  `reraise/3` works like `reraise/2`, except it passes arguments to the
  `exception/1` function as explained in `raise/2`.

  ## Examples

      try do
        raise "oops"
      rescue
        exception ->
          reraise WrapperError, [exception: exception], __STACKTRACE__
      end


  """
  defmacro reraise(exception, attributes, stacktrace) do
    # body not decompiled
  end

  @doc ~S"""
  Handles the sigil `~C` for charlists.

  It returns a charlist without interpolations and without escape
  characters, except for the escaping of the closing sigil character
  itself.

  ## Examples

      iex> ~C(foo)
      'foo'

      iex> ~C(f#{o}o)
      'f\#{o}o'


  """
  defmacro sigil_C(term, modifiers) do
    # body not decompiled
  end

  @doc ~S"""
  Handles the sigil `~D` for dates.

  By default, this sigil uses the built-in `Calendar.ISO`, which
  requires dates to be written in the ISO8601 format:

      ~D[yyyy-mm-dd]

  such as:

      ~D[2015-01-13]

  If you are using alternative calendars, any representation can
  be used as long as you follow the representation by a single space
  and the calendar name:

      ~D[SOME-REPRESENTATION My.Alternative.Calendar]

  The lower case `~d` variant does not exist as interpolation
  and escape characters are not useful for date sigils.

  More information on dates can be found in the `Date` module.

  ## Examples

      iex> ~D[2015-01-13]
      ~D[2015-01-13]


  """
  defmacro sigil_D(date_string, modifiers) do
    # body not decompiled
  end

  @doc ~S"""
  Handles the sigil `~N` for naive date times.

  By default, this sigil uses the built-in `Calendar.ISO`, which
  requires naive date times to be written in the ISO8601 format:

      ~N[yyyy-mm-dd hh:mm:ss]
      ~N[yyyy-mm-dd hh:mm:ss.ssssss]
      ~N[yyyy-mm-ddThh:mm:ss.ssssss]

  such as:

      ~N[2015-01-13 13:00:07]
      ~N[2015-01-13T13:00:07.123]

  If you are using alternative calendars, any representation can
  be used as long as you follow the representation by a single space
  and the calendar name:

      ~N[SOME-REPRESENTATION My.Alternative.Calendar]

  The lower case `~n` variant does not exist as interpolation
  and escape characters are not useful for date time sigils.

  More information on naive date times can be found in the
  `NaiveDateTime` module.

  ## Examples

      iex> ~N[2015-01-13 13:00:07]
      ~N[2015-01-13 13:00:07]
      iex> ~N[2015-01-13T13:00:07.001]
      ~N[2015-01-13 13:00:07.001]


  """
  defmacro sigil_N(naive_datetime_string, modifiers) do
    # body not decompiled
  end

  @doc ~S"""
  Handles the sigil `~R` for regular expressions.

  It returns a regular expression pattern without interpolations and
  without escape characters. Note it still supports escape of Regex
  tokens (such as escaping `+` or `?`) and it also requires you to
  escape the closing sigil character itself if it appears on the Regex.

  More information on regexes can be found in the `Regex` module.

  ## Examples

      iex> Regex.match?(~R(f#{1,3}o), "f#o")
      true


  """
  defmacro sigil_R(term, modifiers) do
    # body not decompiled
  end

  @doc ~S"""
  Handles the sigil `~S` for strings.

  It returns a string without interpolations and without escape
  characters, except for the escaping of the closing sigil character
  itself.

  ## Examples

      iex> ~S(foo)
      "foo"
      iex> ~S(f#{o}o)
      "f\#{o}o"
      iex> ~S(\o/)
      "\\o/"

  However, if you want to re-use the sigil character itself on
  the string, you need to escape it:

      iex> ~S((\))
      "()"


  """
  defmacro sigil_S(term, modifiers) do
    # body not decompiled
  end

  @doc ~S"""
  Handles the sigil `~T` for times.

  By default, this sigil uses the built-in `Calendar.ISO`, which
  requires times to be written in the ISO8601 format:

      ~T[hh:mm:ss]
      ~T[hh:mm:ss.ssssss]

  such as:

      ~T[13:00:07]
      ~T[13:00:07.123]

  If you are using alternative calendars, any representation can
  be used as long as you follow the representation by a single space
  and the calendar name:

      ~T[SOME-REPRESENTATION My.Alternative.Calendar]

  The lower case `~t` variant does not exist as interpolation
  and escape characters are not useful for time sigils.

  More information on times can be found in the `Time` module.

  ## Examples

      iex> ~T[13:00:07]
      ~T[13:00:07]
      iex> ~T[13:00:07.001]
      ~T[13:00:07.001]


  """
  defmacro sigil_T(time_string, modifiers) do
    # body not decompiled
  end

  @doc ~S"""
  Handles the sigil `~U` to create a UTC `DateTime`.

  By default, this sigil uses the built-in `Calendar.ISO`, which
  requires UTC date times to be written in the ISO8601 format:

      ~U[yyyy-mm-dd hh:mm:ssZ]
      ~U[yyyy-mm-dd hh:mm:ss.ssssssZ]
      ~U[yyyy-mm-ddThh:mm:ss.ssssss+00:00]

  such as:

      ~U[2015-01-13 13:00:07Z]
      ~U[2015-01-13T13:00:07.123+00:00]

  If you are using alternative calendars, any representation can
  be used as long as you follow the representation by a single space
  and the calendar name:

      ~U[SOME-REPRESENTATION My.Alternative.Calendar]

  The given `datetime_string` must include "Z" or "00:00" offset
  which marks it as UTC, otherwise an error is raised.

  The lower case `~u` variant does not exist as interpolation
  and escape characters are not useful for date time sigils.

  More information on date times can be found in the `DateTime` module.

  ## Examples

      iex> ~U[2015-01-13 13:00:07Z]
      ~U[2015-01-13 13:00:07Z]
      iex> ~U[2015-01-13T13:00:07.001+00:00]
      ~U[2015-01-13 13:00:07.001Z]


  """
  defmacro sigil_U(datetime_string, modifiers) do
    # body not decompiled
  end

  @doc ~S"""
  Handles the sigil `~W` for list of words.

  It returns a list of "words" split by whitespace without interpolations
  and without escape characters, except for the escaping of the closing
  sigil character itself.

  ## Modifiers

    * `s`: words in the list are strings (default)
    * `a`: words in the list are atoms
    * `c`: words in the list are charlists

  ## Examples

      iex> ~W(foo #{bar} baz)
      ["foo", "\#{bar}", "baz"]


  """
  defmacro sigil_W(term, modifiers) do
    # body not decompiled
  end

  @doc ~S"""
  Handles the sigil `~c` for charlists.

  It returns a charlist as if it was a single quoted string, unescaping
  characters and replacing interpolations.

  ## Examples

      iex> ~c(foo)
      'foo'

      iex> ~c(f#{:o}o)
      'foo'

      iex> ~c(f\#{:o}o)
      'f\#{:o}o'


  """
  defmacro sigil_c(term, modifiers) do
    # body not decompiled
  end

  @doc ~S"""
  Handles the sigil `~r` for regular expressions.

  It returns a regular expression pattern, unescaping characters and replacing
  interpolations.

  More information on regular expressions can be found in the `Regex` module.

  ## Examples

      iex> Regex.match?(~r(foo), "foo")
      true

      iex> Regex.match?(~r/abc/, "abc")
      true


  """
  defmacro sigil_r(term, modifiers) do
    # body not decompiled
  end

  @doc ~S"""
  Handles the sigil `~s` for strings.

  It returns a string as if it was a double quoted string, unescaping characters
  and replacing interpolations.

  ## Examples

      iex> ~s(foo)
      "foo"

      iex> ~s(f#{:o}o)
      "foo"

      iex> ~s(f\#{:o}o)
      "f\#{:o}o"


  """
  defmacro sigil_s(term, modifiers) do
    # body not decompiled
  end

  @doc ~S"""
  Handles the sigil `~w` for list of words.

  It returns a list of "words" split by whitespace. Character unescaping and
  interpolation happens for each word.

  ## Modifiers

    * `s`: words in the list are strings (default)
    * `a`: words in the list are atoms
    * `c`: words in the list are charlists

  ## Examples

      iex> ~w(foo #{:bar} baz)
      ["foo", "bar", "baz"]

      iex> ~w(foo #{" bar baz "})
      ["foo", "bar", "baz"]

      iex> ~w(--source test/enum_test.exs)
      ["--source", "test/enum_test.exs"]

      iex> ~w(foo bar baz)a
      [:foo, :bar, :baz]


  """
  defmacro sigil_w(term, modifiers) do
    # body not decompiled
  end

  @doc false
  defmacro to_char_list(arg) do
    # body not decompiled
  end

  @doc ~S"""
  Converts the given term to a charlist according to the `List.Chars` protocol.

  ## Examples

      iex> to_charlist(:foo)
      'foo'


  """
  defmacro to_charlist(term) do
    # body not decompiled
  end

  @doc ~S"""
  Converts the argument to a string according to the
  `String.Chars` protocol.

  This is the function invoked when there is string interpolation.

  ## Examples

      iex> to_string(:foo)
      "foo"


  """
  defmacro to_string(term) do
    # body not decompiled
  end

  @doc ~S"""
  Provides an `unless` macro.

  This macro evaluates and returns the `do` block passed in as the second
  argument if `condition` evaluates to a falsy value (`false` or `nil`).
  Otherwise, it returns the value of the `else` block if present or `nil` if not.

  See also `if/2`.

  ## Examples

      iex> unless(Enum.empty?([]), do: "Hello")
      nil

      iex> unless(Enum.empty?([1, 2, 3]), do: "Hello")
      "Hello"

      iex> unless Enum.sum([2, 2]) == 5 do
      ...>   "Math still works"
      ...> else
      ...>   "Math is broken"
      ...> end
      "Math still works"


  """
  defmacro unless(condition, clauses) do
    # body not decompiled
  end

  @doc ~S"""
  Updates a nested structure via the given `path`.

  This is similar to `update_in/3`, except the path is extracted via
  a macro rather than passing a list. For example:

      update_in(opts[:foo][:bar], &(&1 + 1))

  Is equivalent to:

      update_in(opts, [:foo, :bar], &(&1 + 1))

  This also works with nested structs and the `struct.path.to.value` way to specify
  paths:

      update_in(struct.foo.bar, &(&1 + 1))

  Note that in order for this macro to work, the complete path must always
  be visible by this macro. For more information about the supported path
  expressions, please check `get_and_update_in/2` docs.

  ## Examples

      iex> users = %{"john" => %{age: 27}, "meg" => %{age: 23}}
      iex> update_in(users["john"][:age], &(&1 + 1))
      %{"john" => %{age: 28}, "meg" => %{age: 23}}

      iex> users = %{"john" => %{age: 27}, "meg" => %{age: 23}}
      iex> update_in(users["john"].age, &(&1 + 1))
      %{"john" => %{age: 28}, "meg" => %{age: 23}}


  """
  defmacro update_in(path, fun) do
    # body not decompiled
  end

  defmacro use(p0) do
    # body not decompiled
  end

  @doc ~S"""
  Uses the given module in the current context.

  When calling:

      use MyModule, some: :options

  the `__using__/1` macro from the `MyModule` module is invoked with the second
  argument passed to `use` as its argument. Since `__using__/1` is a macro, all
  the usual macro rules apply, and its return value should be quoted code
  that is then inserted where `use/2` is called.

  ## Examples

  For example, to write test cases using the `ExUnit` framework provided
  with Elixir, a developer should `use` the `ExUnit.Case` module:

      defmodule AssertionTest do
        use ExUnit.Case, async: true

        test "always pass" do
          assert true
        end
      end

  In this example, Elixir will call the `__using__/1` macro in the
  `ExUnit.Case` module with the keyword list `[async: true]` as its
  argument.

  In other words, `use/2` translates to:

      defmodule AssertionTest do
        require ExUnit.Case
        ExUnit.Case.__using__(async: true)

        test "always pass" do
          assert true
        end
      end

  where `ExUnit.Case` defines the `__using__/1` macro:

      defmodule ExUnit.Case do
        defmacro __using__(opts) do
          # do something with opts
          quote do
            # return some code to inject in the caller
          end
        end
      end

  ## Best practices

  `__using__/1` is typically used when there is a need to set some state (via
  module attributes) or callbacks (like `@before_compile`, see the documentation
  for `Module` for more information) into the caller.

  `__using__/1` may also be used to alias, require, or import functionality
  from different modules:

      defmodule MyModule do
        defmacro __using__(_opts) do
          quote do
            import MyModule.Foo
            import MyModule.Bar
            import MyModule.Baz

            alias MyModule.Repo
          end
        end
      end

  However, do not provide `__using__/1` if all it does is to import,
  alias or require the module itself. For example, avoid this:

      defmodule MyModule do
        defmacro __using__(_opts) do
          quote do
            import MyModule
          end
        end
      end

  In such cases, developers should instead import or alias the module
  directly, so that they can customize those as they wish,
  without the indirection behind `use/2`.

  Finally, developers should also avoid defining functions inside
  the `__using__/1` callback, unless those functions are the default
  implementation of a previously defined `@callback` or are functions
  meant to be overridden (see `defoverridable/1`). Even in these cases,
  defining functions should be seen as a "last resort".

  In case you want to provide some existing functionality to the user module,
  please define it in a module which will be imported accordingly; for example,
  `ExUnit.Case` doesn't define the `test/3` macro in the module that calls
  `use ExUnit.Case`, but it defines `ExUnit.Case.test/3` and just imports that
  into the caller when used.

  """
  defmacro use(module, opts \\ []) do
    # body not decompiled
  end

  defmacro var!(p0) do
    # body not decompiled
  end

  @doc ~S"""
  Marks that the given variable should not be hygienized.

  This macro expects a variable and it is typically invoked
  inside `Kernel.SpecialForms.quote/2` to mark that a variable
  should not be hygienized. See `Kernel.SpecialForms.quote/2`
  for more information.

  ## Examples

      iex> Kernel.var!(example) = 1
      1
      iex> Kernel.var!(example)
      1


  """
  defmacro var!(var, context \\ nil) do
    # body not decompiled
  end

  @doc ~S"""
  Pipe operator.

  This operator introduces the expression on the left-hand side as
  the first argument to the function call on the right-hand side.

  ## Examples

      iex> [1, [2], 3] |> List.flatten()
      [1, 2, 3]

  The example above is the same as calling `List.flatten([1, [2], 3])`.

  The `|>` operator is mostly useful when there is a desire to execute a series
  of operations resembling a pipeline:

      iex> [1, [2], 3] |> List.flatten() |> Enum.map(fn x -> x * 2 end)
      [2, 4, 6]

  In the example above, the list `[1, [2], 3]` is passed as the first argument
  to the `List.flatten/1` function, then the flattened list is passed as the
  first argument to the `Enum.map/2` function which doubles each element of the
  list.

  In other words, the expression above simply translates to:

      Enum.map(List.flatten([1, [2], 3]), fn x -> x * 2 end)

  ## Pitfalls

  There are two common pitfalls when using the pipe operator.

  The first one is related to operator precedence. For example,
  the following expression:

      String.graphemes "Hello" |> Enum.reverse

  Translates to:

      String.graphemes("Hello" |> Enum.reverse())

  which results in an error as the `Enumerable` protocol is not defined
  for binaries. Adding explicit parentheses resolves the ambiguity:

      String.graphemes("Hello") |> Enum.reverse()

  Or, even better:

      "Hello" |> String.graphemes() |> Enum.reverse()

  The second pitfall is that the `|>` operator works on calls.
  For example, when you write:

      "Hello" |> some_function()

  Elixir sees the right-hand side is a function call and pipes
  to it. This means that, if you want to pipe to an anonymous
  or captured function, it must also be explicitly called.

  Given the anonymous function:

      fun = fn x -> IO.puts(x) end
      fun.("Hello")

  This won't work as it will rather try to invoke the local
  function `fun`:

      "Hello" |> fun()

  This works:

      "Hello" |> fun.()

  As you can see, the `|>` operator retains the same semantics
  as when the pipe is not used since both require the `fun.(...)`
  notation.

  """
  defmacro left |> right do
    # body not decompiled
  end

  @doc ~S"""
  Boolean "or" operator.

  Provides a short-circuit operator that evaluates and returns the second
  expression only if the first one does not evaluate to a truthy value (that is,
  it is either `nil` or `false`). Returns the first expression otherwise.

  Not allowed in guard clauses.

  ## Examples

      iex> Enum.empty?([1]) || Enum.empty?([1])
      false

      iex> List.first([]) || true
      true

      iex> Enum.empty?([1]) || 1
      1

      iex> Enum.empty?([]) || throw(:bad)
      true

  Note that, unlike `or/2`, this operator accepts any expression
  as the first argument, not only booleans.

  """
  defmacro left || right do
    # body not decompiled
  end

  # Functions

  @doc ~S"""
  Not equal to operator.

  Returns `true` if the two terms are not equal.

  This operator considers 1 and 1.0 to be equal. For match
  comparison, use `!==/2` instead.

  All terms in Elixir can be compared with each other.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> 1 != 2
      true

      iex> 1 != 1.0
      false


  """
  def left != right do
    # body not decompiled
  end

  @doc ~S"""
  Strictly not equal to operator.

  Returns `true` if the two terms are not exactly equal.
  See `===/2` for a definition of what is considered "exactly equal".

  All terms in Elixir can be compared with each other.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> 1 !== 2
      true

      iex> 1 !== 1.0
      true


  """
  def left !== right do
    # body not decompiled
  end

  @doc ~S"""
  Arithmetic multiplication operator.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> 1 * 2
      2


  """
  def left * right do
    # body not decompiled
  end

  @doc ~S"""
  Arithmetic positive unary operator.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> +1
      1


  """
  def (+value) do
    # body not decompiled
  end

  @doc ~S"""
  Arithmetic addition operator.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> 1 + 2
      3


  """
  def left + right do
    # body not decompiled
  end

  @doc ~S"""
  List concatenation operator. Concatenates a proper list and a term, returning a list.

  The complexity of `a ++ b` is proportional to `length(a)`, so avoid repeatedly
  appending to lists of arbitrary length, for example, `list ++ [element]`.
  Instead, consider prepending via `[element | rest]` and then reversing.

  If the `right` operand is not a proper list, it returns an improper list.
  If the `left` operand is not a proper list, it raises `ArgumentError`.

  Inlined by the compiler.

  ## Examples

      iex> [1] ++ [2, 3]
      [1, 2, 3]

      iex> 'foo' ++ 'bar'
      'foobar'

      # returns an improper list
      iex> [1] ++ 2
      [1 | 2]

      # returns a proper list
      iex> [1] ++ [2]
      [1, 2]

      # improper list on the right will return an improper list
      iex> [1] ++ [2 | 3]
      [1, 2 | 3]


  """
  def left ++ right do
    # body not decompiled
  end

  @doc ~S"""
  Arithmetic negative unary operator.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> -2
      -2


  """
  def (-value) do
    # body not decompiled
  end

  @doc ~S"""
  Arithmetic subtraction operator.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> 1 - 2
      -1


  """
  def left - right do
    # body not decompiled
  end

  @doc ~S"""
  List subtraction operator. Removes the first occurrence of an element on the left list
  for each element on the right.

  Before Erlang/OTP 22, the complexity of `a -- b` was proportional to
  `length(a) * length(b)`, meaning that it would be very slow if
  both `a` and `b` were long lists. In such cases, consider
  converting each list to a `MapSet` and using `MapSet.difference/2`.

  As of Erlang/OTP 22, this operation is significantly faster even if both
  lists are very long, and using `--/2` is usually faster and uses less
  memory than using the `MapSet`-based alternative mentioned above.
  See also the [Erlang efficiency
  guide](https://erlang.org/doc/efficiency_guide/retired_myths.html).

  Inlined by the compiler.

  ## Examples

      iex> [1, 2, 3] -- [1, 2]
      [3]

      iex> [1, 2, 3, 2, 1] -- [1, 2, 2]
      [3, 1]

  The `--/2` operator is right associative, meaning:

      iex> [1, 2, 3] -- [2] -- [3]
      [1, 3]

  As it is equivalent to:

      iex> [1, 2, 3] -- ([2] -- [3])
      [1, 3]


  """
  def left -- right do
    # body not decompiled
  end

  @doc ~S"""
  Arithmetic division operator.

  The result is always a float. Use `div/2` and `rem/2` if you want
  an integer division or the remainder.

  Raises `ArithmeticError` if `right` is 0 or 0.0.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      1 / 2
      #=> 0.5

      -3.0 / 2.0
      #=> -1.5

      5 / 1
      #=> 5.0

      7 / 0
      ** (ArithmeticError) bad argument in arithmetic expression


  """
  def left / right do
    # body not decompiled
  end

  @doc ~S"""
  Less-than operator.

  Returns `true` if `left` is less than `right`.

  All terms in Elixir can be compared with each other.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> 1 < 2
      true


  """
  def left < right do
    # body not decompiled
  end

  @doc ~S"""
  Less-than or equal to operator.

  Returns `true` if `left` is less than or equal to `right`.

  All terms in Elixir can be compared with each other.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> 1 <= 2
      true


  """
  def left <= right do
    # body not decompiled
  end

  @doc ~S"""
  Equal to operator. Returns `true` if the two terms are equal.

  This operator considers 1 and 1.0 to be equal. For stricter
  semantics, use `===/2` instead.

  All terms in Elixir can be compared with each other.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> 1 == 2
      false

      iex> 1 == 1.0
      true


  """
  def left == right do
    # body not decompiled
  end

  @doc ~S"""
  Strictly equal to operator.

  Returns `true` if the two terms are exactly equal.

  The terms are only considered to be exactly equal if they
  have the same value and are of the same type. For example,
  `1 == 1.0` returns `true`, but since they are of different
  types, `1 === 1.0` returns `false`.

  All terms in Elixir can be compared with each other.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> 1 === 2
      false

      iex> 1 === 1.0
      false


  """
  def left === right do
    # body not decompiled
  end

  @doc ~S"""
  Text-based match operator. Matches the term on the `left`
  against the regular expression or string on the `right`.

  If `right` is a regular expression, returns `true` if `left` matches right.

  If `right` is a string, returns `true` if `left` contains `right`.

  ## Examples

      iex> "abcd" =~ ~r/c(d)/
      true

      iex> "abcd" =~ ~r/e/
      false

      iex> "abcd" =~ ~r//
      true

      iex> "abcd" =~ "bc"
      true

      iex> "abcd" =~ "ad"
      false

      iex> "abcd" =~ "abcd"
      true

      iex> "abcd" =~ ""
      true


  """
  def left =~ right do
    # body not decompiled
  end

  @doc ~S"""
  Greater-than operator.

  Returns `true` if `left` is more than `right`.

  All terms in Elixir can be compared with each other.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> 1 > 2
      false


  """
  def left > right do
    # body not decompiled
  end

  @doc ~S"""
  Greater-than or equal to operator.

  Returns `true` if `left` is more than or equal to `right`.

  All terms in Elixir can be compared with each other.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> 1 >= 2
      false


  """
  def left >= right do
    # body not decompiled
  end

  def __info__(p0) do
    # body not decompiled
  end

  @doc ~S"""
  Returns an integer or float which is the arithmetical absolute value of `number`.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> abs(-3.33)
      3.33

      iex> abs(-3)
      3


  """
  def abs(number) do
    # body not decompiled
  end

  @doc ~S"""
  Invokes the given anonymous function `fun` with the list of
  arguments `args`.

  Inlined by the compiler.

  ## Examples

      iex> apply(fn x -> x * 2 end, [2])
      4


  """
  def apply(fun, args) do
    # body not decompiled
  end

  @doc ~S"""
  Invokes the given function from `module` with the list of
  arguments `args`.

  `apply/3` is used to invoke functions where the module, function
  name or arguments are defined dynamically at runtime. For this
  reason, you can't invoke macros using `apply/3`, only functions.

  Inlined by the compiler.

  ## Examples

      iex> apply(Enum, :reverse, [[1, 2, 3]])
      [3, 2, 1]


  """
  def apply(module, function_name, args) do
    # body not decompiled
  end

  @doc ~S"""
  Extracts the part of the binary starting at `start` with length `length`.
  Binaries are zero-indexed.

  If `start` or `length` reference in any way outside the binary, an
  `ArgumentError` exception is raised.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> binary_part("foo", 1, 2)
      "oo"

  A negative `length` can be used to extract bytes that come *before* the byte
  at `start`:

      iex> binary_part("Hello", 5, -3)
      "llo"


  """
  def binary_part(binary, start, length) do
    # body not decompiled
  end

  @doc ~S"""
  Returns an integer which is the size in bits of `bitstring`.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> bit_size(<<433::16, 3::3>>)
      19

      iex> bit_size(<<1, 2, 3>>)
      24


  """
  def bit_size(bitstring) do
    # body not decompiled
  end

  @doc ~S"""
  Returns the number of bytes needed to contain `bitstring`.

  That is, if the number of bits in `bitstring` is not divisible by 8, the
  resulting number of bytes will be rounded up (by excess). This operation
  happens in constant time.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> byte_size(<<433::16, 3::3>>)
      3

      iex> byte_size(<<1, 2, 3>>)
      3


  """
  def byte_size(bitstring) do
    # body not decompiled
  end

  @doc ~S"""
  Returns the smallest integer greater than or equal to `number`.

  If you want to perform ceil operation on other decimal places,
  use `Float.ceil/2` instead.

  Allowed in guard tests. Inlined by the compiler.

  """
  def ceil(number) do
    # body not decompiled
  end

  @doc ~S"""
  Performs an integer division.

  Raises an `ArithmeticError` exception if one of the arguments is not an
  integer, or when the `divisor` is `0`.

  `div/2` performs *truncated* integer division. This means that
  the result is always rounded towards zero.

  If you want to perform floored integer division (rounding towards negative infinity),
  use `Integer.floor_div/2` instead.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      div(5, 2)
      #=> 2

      div(6, -4)
      #=> -1

      div(-99, 2)
      #=> -49

      div(100, 0)
      ** (ArithmeticError) bad argument in arithmetic expression


  """
  def div(dividend, divisor) do
    # body not decompiled
  end

  @doc ~S"""
  Gets the element at the zero-based `index` in `tuple`.

  It raises `ArgumentError` when index is negative or it is out of range of the tuple elements.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      tuple = {:foo, :bar, 3}
      elem(tuple, 1)
      #=> :bar

      elem({}, 0)
      ** (ArgumentError) argument error

      elem({:foo, :bar}, 2)
      ** (ArgumentError) argument error


  """
  def elem(tuple, index) do
    # body not decompiled
  end

  @doc ~S"""
  Stops the execution of the calling process with the given reason.

  Since evaluating this function causes the process to terminate,
  it has no return value.

  Inlined by the compiler.

  ## Examples

  When a process reaches its end, by default it exits with
  reason `:normal`. You can also call `exit/1` explicitly if you
  want to terminate a process but not signal any failure:

      exit(:normal)

  In case something goes wrong, you can also use `exit/1` with
  a different reason:

      exit(:seems_bad)

  If the exit reason is not `:normal`, all the processes linked to the process
  that exited will crash (unless they are trapping exits).

  ## OTP exits

  Exits are used by the OTP to determine if a process exited abnormally
  or not. The following exits are considered "normal":

    * `exit(:normal)`
    * `exit(:shutdown)`
    * `exit({:shutdown, term})`

  Exiting with any other reason is considered abnormal and treated
  as a crash. This means the default supervisor behaviour kicks in,
  error reports are emitted, and so forth.

  This behaviour is relied on in many different places. For example,
  `ExUnit` uses `exit(:shutdown)` when exiting the test process to
  signal linked processes, supervision trees and so on to politely
  shut down too.

  ## CLI exits

  Building on top of the exit signals mentioned above, if the
  process started by the command line exits with any of the three
  reasons above, its exit is considered normal and the Operating
  System process will exit with status 0.

  It is, however, possible to customize the operating system exit
  signal by invoking:

      exit({:shutdown, integer})

  This will cause the operating system process to exit with the status given by
  `integer` while signaling all linked Erlang processes to politely
  shut down.

  Any other exit reason will cause the operating system process to exit with
  status `1` and linked Erlang processes to crash.

  """
  def exit(reason) do
    # body not decompiled
  end

  @doc ~S"""
  Returns the largest integer smaller than or equal to `number`.

  If you want to perform floor operation on other decimal places,
  use `Float.floor/2` instead.

  Allowed in guard tests. Inlined by the compiler.

  """
  def floor(number) do
    # body not decompiled
  end

  @doc ~S"""
  Returns `true` if `module` is loaded and contains a
  public `function` with the given `arity`, otherwise `false`.

  Note that this function does not load the module in case
  it is not loaded. Check `Code.ensure_loaded/1` for more
  information.

  Inlined by the compiler.

  ## Examples

      iex> function_exported?(Enum, :map, 2)
      true

      iex> function_exported?(Enum, :map, 10)
      false

      iex> function_exported?(List, :to_string, 1)
      true

  """
  def function_exported?(module, function, arity) do
    # body not decompiled
  end

  @doc ~S"""
  Gets a value and updates a nested structure.

  `data` is a nested structure (that is, a map, keyword
  list, or struct that implements the `Access` behaviour).

  The `fun` argument receives the value of `key` (or `nil` if `key`
  is not present) and must return one of the following values:

    * a two-element tuple `{get_value, new_value}`. In this case,
      `get_value` is the retrieved value which can possibly be operated on before
      being returned. `new_value` is the new value to be stored under `key`.

    * `:pop`, which implies that the current value under `key`
      should be removed from the structure and returned.

  This function uses the `Access` module to traverse the structures
  according to the given `keys`, unless the `key` is a function,
  which is detailed in a later section.

  ## Examples

  This function is useful when there is a need to retrieve the current
  value (or something calculated in function of the current value) and
  update it at the same time. For example, it could be used to read the
  current age of a user while increasing it by one in one pass:

      iex> users = %{"john" => %{age: 27}, "meg" => %{age: 23}}
      iex> get_and_update_in(users, ["john", :age], &{&1, &1 + 1})
      {27, %{"john" => %{age: 28}, "meg" => %{age: 23}}}

  ## Functions as keys

  If a key is a function, the function will be invoked passing three
  arguments:

    * the operation (`:get_and_update`)
    * the data to be accessed
    * a function to be invoked next

  This means `get_and_update_in/3` can be extended to provide custom
  lookups. The downside is that functions cannot be stored as keys
  in the accessed data structures.

  When one of the keys is a function, the function is invoked.
  In the example below, we use a function to get and increment all
  ages inside a list:

      iex> users = [%{name: "john", age: 27}, %{name: "meg", age: 23}]
      iex> all = fn :get_and_update, data, next ->
      ...>   data |> Enum.map(next) |> Enum.unzip()
      ...> end
      iex> get_and_update_in(users, [all, :age], &{&1, &1 + 1})
      {[27, 23], [%{name: "john", age: 28}, %{name: "meg", age: 24}]}

  If the previous value before invoking the function is `nil`,
  the function *will* receive `nil` as a value and must handle it
  accordingly (be it by failing or providing a sane default).

  The `Access` module ships with many convenience accessor functions,
  like the `all` anonymous function defined above. See `Access.all/0`,
  `Access.key/2`, and others as examples.

  """
  def get_and_update_in(data, keys, fun) do
    # body not decompiled
  end

  @doc ~S"""
  Gets a value from a nested structure.

  Uses the `Access` module to traverse the structures
  according to the given `keys`, unless the `key` is a
  function, which is detailed in a later section.

  ## Examples

      iex> users = %{"john" => %{age: 27}, "meg" => %{age: 23}}
      iex> get_in(users, ["john", :age])
      27

  In case any of the keys returns `nil`, `nil` will be returned:

      iex> users = %{"john" => %{age: 27}, "meg" => %{age: 23}}
      iex> get_in(users, ["unknown", :age])
      nil

  ## Functions as keys

  If a key is a function, the function will be invoked passing three
  arguments:

    * the operation (`:get`)
    * the data to be accessed
    * a function to be invoked next

  This means `get_in/2` can be extended to provide custom lookups.
  In the example below, we use a function to get all the maps inside
  a list:

      iex> users = [%{name: "john", age: 27}, %{name: "meg", age: 23}]
      iex> all = fn :get, data, next -> Enum.map(data, next) end
      iex> get_in(users, [all, :age])
      [27, 23]

  If the previous value before invoking the function is `nil`,
  the function *will* receive `nil` as a value and must handle it
  accordingly.

  The `Access` module ships with many convenience accessor functions,
  like the `all` anonymous function defined above. See `Access.all/0`,
  `Access.key/2`, and others as examples.

  """
  def get_in(data, keys) do
    # body not decompiled
  end

  @doc ~S"""
  Returns the head of a list. Raises `ArgumentError` if the list is empty.

  It works with improper lists.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      hd([1, 2, 3, 4])
      #=> 1

      hd([])
      ** (ArgumentError) argument error

      hd([1 | 2])
      #=> 1


  """
  def hd(list) do
    # body not decompiled
  end

  def inspect(p0) do
    # body not decompiled
  end

  @doc ~S"""
  Inspects the given argument according to the `Inspect` protocol.
  The second argument is a keyword list with options to control
  inspection.

  ## Options

  `inspect/2` accepts a list of options that are internally
  translated to an `Inspect.Opts` struct. Check the docs for
  `Inspect.Opts` to see the supported options.

  ## Examples

      iex> inspect(:foo)
      ":foo"

      iex> inspect([1, 2, 3, 4, 5], limit: 3)
      "[1, 2, 3, ...]"

      iex> inspect([1, 2, 3], pretty: true, width: 0)
      "[1,\n 2,\n 3]"

      iex> inspect("olá" <> <<0>>)
      "<<111, 108, 195, 161, 0>>"

      iex> inspect("olá" <> <<0>>, binaries: :as_strings)
      "\"olá\\0\""

      iex> inspect("olá", binaries: :as_binaries)
      "<<111, 108, 195, 161>>"

      iex> inspect('bar')
      "'bar'"

      iex> inspect([0 | 'bar'])
      "[0, 98, 97, 114]"

      iex> inspect(100, base: :octal)
      "0o144"

      iex> inspect(100, base: :hex)
      "0x64"

  Note that the `Inspect` protocol does not necessarily return a valid
  representation of an Elixir term. In such cases, the inspected result
  must start with `#`. For example, inspecting a function will return:

      inspect(fn a, b -> a + b end)
      #=> #Function<...>

  The `Inspect` protocol can be derived to hide certain fields
  from structs, so they don't show up in logs, inspects and similar.
  See the "Deriving" section of the documentation of the `Inspect`
  protocol for more information.

  """
  def inspect(term, opts \\ []) do
    # body not decompiled
  end

  @doc ~S"""
  Returns `true` if `term` is an atom; otherwise returns `false`.

  Allowed in guard tests. Inlined by the compiler.

  """
  def is_atom(term) do
    # body not decompiled
  end

  @doc ~S"""
  Returns `true` if `term` is a binary; otherwise returns `false`.

  A binary always contains a complete number of bytes.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> is_binary("foo")
      true
      iex> is_binary(<<1::3>>)
      false


  """
  def is_binary(term) do
    # body not decompiled
  end

  @doc ~S"""
  Returns `true` if `term` is a bitstring (including a binary); otherwise returns `false`.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> is_bitstring("foo")
      true
      iex> is_bitstring(<<1::3>>)
      true


  """
  def is_bitstring(term) do
    # body not decompiled
  end

  @doc ~S"""
  Returns `true` if `term` is either the atom `true` or the atom `false` (i.e.,
  a boolean); otherwise returns `false`.

  Allowed in guard tests. Inlined by the compiler.

  """
  def is_boolean(term) do
    # body not decompiled
  end

  @doc ~S"""
  Returns `true` if `term` is a floating-point number; otherwise returns `false`.

  Allowed in guard tests. Inlined by the compiler.

  """
  def is_float(term) do
    # body not decompiled
  end

  @doc ~S"""
  Returns `true` if `term` is a function; otherwise returns `false`.

  Allowed in guard tests. Inlined by the compiler.

  """
  def is_function(term) do
    # body not decompiled
  end

  @doc ~S"""
  Returns `true` if `term` is a function that can be applied with `arity` number of arguments;
  otherwise returns `false`.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> is_function(fn x -> x * 2 end, 1)
      true
      iex> is_function(fn x -> x * 2 end, 2)
      false


  """
  def is_function(term, arity) do
    # body not decompiled
  end

  @doc ~S"""
  Returns `true` if `term` is an integer; otherwise returns `false`.

  Allowed in guard tests. Inlined by the compiler.

  """
  def is_integer(term) do
    # body not decompiled
  end

  @doc ~S"""
  Returns `true` if `term` is a list with zero or more elements; otherwise returns `false`.

  Allowed in guard tests. Inlined by the compiler.

  """
  def is_list(term) do
    # body not decompiled
  end

  @doc ~S"""
  Returns `true` if `term` is a map; otherwise returns `false`.

  Allowed in guard tests. Inlined by the compiler.

  """
  def is_map(term) do
    # body not decompiled
  end

  @doc ~S"""
  Returns `true` if `key` is a key in `map`; otherwise returns `false`.

  It raises `BadMapError` if the first element is not a map.

  Allowed in guard tests. Inlined by the compiler.

  """
  def is_map_key(map, key) do
    # body not decompiled
  end

  @doc ~S"""
  Returns `true` if `term` is either an integer or a floating-point number;
  otherwise returns `false`.

  Allowed in guard tests. Inlined by the compiler.

  """
  def is_number(term) do
    # body not decompiled
  end

  @doc ~S"""
  Returns `true` if `term` is a PID (process identifier); otherwise returns `false`.

  Allowed in guard tests. Inlined by the compiler.

  """
  def is_pid(term) do
    # body not decompiled
  end

  @doc ~S"""
  Returns `true` if `term` is a port identifier; otherwise returns `false`.

  Allowed in guard tests. Inlined by the compiler.

  """
  def is_port(term) do
    # body not decompiled
  end

  @doc ~S"""
  Returns `true` if `term` is a reference; otherwise returns `false`.

  Allowed in guard tests. Inlined by the compiler.

  """
  def is_reference(term) do
    # body not decompiled
  end

  @doc ~S"""
  Returns `true` if `term` is a tuple; otherwise returns `false`.

  Allowed in guard tests. Inlined by the compiler.

  """
  def is_tuple(term) do
    # body not decompiled
  end

  @doc ~S"""
  Returns the length of `list`.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> length([1, 2, 3, 4, 5, 6, 7, 8, 9])
      9


  """
  def length(list) do
    # body not decompiled
  end

  @doc ~S"""
  Returns `true` if `module` is loaded and contains a
  public `macro` with the given `arity`, otherwise `false`.

  Note that this function does not load the module in case
  it is not loaded. Check `Code.ensure_loaded/1` for more
  information.

  If `module` is an Erlang module (as opposed to an Elixir module), this
  function always returns `false`.

  ## Examples

      iex> macro_exported?(Kernel, :use, 2)
      true

      iex> macro_exported?(:erlang, :abs, 1)
      false


  """
  def macro_exported?(module, macro, arity) do
    # body not decompiled
  end

  @doc ~S"""
  Returns an almost unique reference.

  The returned reference will re-occur after approximately 2^82 calls;
  therefore it is unique enough for practical purposes.

  Inlined by the compiler.

  ## Examples

      make_ref()
      #=> #Reference<0.0.0.135>


  """
  def make_ref() do
    # body not decompiled
  end

  @doc ~S"""
  Returns the size of a map.

  The size of a map is the number of key-value pairs that the map contains.

  This operation happens in constant time.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> map_size(%{a: "foo", b: "bar"})
      2


  """
  def map_size(map) do
    # body not decompiled
  end

  @doc ~S"""
  Returns the biggest of the two given terms according to
  Erlang's term ordering.

  If the terms compare equal, the first one is returned.

  Inlined by the compiler.

  ## Examples

      iex> max(1, 2)
      2
      iex> max(:a, :b)
      :b

  Using Erlang's term ordering means that comparisons are
  structural and not semantic. For example, when comparing dates:

      iex> max(~D[2017-03-31], ~D[2017-04-01])
      ~D[2017-03-31]

  In the example above, `max/2` returned March 31st instead of April 1st
  because the structural comparison compares the day before the year. In
  such cases it is common for modules to provide functions such as
  `Date.compare/2` that perform semantic comparison.

  """
  def max(first, second) do
    # body not decompiled
  end

  @doc ~S"""
  Returns the smallest of the two given terms according to
  Erlang's term ordering.

  If the terms compare equal, the first one is returned.

  Inlined by the compiler.

  ## Examples

      iex> min(1, 2)
      1
      iex> min("foo", "bar")
      "bar"

  Using Erlang's term ordering means that comparisons are
  structural and not semantic. For example, when comparing dates:

      iex> min(~D[2017-03-31], ~D[2017-04-01])
      ~D[2017-04-01]

  In the example above, `min/2` returned April 1st instead of March 31st
  because the structural comparison compares the day before the year. In
  such cases it is common for modules to provide functions such as
  `Date.compare/2` that perform semantic comparison.

  """
  def min(first, second) do
    # body not decompiled
  end

  def module_info() do
    # body not decompiled
  end

  def module_info(p0) do
    # body not decompiled
  end

  @doc ~S"""
  Returns an atom representing the name of the local node.
  If the node is not alive, `:nonode@nohost` is returned instead.

  Allowed in guard tests. Inlined by the compiler.

  """
  def node() do
    # body not decompiled
  end

  @doc ~S"""
  Returns the node where the given argument is located.
  The argument can be a PID, a reference, or a port.
  If the local node is not alive, `:nonode@nohost` is returned.

  Allowed in guard tests. Inlined by the compiler.

  """
  def node(arg) do
    # body not decompiled
  end

  @doc ~S"""
  Strictly boolean "not" operator.

  `value` must be a boolean; if it's not, an `ArgumentError` exception is raised.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> not false
      true


  """
  def not(value) do
    # body not decompiled
  end

  @doc ~S"""
  Pops a key from the given nested structure.

  Uses the `Access` protocol to traverse the structures
  according to the given `keys`, unless the `key` is a
  function. If the key is a function, it will be invoked
  as specified in `get_and_update_in/3`.

  ## Examples

      iex> users = %{"john" => %{age: 27}, "meg" => %{age: 23}}
      iex> pop_in(users, ["john", :age])
      {27, %{"john" => %{}, "meg" => %{age: 23}}}

  In case any entry returns `nil`, its key will be removed
  and the deletion will be considered a success.

      iex> users = %{"john" => %{age: 27}, "meg" => %{age: 23}}
      iex> pop_in(users, ["jane", :age])
      {nil, %{"john" => %{age: 27}, "meg" => %{age: 23}}}


  """
  def pop_in(data, keys) do
    # body not decompiled
  end

  @doc ~S"""
  Puts `value` at the given zero-based `index` in `tuple`.

  Inlined by the compiler.

  ## Examples

      iex> tuple = {:foo, :bar, 3}
      iex> put_elem(tuple, 0, :baz)
      {:baz, :bar, 3}


  """
  def put_elem(tuple, index, value) do
    # body not decompiled
  end

  @doc ~S"""
  Puts a value in a nested structure.

  Uses the `Access` module to traverse the structures
  according to the given `keys`, unless the `key` is a
  function. If the key is a function, it will be invoked
  as specified in `get_and_update_in/3`.

  ## Examples

      iex> users = %{"john" => %{age: 27}, "meg" => %{age: 23}}
      iex> put_in(users, ["john", :age], 28)
      %{"john" => %{age: 28}, "meg" => %{age: 23}}

  In case any of the entries in the middle returns `nil`,
  an error will be raised when trying to access it next.

  """
  def put_in(data, keys, value) do
    # body not decompiled
  end

  @doc ~S"""
  Computes the remainder of an integer division.

  `rem/2` uses truncated division, which means that
  the result will always have the sign of the `dividend`.

  Raises an `ArithmeticError` exception if one of the arguments is not an
  integer, or when the `divisor` is `0`.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> rem(5, 2)
      1
      iex> rem(6, -4)
      2


  """
  def rem(dividend, divisor) do
    # body not decompiled
  end

  @doc ~S"""
  Rounds a number to the nearest integer.

  If the number is equidistant to the two nearest integers, rounds away from zero.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> round(5.6)
      6

      iex> round(5.2)
      5

      iex> round(-9.9)
      -10

      iex> round(-9)
      -9

      iex> round(2.5)
      3

      iex> round(-2.5)
      -3


  """
  def round(number) do
    # body not decompiled
  end

  @doc ~S"""
  Returns the PID (process identifier) of the calling process.

  Allowed in guard clauses. Inlined by the compiler.

  """
  def self() do
    # body not decompiled
  end

  @doc ~S"""
  Sends a message to the given `dest` and returns the message.

  `dest` may be a remote or local PID, a local port, a locally
  registered name, or a tuple in the form of `{registered_name, node}` for a
  registered name at another node.

  Inlined by the compiler.

  ## Examples

      iex> send(self(), :hello)
      :hello


  """
  def send(dest, message) do
    # body not decompiled
  end

  @doc ~S"""
  Spawns the given function and returns its PID.

  Typically developers do not use the `spawn` functions, instead they use
  abstractions such as `Task`, `GenServer` and `Agent`, built on top of
  `spawn`, that spawns processes with more conveniences in terms of
  introspection and debugging.

  Check the `Process` module for more process-related functions.

  The anonymous function receives 0 arguments, and may return any value.

  Inlined by the compiler.

  ## Examples

      current = self()
      child = spawn(fn -> send(current, {self(), 1 + 2}) end)

      receive do
        {^child, 3} -> IO.puts("Received 3 back")
      end


  """
  def spawn(fun) do
    # body not decompiled
  end

  @doc ~S"""
  Spawns the given function `fun` from the given `module` passing it the given
  `args` and returns its PID.

  Typically developers do not use the `spawn` functions, instead they use
  abstractions such as `Task`, `GenServer` and `Agent`, built on top of
  `spawn`, that spawns processes with more conveniences in terms of
  introspection and debugging.

  Check the `Process` module for more process-related functions.

  Inlined by the compiler.

  ## Examples

      spawn(SomeModule, :function, [1, 2, 3])


  """
  def spawn(module, fun, args) do
    # body not decompiled
  end

  @doc ~S"""
  Spawns the given function, links it to the current process, and returns its PID.

  Typically developers do not use the `spawn` functions, instead they use
  abstractions such as `Task`, `GenServer` and `Agent`, built on top of
  `spawn`, that spawns processes with more conveniences in terms of
  introspection and debugging.

  Check the `Process` module for more process-related functions. For more
  information on linking, check `Process.link/1`.

  The anonymous function receives 0 arguments, and may return any value.

  Inlined by the compiler.

  ## Examples

      current = self()
      child = spawn_link(fn -> send(current, {self(), 1 + 2}) end)

      receive do
        {^child, 3} -> IO.puts("Received 3 back")
      end


  """
  def spawn_link(fun) do
    # body not decompiled
  end

  @doc ~S"""
  Spawns the given function `fun` from the given `module` passing it the given
  `args`, links it to the current process, and returns its PID.

  Typically developers do not use the `spawn` functions, instead they use
  abstractions such as `Task`, `GenServer` and `Agent`, built on top of
  `spawn`, that spawns processes with more conveniences in terms of
  introspection and debugging.

  Check the `Process` module for more process-related functions. For more
  information on linking, check `Process.link/1`.

  Inlined by the compiler.

  ## Examples

      spawn_link(SomeModule, :function, [1, 2, 3])


  """
  def spawn_link(module, fun, args) do
    # body not decompiled
  end

  @doc ~S"""
  Spawns the given function, monitors it and returns its PID
  and monitoring reference.

  Typically developers do not use the `spawn` functions, instead they use
  abstractions such as `Task`, `GenServer` and `Agent`, built on top of
  `spawn`, that spawns processes with more conveniences in terms of
  introspection and debugging.

  Check the `Process` module for more process-related functions.

  The anonymous function receives 0 arguments, and may return any value.

  Inlined by the compiler.

  ## Examples

      current = self()
      spawn_monitor(fn -> send(current, {self(), 1 + 2}) end)


  """
  def spawn_monitor(fun) do
    # body not decompiled
  end

  @doc ~S"""
  Spawns the given module and function passing the given args,
  monitors it and returns its PID and monitoring reference.

  Typically developers do not use the `spawn` functions, instead they use
  abstractions such as `Task`, `GenServer` and `Agent`, built on top of
  `spawn`, that spawns processes with more conveniences in terms of
  introspection and debugging.

  Check the `Process` module for more process-related functions.

  Inlined by the compiler.

  ## Examples

      spawn_monitor(SomeModule, :function, [1, 2, 3])


  """
  def spawn_monitor(module, fun, args) do
    # body not decompiled
  end

  def struct(p0) do
    # body not decompiled
  end

  @doc ~S"""
  Creates and updates a struct.

  The `struct` argument may be an atom (which defines `defstruct`)
  or a `struct` itself. The second argument is any `Enumerable` that
  emits two-element tuples (key-value pairs) during enumeration.

  Keys in the `Enumerable` that don't exist in the struct are automatically
  discarded. Note that keys must be atoms, as only atoms are allowed when
  defining a struct. If keys in the `Enumerable` are duplicated, the last
  entry will be taken (same behaviour as `Map.new/1`).

  This function is useful for dynamically creating and updating structs, as
  well as for converting maps to structs; in the latter case, just inserting
  the appropriate `:__struct__` field into the map may not be enough and
  `struct/2` should be used instead.

  ## Examples

      defmodule User do
        defstruct name: "john"
      end

      struct(User)
      #=> %User{name: "john"}

      opts = [name: "meg"]
      user = struct(User, opts)
      #=> %User{name: "meg"}

      struct(user, unknown: "value")
      #=> %User{name: "meg"}

      struct(User, %{name: "meg"})
      #=> %User{name: "meg"}

      # String keys are ignored
      struct(User, %{"name" => "meg"})
      #=> %User{name: "john"}


  """
  def struct(struct, fields \\ []) do
    # body not decompiled
  end

  def struct!(p0) do
    # body not decompiled
  end

  @doc ~S"""
  Similar to `struct/2` but checks for key validity.

  The function `struct!/2` emulates the compile time behaviour
  of structs. This means that:

    * when building a struct, as in `struct!(SomeStruct, key: :value)`,
      it is equivalent to `%SomeStruct{key: :value}` and therefore this
      function will check if every given key-value belongs to the struct.
      If the struct is enforcing any key via `@enforce_keys`, those will
      be enforced as well;

    * when updating a struct, as in `struct!(%SomeStruct{}, key: :value)`,
      it is equivalent to `%SomeStruct{struct | key: :value}` and therefore this
      function will check if every given key-value belongs to the struct.
      However, updating structs does not enforce keys, as keys are enforced
      only when building;


  """
  def struct!(struct, fields \\ []) do
    # body not decompiled
  end

  @doc ~S"""
  A non-local return from a function.

  Check `Kernel.SpecialForms.try/1` for more information.

  Inlined by the compiler.

  """
  def throw(term) do
    # body not decompiled
  end

  @doc ~S"""
  Returns the tail of a list. Raises `ArgumentError` if the list is empty.

  It works with improper lists.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      tl([1, 2, 3, :go])
      #=> [2, 3, :go]

      tl([])
      ** (ArgumentError) argument error

      tl([:one])
      #=> []

      tl([:a, :b | :c])
      #=> [:b | :c]

      tl([:a | %{b: 1}])
      #=> %{b: 1}


  """
  def tl(list) do
    # body not decompiled
  end

  @doc ~S"""
  Returns the integer part of `number`.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> trunc(5.4)
      5

      iex> trunc(-5.99)
      -5

      iex> trunc(-5)
      -5


  """
  def trunc(number) do
    # body not decompiled
  end

  @doc ~S"""
  Returns the size of a tuple.

  This operation happens in constant time.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> tuple_size({:a, :b, :c})
      3


  """
  def tuple_size(tuple) do
    # body not decompiled
  end

  @doc ~S"""
  Updates a key in a nested structure.

  Uses the `Access` module to traverse the structures
  according to the given `keys`, unless the `key` is a
  function. If the key is a function, it will be invoked
  as specified in `get_and_update_in/3`.

  `data` is a nested structure (that is, a map, keyword
  list, or struct that implements the `Access` behaviour).
  The `fun` argument receives the value of `key` (or `nil`
  if `key` is not present) and the result replaces the value
  in the structure.

  ## Examples

      iex> users = %{"john" => %{age: 27}, "meg" => %{age: 23}}
      iex> update_in(users, ["john", :age], &(&1 + 1))
      %{"john" => %{age: 28}, "meg" => %{age: 23}}

  In case any of the entries in the middle returns `nil`,
  an error will be raised when trying to access it next.

  """
  def update_in(data, keys, fun) do
    # body not decompiled
  end

  # Private Functions

  defp unquote(:"-MACRO-binding/2-fun-0-")(p0, p1, p2, p3) do
    # body not decompiled
  end

  defp unquote(:"-MACRO-in/3-fun-0-")(p0, p1) do
    # body not decompiled
  end

  defp unquote(:"-MACRO-in/3-fun-2-")(p0, p1, p2, p3, p4, p5) do
    # body not decompiled
  end

  defp unquote(:"-MACRO-in/3-fun-3-")(p0, p1, p2, p3, p4, p5) do
    # body not decompiled
  end

  defp unquote(:"-MACRO-in/3-fun-4-")(p0, p1, p2, p3) do
    # body not decompiled
  end

  defp unquote(:"-MACRO-use/3-fun-0-")(p0, p1, p2) do
    # body not decompiled
  end

  defp unquote(:"-MACRO-|>/3-fun-0-")(p0, p1) do
    # body not decompiled
  end

  defp unquote(:"-ensure_evaled/3-fun-0-")(p0, p1, p2) do
    # body not decompiled
  end

  defp unquote(:"-expand_aliases/2-fun-0-")(p0, p1) do
    # body not decompiled
  end

  defp unquote(:"-fun.module_var/1-")(p0) do
    # body not decompiled
  end

  defp unquote(:"-get_and_update_in/3-fun-0-")(p0, p1, p2) do
    # body not decompiled
  end

  defp unquote(:"-get_and_update_in/3-fun-1-")(p0, p1, p2) do
    # body not decompiled
  end

  defp unquote(:"-get_in/2-fun-0-")(p0) do
    # body not decompiled
  end

  defp unquote(:"-get_in/2-fun-1-")(p0, p1) do
    # body not decompiled
  end

  defp unquote(:"-in_list/6-fun-0-")(p0, p1, p2, p3, p4) do
    # body not decompiled
  end

  defp unquote(:"-in_list/6-fun-1-")(p0, p1) do
    # body not decompiled
  end

  defp unquote(:"-pop_in_data/2-fun-0-")(p0) do
    # body not decompiled
  end

  defp unquote(:"-pop_in_data/2-fun-1-")(p0, p1) do
    # body not decompiled
  end

  defp unquote(:"-pop_in_data/2-fun-2-")(p0, p1) do
    # body not decompiled
  end

  defp unquote(:"-put_in/3-fun-0-")(p0, p1) do
    # body not decompiled
  end

  defp unquote(:"-split_words/3-fun-0-")(p0) do
    # body not decompiled
  end

  defp unquote(:"-struct!/2-fun-0-")(p0, p1) do
    # body not decompiled
  end

  defp unquote(:"-struct/2-fun-0-")(p0, p1) do
    # body not decompiled
  end

  defp unquote(:"-unescape_list_tokens/1-fun-0-")(p0) do
    # body not decompiled
  end

  defp unquote(:"-update_in/3-fun-0-")(p0, p1) do
    # body not decompiled
  end

  defp unquote(:"-validate_variable_only_args!/2-fun-0-")(p0, p1) do
    # body not decompiled
  end

  defp alias_meta(p0) do
    # body not decompiled
  end

  defp assert_module_scope(p0, p1, p2) do
    # body not decompiled
  end

  defp assert_no_function_scope(p0, p1, p2) do
    # body not decompiled
  end

  defp assert_no_match_or_guard_scope(p0, p1) do
    # body not decompiled
  end

  defp build_boolean_check(p0, p1, p2, p3) do
    # body not decompiled
  end

  defp build_if(p0, p1) do
    # body not decompiled
  end

  defp build_unless(p0, p1) do
    # body not decompiled
  end

  defp comp(p0, p1, p2, p3, p4) do
    # body not decompiled
  end

  defp decreasing_compare(p0, p1, p2) do
    # body not decompiled
  end

  defp define(p0, p1, p2, p3) do
    # body not decompiled
  end

  defp define_guard(p0, p1, p2) do
    # body not decompiled
  end

  defp do_at(p0, p1, p2, p3, p4) do
    # body not decompiled
  end

  defp ensure_evaled(p0, p1, p2) do
    # body not decompiled
  end

  defp ensure_evaled_element(p0, p1) do
    # body not decompiled
  end

  defp ensure_evaled_tail(p0, p1, p2) do
    # body not decompiled
  end

  defp ensure_evaled_var(p0, p1) do
    # body not decompiled
  end

  defp expand_aliases(p0, p1) do
    # body not decompiled
  end

  defp expand_concat_argument(p0, p1, p2) do
    # body not decompiled
  end

  defp expand_module(p0, p1, p2) do
    # body not decompiled
  end

  defp extract_calendar(p0) do
    # body not decompiled
  end

  defp extract_concatenations(p0, p1) do
    # body not decompiled
  end

  defp in_list(p0, p1, p2, p3, p4, p5) do
    # body not decompiled
  end

  defp in_range(p0, p1, p2) do
    # body not decompiled
  end

  defp in_range_literal(p0, p1, p2) do
    # body not decompiled
  end

  defp in_var(p0, p1, p2) do
    # body not decompiled
  end

  defp increasing_compare(p0, p1, p2) do
    # body not decompiled
  end

  defp invalid_concat_left_argument_error(p0) do
    # body not decompiled
  end

  defp invalid_match!(p0) do
    # body not decompiled
  end

  defp maybe_atomize_calendar(p0, p1) do
    # body not decompiled
  end

  defp maybe_raise!(p0, p1, p2, p3) do
    # body not decompiled
  end

  defp module_var(p0) do
    # body not decompiled
  end

  defp nest_get_and_update_in(p0, p1) do
    # body not decompiled
  end

  defp nest_get_and_update_in(p0, p1, p2) do
    # body not decompiled
  end

  defp nest_pop_in(p0, p1) do
    # body not decompiled
  end

  defp nest_pop_in(p0, p1, p2) do
    # body not decompiled
  end

  defp nest_update_in(p0, p1) do
    # body not decompiled
  end

  defp nest_update_in(p0, p1, p2) do
    # body not decompiled
  end

  defp optimize_boolean(p0) do
    # body not decompiled
  end

  defp parse_with_calendar!(p0, p1, p2) do
    # body not decompiled
  end

  defp pop_in_data(p0, p1) do
    # body not decompiled
  end

  defp proper_start?(p0) do
    # body not decompiled
  end

  defp raise_on_invalid_args_in_2(p0) do
    # body not decompiled
  end

  defp range(p0, p1, p2) do
    # body not decompiled
  end

  defp split_words(p0, p1, p2) do
    # body not decompiled
  end

  defp struct(p0, p1, p2) do
    # body not decompiled
  end

  defp to_calendar_struct(p0, p1) do
    # body not decompiled
  end

  defp typespec?(p0) do
    # body not decompiled
  end

  defp unescape_list_tokens(p0) do
    # body not decompiled
  end

  defp unescape_tokens(p0) do
    # body not decompiled
  end

  defp unescape_tokens(p0, p1) do
    # body not decompiled
  end

  defp unnest(p0, p1, p2, p3) do
    # body not decompiled
  end

  defp validate_struct!(p0, p1, p2) do
    # body not decompiled
  end

  defp validate_variable_only_args!(p0, p1) do
    # body not decompiled
  end

  defp wrap_binding(p0, p1) do
    # body not decompiled
  end

  defp wrap_concatenation(p0, p1, p2) do
    # body not decompiled
  end
end
